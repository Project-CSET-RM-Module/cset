/*
Run this script on:

        (localdb)\v11.0.CSETWeb10120    -  This database will be modified

to synchronize it with:

        (localdb)\v11.0.CSETWeb10200

You are recommended to back up your database before running this script

Script created by SQL Compare version 14.4.4.16824 from Red Gate Software Ltd at 4/14/2021 7:31:02 AM

*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DeleteUser]'
GO
-- =============================================
-- Author:		CSET Team
-- Create date: 2021-04-08
-- Description:	Deletes a user from the CSET database.  
--              Supply a user ID argument to delete a single user, or
--              use an argument of -1 to delete all users.
-- =============================================
CREATE PROCEDURE [dbo].[DeleteUser]
	@userid varchar(10)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if @userid < 0
		BEGIN
			delete from [ASSESSMENT_CONTACTS];
			delete from [FINDING_CONTACT];
			delete from [USER_SECURITY_QUESTIONS];
			delete from [USERS];
		END
	ELSE
		BEGIN
			select [assessment_contact_id] into #xyz from [ASSESSMENT_CONTACTS] where [userid] = @userid;
			delete from [FINDING_CONTACT] where [Assessment_Contact_Id] in (select [assessment_contact_id] from #xyz);
			delete from [ASSESSMENT_CONTACTS] where [Assessment_Contact_Id] in (select [assessment_contact_id] from #xyz);

			delete from [USER_SECURITY_QUESTIONS] where [userid] = @userid;

			delete from [USERS] where [UserId] = @userid;
		END
END


GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DeleteAssessment]'
GO
-- =============================================
-- Author:		CSET Team
-- Create date: 2021-04-08
-- Description:	Deletes a user from the CSET database
--              Supply an assessment ID argument to delete a single assessment, or
--              use an argument of -1 to delete all assessments.
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAssessment]
	@assessmentid int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if @assessmentid < 0
		BEGIN
			delete from [DIAGRAM_CONTAINER]
			delete from [MATURITY_DOMAIN_REMARKS]
			delete from [DOCUMENT_FILE]
			delete from ASSESSMENTS;
		END
	ELSE
		BEGIN
			delete from [DIAGRAM_CONTAINER] where [Assessment_Id] = @assessmentid;
			delete from [MATURITY_DOMAIN_REMARKS] where [Assessment_Id] = @assessmentid;
			delete from [DOCUMENT_FILE] where [Assessment_Id] = @assessmentid;
			delete from [ASSESSMENTS] where [Assessment_Id] = @assessmentid;
		END
END


GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
-- This statement writes to the SQL Server Log so SQL Monitor can show this deployment.
IF HAS_PERMS_BY_NAME(N'sys.xp_logevent', N'OBJECT', N'EXECUTE') = 1
BEGIN
    DECLARE @databaseName AS nvarchar(2048), @eventMessage AS nvarchar(2048)
    SET @databaseName = REPLACE(REPLACE(DB_NAME(), N'\', N'\\'), N'"', N'\"')
    SET @eventMessage = N'Redgate SQL Compare: { "deployment": { "description": "Redgate SQL Compare deployed to ' + @databaseName + N'", "database": "' + @databaseName + N'" }}'
    EXECUTE sys.xp_logevent 55000, @eventMessage
END
GO
DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	PRINT 'The database update failed'
END
GO
