/*
Run this script on:

        (localdb)\v11.0.CSETWeb10210    -  This database will be modified

to synchronize it with:

        (localdb)\v11.0.CSETWeb10300

You are recommended to back up your database before running this script

Script created by SQL Compare version 14.5.1.18536 from Red Gate Software Ltd at 6/29/2021 1:03:18 PM

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
PRINT N'Altering [dbo].[MATURITY_GROUPINGS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[MATURITY_GROUPINGS] ALTER COLUMN [Title] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[MATURITY_GROUPINGS] ALTER COLUMN [Description] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ANSWER_ORDER]'
GO
CREATE TABLE [dbo].[ANSWER_ORDER]
(
[Answer_Text] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[answer_order] [int] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ANSWER_ORDER] on [dbo].[ANSWER_ORDER]'
GO
ALTER TABLE [dbo].[ANSWER_ORDER] ADD CONSTRAINT [PK_ANSWER_ORDER] PRIMARY KEY CLUSTERED ([Answer_Text])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_getRRASummary]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_getRRASummary]
@assessment_id int
AS
BEGIN
	SET NOCOUNT ON;

	select a.Answer_Full_Name, a.Level_Name, a.Answer_Text, 
		isnull(m.qc,0) as [qc],
		isnull(m.Total,0) as [Total], 
		IsNull(Cast(IsNull(Round((Cast((qc) as float)/(IsNull(NullIf(Total,0),1)))*100, 2), 0) as float),0) as [Percent] 
	from 
	(select * from MATURITY_LEVELS, ANSWER_LOOKUP 
	where Maturity_Model_Id = 5 and answer_text in ('Y','N','U') ) a left join (
	SELECT l.Level_Name, a.Answer_Text, isnull(count(question_or_requirement_id),0) qc , SUM(count(Question_Or_Requirement_Id)) OVER(PARTITION BY Level_Name) AS Total
			FROM Answer_Maturity a 
			join MATURITY_LEVELS l on a.Maturity_Level = l.Maturity_Level_Id
			where a.Assessment_Id = @assessment_id and Is_Maturity = 1 --@assessment_id 
			group by a.Assessment_Id, l.Maturity_Level_Id, l.Level_Name, a.Answer_Text)
			m on a.Level_Name=m.Level_Name and a.Answer_Text=m.Answer_Text		
	JOIN ANSWER_ORDER o on a.Answer_Text=o.answer_text
	order by a.Level,o.answer_order

END



GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_getRRASummaryOverall]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_getRRASummaryOverall]
@assessment_id int
AS
BEGIN
	SET NOCOUNT ON;

	select a.Answer_Full_Name, a.Answer_Text, 
		isnull(m.qc,0) as [qc],
		isnull(m.Total,0) as [Total], 
		IsNull(Cast(IsNull(Round((Cast((qc) as float)/(IsNull(NullIf(Total,0),1)))*100, 2), 0) as float),0) as [Percent] 
	from 
	(select * from ANSWER_LOOKUP 
	where answer_text in ('Y','N','U') ) a left join (
SELECT a.Answer_Text, isnull(count(question_or_requirement_id),0) qc , SUM(count(Question_Or_Requirement_Id)) OVER(PARTITION BY assessment_id) AS Total
			FROM Answer_Maturity a 
			join MATURITY_LEVELS l on a.Maturity_Level = l.Maturity_Level_Id
			where a.Assessment_Id = @assessment_id and Is_Maturity = 1 --@assessment_id 
			group by a.Assessment_Id, a.Answer_Text)
			m on a.Answer_Text=m.Answer_Text		
	JOIN ANSWER_ORDER o on a.Answer_Text=o.answer_text
	order by o.answer_order

END



GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_getRRASummaryByGoalOverall]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_getRRASummaryByGoalOverall]
@assessment_id int
AS
BEGIN
	SET NOCOUNT ON;

	select a.Title, 
		isnull(m.qc,0) as [qc],
		isnull(m.Total,0) as [Total], 
		IsNull(Cast(IsNull(Round((Cast((qc) as float)/(IsNull(NullIf(Total,0),1)))*100, 2), 0) as float),0) as [Percent] 
	from 	
	(select * from MATURITY_GROUPINGS
		where Maturity_Model_Id = 5 and Group_Level = 2) a left join (
		SELECT g.Title, isnull(count(question_or_requirement_id),0) qc , SUM(count(Title)) OVER(PARTITION BY assessment_id) AS Total
			FROM Answer_Maturity a 
			join (
				select q.Mat_Question_Id, g.* 
				from MATURITY_QUESTIONS q join MATURITY_GROUPINGS g on q.Grouping_Id=g.Grouping_Id and q.Maturity_Model_Id=g.Maturity_Model_Id
				where g.Maturity_Model_Id=5 and Group_Level = 2
			) g on a.Question_Or_Requirement_Id=g.Mat_Question_Id
			where a.Assessment_Id = @assessment_id and Is_Maturity = 1 --@assessment_id 
			group by a.Assessment_Id, g.Title)
			m on a.Title=m.Title	
	order by a.Sequence

END

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_getRRASummaryByGoal]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_getRRASummaryByGoal]
@assessment_id int
AS
BEGIN
	SET NOCOUNT ON;

	select a.Answer_Full_Name, a.Title, a.Sequence, a.Answer_Text, 
		isnull(m.qc,0) as [qc],
		isnull(m.Total,0) as [Total], 
		IsNull(Cast(IsNull(Round((Cast((qc) as float)/(IsNull(NullIf(Total,0),1)))*100, 2), 0) as float),0) as [Percent] 
	from 	
	(select * from MATURITY_GROUPINGS, ANSWER_LOOKUP 
		where Maturity_Model_Id = 5 and answer_text in ('Y','N','U')  and Group_Level = 2) a left join (
		SELECT g.Title, g.Sequence, a.Answer_Text, isnull(count(question_or_requirement_id),0) qc , SUM(count(Answer_Text)) OVER(PARTITION BY Title) AS Total
			FROM Answer_Maturity a 
			join (
				select q.Mat_Question_Id, g.* 
				from MATURITY_QUESTIONS q join MATURITY_GROUPINGS g on q.Grouping_Id=g.Grouping_Id and q.Maturity_Model_Id = g.Maturity_Model_Id
				where g.Maturity_Model_Id=5 and Group_Level = 2
			) g on a.Question_Or_Requirement_Id = g.Mat_Question_Id
			where a.Assessment_Id = @assessment_id and Is_Maturity = 1 --@assessment_id 			
			group by a.Assessment_Id, g.Title, g.Sequence, a.Answer_Text)
			m on a.Title = m.Title and a.Answer_Text = m.Answer_Text
	JOIN ANSWER_ORDER o on a.Answer_Text = o.answer_text
	order by a.Sequence, o.answer_order

END

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_getRRASummaryPage]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_getRRASummaryPage]	
@assessment_id int	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    EXECUTE [dbo].[FillEmptyQuestionsForAnalysis]  @Assessment_Id	
	execute [dbo].[usp_getRRASummaryOverall] @assessment_id
	execute [dbo].[usp_getRRASummary] @assessment_id
	execute [dbo].[usp_getRRASummaryByGoal] @assessment_id
	execute [dbo].[usp_getRRASummaryByGoalOverall] @assessment_id

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
