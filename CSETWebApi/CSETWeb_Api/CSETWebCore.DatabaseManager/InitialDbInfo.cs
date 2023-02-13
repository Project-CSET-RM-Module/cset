//////////////////////////////// 
// 
//   Copyright 2023 Battelle Energy Alliance, LLC  
// 
// 
//////////////////////////////// 
using System;
using System.Data;
using System.IO;
using System.Reflection;
using log4net;
using Microsoft.Data.SqlClient;

namespace CSETWebCore.DatabaseManager
{
    public class InitialDbInfo
    {
        public InitialDbInfo(string connectionString, string databaseCode)
        {
            ConnectionString = connectionString;
            DatabaseCode = databaseCode;
            Exists = true;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = conn.CreateCommand();
                    cmd.CommandText = "SELECT type_desc AS FileType, Physical_Name AS Location FROM sys.master_files mf INNER JOIN sys.databases db ON db.database_id = mf.database_id where db.name = '" + DatabaseCode+"'";

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var type = reader.GetString(0);
                        var path = reader.GetString(1);
                        switch (type)
                        {
                            case "ROWS":
                                MDF = path;
                                break;
                            case "LOG":
                                LDF = path;
                                break;
                        }
                    }

                    reader.Close();

                    if (MDF == null || LDF == null)
                    { 
                        Exists = false;
                    } 
                    else if (!File.Exists(MDF) || !File.Exists(LDF))
                    { 
                        cmd.CommandText = "EXEC sp_detach_db '" + DatabaseCode + "', 'true'";
                        cmd.ExecuteNonQuery();
                        Exists = false;
                    }
                }

            }
            catch (SqlException)
            {
                // We are only concerned here if SQL LocalDb 2019 (uses CurrentMasterConnectionString) is not accessible
                // (2012 might not be installed, and that's ok--just assume the db does not exist)
                if (connectionString.Equals(DbManager.CurrentMasterConnectionString))
                {
                    throw;
                }

                Exists = false;
            }
        }

        /// <summary>
        /// Tries to find the web database and get its version.
        /// </summary>
        /// <returns></returns>
        public Version GetInstalledDBVersion()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = conn.CreateCommand();
                    cmd.CommandText = "SELECT name FROM master..sysdatabases where name ='" + DatabaseCode + "'";
                    SqlDataReader reader = cmd.ExecuteReader();
                    // If CSETWeb database does not exist return null
                    if (!reader.HasRows)
                    {
                        return null;
                    }
                }

                string newConnectionString = ConnectionString.Replace("Master", DatabaseCode);

                using (SqlConnection conn = new SqlConnection(newConnectionString))
                {
                    conn.Open();

                    Version v = GetDBVersion(conn);
                    return v;
                }
            }
            catch 
            {
                return null;
            }
            
        }

        private Version GetDBVersion(SqlConnection conn)
        {
            DataTable versionTable = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT [Version_Id], [Cset_Version] FROM [CSET_VERSION]", conn);
            adapter.Fill(versionTable);

            var version = new Version(versionTable.Rows[0]["Cset_Version"].ToString());
            return version;
        }

        public static DirectoryInfo GetExecutingDirectory()
        {
            string path = Assembly.GetAssembly(typeof(DbManager)).Location;
            return new FileInfo(path).Directory;
        }

        public string MDF { get; }
        public string LDF { get; }    
        public string ConnectionString { get; }
        public string DatabaseCode { get; }
        public bool Exists { get; }
    }
}
