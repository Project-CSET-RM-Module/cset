//////////////////////////////// 
// 
//   Copyright 2023 Battelle Energy Alliance, LLC  
// 
// 
//////////////////////////////// 
using System;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Principal;
using System.Text.RegularExpressions;
using CSETWebCore.DataLayer.Model;
using CSETWebCore.Interfaces.Helpers;
using CSETWebCore.Interfaces.User;
using CSETWebCore.Model.Authentication;
using CSETWebCore.Model.Contact;
using CSETWebCore.Model.User;
using Microsoft.AspNetCore.Hosting;


namespace CSETWebCore.Helpers
{
    public class UserAuthentication : IUserAuthentication
    {
        private readonly IPasswordHash _password;
        private readonly IUserBusiness _userBusiness;
        private readonly ILocalInstallationHelper _localInstallationHelper;
        private readonly ITokenManager _transactionSecurity;
        private CSETContext _context;

        public UserAuthentication(IPasswordHash password, IUserBusiness userBusiness,
            ILocalInstallationHelper localInstallationHelper, ITokenManager transactionSecurity, CSETContext context)
        {
            _password = password;
            _transactionSecurity = transactionSecurity;
            _userBusiness = userBusiness;
            _localInstallationHelper = localInstallationHelper;
            _context = context;
        }

        public LoginResponse Authenticate(Login login)
        {
            // Ensure that we have what we need
            if (login == null || string.IsNullOrEmpty(login.Email) || string.IsNullOrEmpty(login.Password))
            {
                return null;
            }

            USERS loginUser = null;

            // Read directly from the database; UserManager does not read password and salt, in order to keep them more private
            loginUser = _context.USERS.Where(x => x.PrimaryEmail == login.Email).FirstOrDefault();

            if (loginUser == null)
            {
                return null;
            }


            // Validate the supplied password against the hashed password and its salt
            bool passwordIsValid = _password.ValidatePassword(login.Password, loginUser.Password, loginUser.Salt);

            if (!passwordIsValid)
            {
                return null;
            }


            // Build response object
            LoginResponse resp = new LoginResponse
            {
                UserId = loginUser.UserId,
                Email = login.Email,
                UserFirstName = loginUser.FirstName,
                UserLastName = loginUser.LastName,
                IsSuperUser = loginUser.IsSuperUser,
                ResetRequired = loginUser.PasswordResetRequired ?? true,
                ExportExtension = IOHelper.GetExportFileExtension(login.Scope),
                ImportExtensions = IOHelper.GetImportFileExtensions(login.Scope),
                LinkerTime = new BuildNumberHelper().GetLinkerTime()
            };


            // The password is valid, but is it expired?
            var isExpired = new PasswordExpiration().IsExpired(_context, loginUser.UserId, loginUser.Password);
            if (isExpired)
            {
                resp.IsPasswordExpired = true;
                return resp;
            }


            // Generate a token for this user and add to the response
            string token = _transactionSecurity.GenerateToken(loginUser.UserId, null, login.TzOffset, -1, null, null, login.Scope);
            resp.Token = token;


            return resp;
        }


        /// <summary>
        /// Emulates credential authentication without requiring credentials.
        /// The Windows file system is consulted to see if a certain file was placed there
        /// during the stand-alone install process.  
        /// </summary>
        /// <param name="login"></param>
        /// <returns></returns>
        public LoginResponse AuthenticateStandalone(Login login, ITokenManager tokenManager)
        {
            int? assessmentId = ((TokenManager)tokenManager).GetAssessmentId();

            assessmentId = assessmentId == 0 ? null : assessmentId;

            int userIdSO = 100;
            string primaryEmailSO = "";

            // Read the file system for the LOCAL-INSTALLATION file put there at install time
            if (!_localInstallationHelper.IsLocalInstallation())
            {
                return null;
            }


                string name = null;

                name = Environment.UserName;
                name = string.IsNullOrWhiteSpace(name) ? "Local" : name;

                primaryEmailSO = name;
                //check for legacy default email for local installation and set to new standard
                var userOrg = _context.USERS.Where(x => x.PrimaryEmail == primaryEmailSO + "@myorg.org").FirstOrDefault();
                if (userOrg != null)
                {
                    string tmp = userOrg.PrimaryEmail.Split('@')[0];
                    userOrg.PrimaryEmail = tmp;
                    if (_context.USERS.Where(x => x.PrimaryEmail == tmp).FirstOrDefault() == null)
                        _context.SaveChanges();
                    primaryEmailSO = userOrg.PrimaryEmail;
                }
                else
                {
                    //check for legacy default local usernames (in the form HOSTNAME\USERNAME)
                    string regex = @"^.*(\\)" + primaryEmailSO + "$";
                    var allUsers = _context.USERS.ToList();
                    var legacyUser = allUsers.Where(x => Regex.Match(x.PrimaryEmail, regex).Success).FirstOrDefault();
                    if (legacyUser != null)
                    {
                        string tmp = legacyUser.PrimaryEmail.Split('\\')[1];
                        legacyUser.PrimaryEmail = tmp;
                        if (_context.USERS.Where(x => x.PrimaryEmail == tmp).FirstOrDefault() == null)
                            _context.SaveChanges();
                        primaryEmailSO = legacyUser.PrimaryEmail;
                    }
                }


                var user = _context.USERS.Where(x => x.PrimaryEmail == primaryEmailSO).FirstOrDefault();
                if (user == null)
                {
                    UserDetail ud = new UserDetail()
                    {
                        Email = primaryEmailSO,
                        FirstName = name,
                        LastName = ""
                    };
                    UserCreateResponse userCreateResponse = _userBusiness.CreateUser(ud, _context);

                    _context.SaveChanges();
                    //update the userid 1 to the new user
                    var tempu = _context.USERS.Where(x => x.PrimaryEmail == primaryEmailSO).FirstOrDefault();
                    if (tempu != null)
                        userIdSO = tempu.UserId;
                    _localInstallationHelper.determineIfUpgradedNeededAndDoSo(userIdSO, _context);
                }
                else
                {
                    userIdSO = user.UserId;
                }

                if (string.IsNullOrEmpty(primaryEmailSO))
                {
                    return null;
                }


                // Generate a token for this user
                string token = _transactionSecurity.GenerateToken(userIdSO, null, login.TzOffset, -1, assessmentId, null, login.Scope);

                // Build response object
                LoginResponse resp = new LoginResponse
                {
                    Token = token,
                    Email = primaryEmailSO,
                    UserFirstName = name,
                    UserLastName = "",
                    IsSuperUser = false,
                    ResetRequired = false,
                    UserId = userIdSO,
                    ExportExtension = IOHelper.GetExportFileExtension(login.Scope),
                    ImportExtensions = IOHelper.GetImportFileExtensions(login.Scope),
                    LinkerTime = new BuildNumberHelper().GetLinkerTime()
                };


                return resp;
        }


        /// <summary>
        /// Generates a 10-character key for anonymous access.
        /// The alpha characters are all caps.
        /// </summary>
        /// <returns></returns>
        public string GenerateAccessKey()
        {
            var key = "";
            var keyIsUnique = false;

            while (!keyIsUnique)
            {
                key = UniqueIdGenerator.Instance.GetBase32UniqueId(10).ToUpper();
                if (_context.ACCESS_KEY.Count(x => x.AccessKey == key) == 0)
                {
                    keyIsUnique = true;
                }
            }

            var dbAK = new ACCESS_KEY() 
            {
                AccessKey = key,
                GeneratedDate = DateTime.UtcNow
            };

            _context.ACCESS_KEY.Add(dbAK);
            _context.SaveChanges();

            return key;
        }


        /// <summary>
        /// Emulates credential authentication solely by providing
        /// a valid Access Key.
        /// </summary>
        /// <returns></returns>
        public LoginResponse AuthenticateAccessKey(AnonymousLogin login)
        {
            var ak = _context.ACCESS_KEY.FirstOrDefault(x => x.AccessKey == login.AccessKey);

            if (ak == null)
            {
                // supplied access key does not exist
                return null;
            }

            var resp = new LoginResponse()
            {
                ExportExtension = IOHelper.GetExportFileExtension(login.Scope),
                ImportExtensions = IOHelper.GetImportFileExtensions(login.Scope),
                LinkerTime = new BuildNumberHelper().GetLinkerTime()
            };

            // Generate a token for this user and add to the response
            string token = _transactionSecurity.GenerateToken(null, login.AccessKey, login.TzOffset, -1, null, null, login.Scope);
            resp.Token = token;

            return resp;
        }
    }
}