/*
Run this script on:

        (localdb)\v11.0.CSETWeb    -  This database will be modified

to synchronize it with:

        (localdb)\v11.0.CSETWeb920

You are recommended to back up your database before running this script

Script created by SQL Compare version 14.0.0.12866 from Red Gate Software Ltd at 10/28/2019 6:03:04 PM

*/
DROP TABLE VISIO_MAPPING;
DROP TABLE DIAGRAM_TYPES;
DROP TABLE DIAGRAM_OBJECT_TYPES;
DROP TABLE SHAPE_TYPES

DROP TABLE [dbo].[COMPONENT_SYMBOLS_GM_TO_CSET]
DROP TABLE [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS]
DROP Table [dbo].COMPONENT_STANDARD_QUESTIONS
DROP Table [dbo].COMPONENT_QUESTIONS
DROP TABLE [dbo].[COMPONENT_SYMBOLS]
DROP TABLE [dbo].[DIAGRAM_TYPES_XML]
GO

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
PRINT N'Dropping extended properties'
GO
BEGIN TRY
	EXEC sp_dropextendedproperty N'MS_Description', 'SCHEMA', N'dbo', 'TABLE', N'ANSWER', 'COLUMN', N'Component_Id'
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_dropextendedproperty N'MS_Description', 'SCHEMA', N'dbo', 'TABLE', N'SUB_CATEGORY_ANSWERS', 'COLUMN', N'Component_Id'
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
PRINT N'Dropping foreign keys from [dbo].[FINANCIAL_QUESTIONS]'
GO
ALTER TABLE [dbo].[FINANCIAL_QUESTIONS] DROP CONSTRAINT [FK_FINANCIAL_QUESTIONS_NEW_QUESTION]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[FINANCIAL_REQUIREMENTS]'
GO
ALTER TABLE [dbo].[FINANCIAL_REQUIREMENTS] DROP CONSTRAINT [FK_FINANCIAL_REQUIREMENTS_NEW_REQUIREMENT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[NEW_QUESTION_SETS]'
GO
ALTER TABLE [dbo].[NEW_QUESTION_SETS] DROP CONSTRAINT [FK_NEW_QUESTION_SETS_NEW_QUESTION]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[NEW_REQUIREMENT]'
GO
ALTER TABLE [dbo].[NEW_REQUIREMENT] DROP CONSTRAINT [FK_NEW_REQUIREMENT_NCSF_Category]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[NEW_REQUIREMENT] DROP CONSTRAINT [FK_NEW_REQUIREMENT_QUESTION_GROUP_HEADING]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[NEW_REQUIREMENT] DROP CONSTRAINT [FK_NEW_REQUIREMENT_SETS]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[NEW_REQUIREMENT] DROP CONSTRAINT [FK_NEW_REQUIREMENT_STANDARD_CATEGORY]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[PARAMETER_REQUIREMENTS]'
GO
ALTER TABLE [dbo].[PARAMETER_REQUIREMENTS] DROP CONSTRAINT [FK_Parameter_Requirements_NEW_REQUIREMENT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[QUESTION_SUB_QUESTION]'
GO
ALTER TABLE [dbo].[QUESTION_SUB_QUESTION] DROP CONSTRAINT [FK_QUESTION_SUB_QUESTION_NEW_QUESTION]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[REQUIREMENT_QUESTIONS_SETS]'
GO
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS_SETS] DROP CONSTRAINT [FK_REQUIREMENT_QUESTIONS_SETS_NEW_QUESTION]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS_SETS] DROP CONSTRAINT [FK_REQUIREMENT_QUESTIONS_SETS_NEW_REQUIREMENT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[REQUIREMENT_REFERENCES]'
GO
ALTER TABLE [dbo].[REQUIREMENT_REFERENCES] DROP CONSTRAINT [FK_REQUIREMENT_REFERENCES_NEW_REQUIREMENT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[REQUIREMENT_SOURCE_FILES]'
GO
ALTER TABLE [dbo].[REQUIREMENT_SOURCE_FILES] DROP CONSTRAINT [FK_REQUIREMENT_SOURCE_FILES_NEW_REQUIREMENT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[ANSWER]'
GO
ALTER TABLE [dbo].[ANSWER] DROP CONSTRAINT [FK_ANSWER_ASSESSMENTS]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[NERC_RISK_RANKING]'
GO
ALTER TABLE [dbo].[NERC_RISK_RANKING] DROP CONSTRAINT [FK_NERC_RISK_RANKING_NEW_REQUIREMENT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[REQUIREMENT_LEVELS]'
GO
ALTER TABLE [dbo].[REQUIREMENT_LEVELS] DROP CONSTRAINT [FK_REQUIREMENT_LEVELS_NEW_REQUIREMENT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[REQUIREMENT_QUESTIONS]'
GO
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS] DROP CONSTRAINT [FK_REQUIREMENT_QUESTIONS_NEW_REQUIREMENT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[REQUIREMENT_SETS]'
GO
ALTER TABLE [dbo].[REQUIREMENT_SETS] DROP CONSTRAINT [FK_REQUIREMENT_SETS_NEW_REQUIREMENT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[SUB_CATEGORY_ANSWERS]'
GO
ALTER TABLE [dbo].[SUB_CATEGORY_ANSWERS] DROP CONSTRAINT [FK_SUB_CATEGORY_ANSWERS_ASSESSMENTS]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[SUB_CATEGORY_ANSWERS] DROP CONSTRAINT [FK_SUB_CATEGORY_ANSWERS_UNIVERSAL_SUB_CATEGORY_HEADINGS]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[ASSESSMENT_CONTACTS]'
GO
ALTER TABLE [dbo].[ASSESSMENT_CONTACTS] DROP CONSTRAINT [FK_ASSESSMENT_CONTACTS_USERS]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[ASSESSMENTS]'
GO
ALTER TABLE [dbo].[ASSESSMENTS] DROP CONSTRAINT [FK_ASSESSMENTS_USERS]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[USER_SECURITY_QUESTIONS]'
GO
ALTER TABLE [dbo].[USER_SECURITY_QUESTIONS] DROP CONSTRAINT [FK_USER_SECURITY_QUESTIONS_USERS]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[ASSESSMENTS_REQUIRED_DOCUMENTATION]'
GO
ALTER TABLE [dbo].[ASSESSMENTS_REQUIRED_DOCUMENTATION] DROP CONSTRAINT [CK_ASSESSMENTS_REQUIRED_DOCUMENTATION]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[NEW_REQUIREMENT]'
GO
ALTER TABLE [dbo].[NEW_REQUIREMENT] DROP CONSTRAINT [PK_NEW_REQUIREMENT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[QUESTION_SUB_QUESTION]'
GO
ALTER TABLE [dbo].[QUESTION_SUB_QUESTION] DROP CONSTRAINT [PK_Question_Sub_Question_1]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[SUB_CATEGORY_ANSWERS]'
GO
ALTER TABLE [dbo].[SUB_CATEGORY_ANSWERS] DROP CONSTRAINT [PK_SUB_CATEGORY_ANSWERS]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[USERS]'
GO
ALTER TABLE [dbo].[USERS] DROP CONSTRAINT [IX_USERS]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[ANSWER]'
GO
ALTER TABLE [dbo].[ANSWER] DROP CONSTRAINT [DF_ANSWER_Component_Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[ASSESSMENTS_REQUIRED_DOCUMENTATION]'
GO
ALTER TABLE [dbo].[ASSESSMENTS_REQUIRED_DOCUMENTATION] DROP CONSTRAINT [DF_ASSESSMENTS_REQUIRED_DOCUMENTATION_Answer]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[QUESTION_SUB_QUESTION]'
GO
ALTER TABLE [dbo].[QUESTION_SUB_QUESTION] DROP CONSTRAINT [DF_Question_Sub_Question_List_Order]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[SUB_CATEGORY_ANSWERS]'
GO
ALTER TABLE [dbo].[SUB_CATEGORY_ANSWERS] DROP CONSTRAINT [DF_SUB_CATEGORY_ANSWERS_Component_Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [IX_ANSWER] from [dbo].[ANSWER]'
GO
DROP INDEX [IX_ANSWER] ON [dbo].[ANSWER]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [dbo].[XML_Output_For_Schema]'
GO
DROP PROCEDURE [dbo].[XML_Output_For_Schema]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [dbo].[XML_Output]'
GO
DROP PROCEDURE [dbo].[XML_Output]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [dbo].[usp_GetNetworkWarningsPage]'
GO
DROP PROCEDURE [dbo].[usp_GetNetworkWarningsPage]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [dbo].[usp_getNetworkWarnings]'
GO
DROP PROCEDURE [dbo].[usp_getNetworkWarnings]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [dbo].[QUESTION_SUB_QUESTION]'
GO
DROP TABLE [dbo].[QUESTION_SUB_QUESTION]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[ASSESSMENTS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[ASSESSMENTS] ADD
[MatDetail_targetBandOnly] [bit] NOT NULL CONSTRAINT [DF_ASSESSMENTS_MatDetail_targetBandOnly] DEFAULT ((1)),
[Diagram_Markup] [xml] NULL,
[LastUsedComponentNumber] [int] NOT NULL CONSTRAINT [DF_ASSESSMENTS_LastUsedComponentNumber] DEFAULT ((0)),
[Diagram_Image] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[FINANCIAL_DOMAIN_FILTERS]'
GO
CREATE TABLE [dbo].[FINANCIAL_DOMAIN_FILTERS]
(
[Assessment_Id] [int] NOT NULL,
[DomainId] [int] NOT NULL,
[B] [bit] NOT NULL CONSTRAINT [DF_FINANCIAL_DOMAIN_FILTERS_B] DEFAULT ((0)),
[E] [bit] NOT NULL CONSTRAINT [DF_FINANCIAL_DOMAIN_FILTERS_E] DEFAULT ((0)),
[Int] [bit] NOT NULL CONSTRAINT [DF_FINANCIAL_DOMAIN_FILTERS_Int] DEFAULT ((0)),
[A] [bit] NOT NULL CONSTRAINT [DF_FINANCIAL_DOMAIN_FILTERS_A] DEFAULT ((0)),
[Inn] [bit] NOT NULL CONSTRAINT [DF_FINANCIAL_DOMAIN_FILTERS_Inn] DEFAULT ((0))
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FINANCIAL_DOMAIN_FILTERS] on [dbo].[FINANCIAL_DOMAIN_FILTERS]'
GO
ALTER TABLE [dbo].[FINANCIAL_DOMAIN_FILTERS] ADD CONSTRAINT [PK_FINANCIAL_DOMAIN_FILTERS] PRIMARY KEY CLUSTERED  ([Assessment_Id], [DomainId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[FiltersNormalized]'
GO
CREATE TABLE [dbo].[FiltersNormalized]
(
[Assessment_Id] [int] NOT NULL,
[DomainId] [int] NOT NULL,
[MaturityId] [int] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_FiltersNormalized] on [dbo].[FiltersNormalized]'
GO
ALTER TABLE [dbo].[FiltersNormalized] ADD CONSTRAINT [PK_FiltersNormalized] PRIMARY KEY CLUSTERED  ([Assessment_Id], [DomainId], [MaturityId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating trigger [dbo].[Move_Domain_Filters_To_Normal_Form] on [dbo].[FINANCIAL_DOMAIN_FILTERS]'
GO
CREATE trigger [dbo].[Move_Domain_Filters_To_Normal_Form]
on [dbo].[FINANCIAL_DOMAIN_FILTERS]
	after UPDATE, INSERT, DELETE
as
--delete first
    delete filtersnormalized from deleted
	where filtersnormalized.Assessment_Id = deleted.assessment_id
		 and filtersnormalized.DomainId = deleted.DomainId 
		 and maturityid = 1		 
	delete filtersnormalized from deleted
	where filtersnormalized.Assessment_Id = deleted.assessment_id
		 and filtersnormalized.DomainId = deleted.DomainId 
		 and maturityid = 2		 
	delete filtersnormalized from deleted
	where filtersnormalized.Assessment_Id = deleted.assessment_id
		 and filtersnormalized.DomainId = deleted.DomainId 
		 and maturityid = 3		 
	delete filtersnormalized from deleted
	where filtersnormalized.Assessment_Id = deleted.assessment_id
		 and filtersnormalized.DomainId = deleted.DomainId 
		 and maturityid = 4		 
	delete filtersnormalized from deleted
	where filtersnormalized.Assessment_Id = deleted.assessment_id
		 and filtersnormalized.DomainId = deleted.DomainId 
		 and maturityid = 5		 
--then insert
	INSERT INTO [dbo].[FiltersNormalized] ([Assessment_Id],[DomainId],[MaturityId])
	select assessment_id, domainid, 1 from inserted where B = 1;
	INSERT INTO [dbo].[FiltersNormalized] ([Assessment_Id],[DomainId],[MaturityId])
	select assessment_id, domainid, 2 from inserted where E = 1;
	INSERT INTO [dbo].[FiltersNormalized] ([Assessment_Id],[DomainId],[MaturityId])
	select assessment_id, domainid, 3 from inserted where [int] = 1;
	INSERT INTO [dbo].[FiltersNormalized] ([Assessment_Id],[DomainId],[MaturityId])
	select assessment_id, domainid, 4 from inserted where [A] = 1;
	INSERT INTO [dbo].[FiltersNormalized] ([Assessment_Id],[DomainId],[MaturityId])
	select assessment_id, domainid, 5 from inserted where [inn] = 1;




GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[GEN_FILE]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[GEN_FILE] ALTER COLUMN [Is_Uploaded] [bit] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[GEN_FILE]'
GO
ALTER TABLE [dbo].[GEN_FILE] ADD CONSTRAINT [DF_GEN_FILE_Is_Uploaded] DEFAULT ((1)) FOR [Is_Uploaded]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[GEN_FILE]'
GO
UPDATE [dbo].[GEN_FILE] SET [Is_Uploaded]=DEFAULT WHERE [Is_Uploaded] IS NULL
GO
ALTER TABLE [dbo].[GEN_FILE] ALTER COLUMN [Is_Uploaded] [bit] NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[IRP]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[IRP] ADD
[DescriptionComment] [varchar] (1300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[ANSWER]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[ANSWER] ADD
[FeedBack] [varchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[ANSWER] DROP
COLUMN [Component_Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[ANSWER] ALTER COLUMN [Comment] [varchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[ANSWER] ALTER COLUMN [Alternate_Justification] [varchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[ANSWER] ALTER COLUMN [Component_Guid] [uniqueidentifier] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[ANSWER]'
GO
ALTER TABLE [dbo].[ANSWER] ADD CONSTRAINT [DF_ANSWER_Component_Guid] DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [Component_Guid]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[ANSWER]'
GO
UPDATE [dbo].[ANSWER] SET [Component_Guid]=DEFAULT WHERE [Component_Guid] IS NULL
GO
ALTER TABLE [dbo].[ANSWER] ALTER COLUMN [Component_Guid] [uniqueidentifier] NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_ANSWER_1] on [dbo].[ANSWER]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ANSWER_1] ON [dbo].[ANSWER] ([Assessment_Id], [Question_Or_Requirement_Id], [Component_Guid], [Is_Requirement])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS]'
GO
CREATE TABLE [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS]
(
[Assessment_Id] [int] NOT NULL,
[Component_Guid] [uniqueidentifier] NOT NULL,
[Component_Symbol_Id] [int] NOT NULL,
[label] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DrawIO_id] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Zone_Id] [int] NULL,
[Layer_Id] [int] NULL,
[Parent_DrawIO_Id] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ASSESSMENT_DIAGRAM_COMPONENTS_1] on [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS]'
GO
ALTER TABLE [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] ADD CONSTRAINT [PK_ASSESSMENT_DIAGRAM_COMPONENTS_1] PRIMARY KEY CLUSTERED  ([Assessment_Id], [Component_Guid])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[COMPONENT_SYMBOLS]'
GO
CREATE TABLE [dbo].[COMPONENT_SYMBOLS]
(
[Component_Symbol_Id] [int] NOT NULL IDENTITY(1, 1),
[File_Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Component_Family_Name] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Symbol_Group_Id] [int] NOT NULL,
[Abbreviation] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsService] [bit] NOT NULL CONSTRAINT [DF_COMPONENT_SYMBOLS_HasService] DEFAULT ((0)),
[Symbol_Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_COMPONENT_SYMBOLS_Long_Name] DEFAULT (''),
[Width] [int] NOT NULL CONSTRAINT [DF_COMPONENT_SYMBOLS_WIdth] DEFAULT ((60)),
[Height] [int] NOT NULL CONSTRAINT [DF_COMPONENT_SYMBOLS_Height] DEFAULT ((60)),
[Search_Tags] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_COMPONENT_SYMBOLS] on [dbo].[COMPONENT_SYMBOLS]'
GO
ALTER TABLE [dbo].[COMPONENT_SYMBOLS] ADD CONSTRAINT [PK_COMPONENT_SYMBOLS] PRIMARY KEY CLUSTERED  ([Component_Symbol_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_COMPONENT_SYMBOLS_1] on [dbo].[COMPONENT_SYMBOLS]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_COMPONENT_SYMBOLS_1] ON [dbo].[COMPONENT_SYMBOLS] ([Abbreviation])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_COMPONENT_SYMBOLS] on [dbo].[COMPONENT_SYMBOLS]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_COMPONENT_SYMBOLS] ON [dbo].[COMPONENT_SYMBOLS] ([File_Name])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DIAGRAM_CONTAINER]'
GO
CREATE TABLE [dbo].[DIAGRAM_CONTAINER]
(
[Container_Id] [int] NOT NULL IDENTITY(1, 1),
[ContainerType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Visible] [bit] NOT NULL CONSTRAINT [DF_DIAGRAM_CONTAINER_Visible] DEFAULT ((1)),
[DrawIO_id] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Assessment_Id] [int] NOT NULL,
[Universal_Sal_Level] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_DIAGRAM_CONTAINER_Universal_Sal_Level] DEFAULT ('L'),
[Parent_Id] [int] NOT NULL CONSTRAINT [DF_DIAGRAM_CONTAINER_Parent_Id] DEFAULT ((0)),
[Parent_Draw_IO_Id] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DIAGRAM_CONTAINER] on [dbo].[DIAGRAM_CONTAINER]'
GO
ALTER TABLE [dbo].[DIAGRAM_CONTAINER] ADD CONSTRAINT [PK_DIAGRAM_CONTAINER] PRIMARY KEY CLUSTERED  ([Container_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[COMPONENT_NAMES_LEGACY]'
GO
CREATE TABLE [dbo].[COMPONENT_NAMES_LEGACY]
(
[Component_Symbol_id] [int] NOT NULL,
[Old_Symbol_Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_COMPONENT_NAMES_LEGACY] on [dbo].[COMPONENT_NAMES_LEGACY]'
GO
ALTER TABLE [dbo].[COMPONENT_NAMES_LEGACY] ADD CONSTRAINT [PK_COMPONENT_NAMES_LEGACY] PRIMARY KEY CLUSTERED  ([Old_Symbol_Name])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[COMPONENT_QUESTIONS]'
GO
CREATE TABLE [dbo].[COMPONENT_QUESTIONS]
(
[Question_Id] [int] NOT NULL,
[Component_Symbol_Id] [int] NOT NULL,
[Weight] [int] NOT NULL,
[Rank] [int] NOT NULL,
[Seq] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_COMPONENT_QUESTIONS] on [dbo].[COMPONENT_QUESTIONS]'
GO
ALTER TABLE [dbo].[COMPONENT_QUESTIONS] ADD CONSTRAINT [PK_COMPONENT_QUESTIONS] PRIMARY KEY CLUSTERED  ([Question_Id], [Component_Symbol_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DIAGRAM_CONTAINER_TYPES]'
GO
CREATE TABLE [dbo].[DIAGRAM_CONTAINER_TYPES]
(
[ContainerType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DIAGRAM_CONTAINER_TYPES] on [dbo].[DIAGRAM_CONTAINER_TYPES]'
GO
ALTER TABLE [dbo].[DIAGRAM_CONTAINER_TYPES] ADD CONSTRAINT [PK_DIAGRAM_CONTAINER_TYPES] PRIMARY KEY CLUSTERED  ([ContainerType])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DIAGRAM_OBJECT_TYPES]'
GO
CREATE TABLE [dbo].[DIAGRAM_OBJECT_TYPES]
(
[Object_Type] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Object_Type_Order] [int] NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DIAGRAM_OBJECT_TYPES] on [dbo].[DIAGRAM_OBJECT_TYPES]'
GO
ALTER TABLE [dbo].[DIAGRAM_OBJECT_TYPES] ADD CONSTRAINT [PK_DIAGRAM_OBJECT_TYPES] PRIMARY KEY CLUSTERED  ([Object_Type])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DIAGRAM_TYPES]'
GO
CREATE TABLE [dbo].[DIAGRAM_TYPES]
(
[Specific_Type] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Diagram_Type_XML] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Object_Type] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DIAGRAM_TYPES] on [dbo].[DIAGRAM_TYPES]'
GO
ALTER TABLE [dbo].[DIAGRAM_TYPES] ADD CONSTRAINT [PK_DIAGRAM_TYPES] PRIMARY KEY CLUSTERED  ([Specific_Type])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[FINANCIAL_DOMAINS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[FINANCIAL_DOMAINS] ADD
[Acronym] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[FINANCIAL_ASSESSMENT_FACTORS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[FINANCIAL_ASSESSMENT_FACTORS] ADD
[Acronym] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[FINANCIAL_COMPONENTS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[FINANCIAL_COMPONENTS] ADD
[Acronym] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Number] [int] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[FINANCIAL_MATURITY]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[FINANCIAL_MATURITY] ADD
[Acronym] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Rebuilding [dbo].[NEW_REQUIREMENT]'
GO
CREATE TABLE [dbo].[RG_Recovery_1_NEW_REQUIREMENT]
(
[Requirement_Id] [int] NOT NULL IDENTITY(1, 1),
[Requirement_Title] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Requirement_Text] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Supplemental_Info] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Standard_Category] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Standard_Sub_Category] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Weight] [int] NULL,
[Implementation_Recommendations] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Original_Set_Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Text_Hash] AS (CONVERT([varbinary](20),hashbytes('SHA1',[Requirement_Text]),(0))) PERSISTED,
[NCSF_Cat_Id] [int] NULL,
[NCSF_Number] [int] NULL,
[Supp_Hash] AS (CONVERT([varbinary](32),hashbytes('SHA1',left([Supplemental_Info],(8000))),(0))) PERSISTED,
[Ranking] [int] NULL,
[Question_Group_Heading_Id] [int] NOT NULL,
[ExaminationApproach] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
SET IDENTITY_INSERT [dbo].[RG_Recovery_1_NEW_REQUIREMENT] ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
INSERT INTO [dbo].[RG_Recovery_1_NEW_REQUIREMENT]([Requirement_Id], [Requirement_Title], [Requirement_Text], [Supplemental_Info], [Standard_Category], [Standard_Sub_Category], [Weight], [Implementation_Recommendations], [Original_Set_Name], [NCSF_Cat_Id], [NCSF_Number], [Ranking], [Question_Group_Heading_Id], [ExaminationApproach]) SELECT [Requirement_Id], [Requirement_Title], [Requirement_Text], [Supplemental_Info], [Standard_Category], [Standard_Sub_Category], [Weight], [Implementation_Recommendations], [Original_Set_Name], [NCSF_Cat_Id], [NCSF_Number], [Ranking], [Question_Group_Heading_Id], [ExaminationApproach] FROM [dbo].[NEW_REQUIREMENT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
SET IDENTITY_INSERT [dbo].[RG_Recovery_1_NEW_REQUIREMENT] OFF
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @idVal BIGINT
SELECT @idVal = IDENT_CURRENT(N'[dbo].[NEW_REQUIREMENT]')
IF @idVal IS NOT NULL
    DBCC CHECKIDENT(N'[dbo].[RG_Recovery_1_NEW_REQUIREMENT]', RESEED, @idVal)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TABLE [dbo].[NEW_REQUIREMENT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_rename N'[dbo].[RG_Recovery_1_NEW_REQUIREMENT]', N'NEW_REQUIREMENT', N'OBJECT'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_NEW_REQUIREMENT] on [dbo].[NEW_REQUIREMENT]'
GO
ALTER TABLE [dbo].[NEW_REQUIREMENT] ADD CONSTRAINT [PK_NEW_REQUIREMENT] PRIMARY KEY CLUSTERED  ([Requirement_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[INFORMATION]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[INFORMATION] ADD
[IsAcetOnly] [bit] NULL CONSTRAINT [DF_INFORMATION_IsAcetOnly] DEFAULT ((0))
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[NETWORK_WARNINGS]'
GO
CREATE TABLE [dbo].[NETWORK_WARNINGS]
(
[Assessment_Id] [int] NOT NULL,
[Id] [int] NOT NULL,
[WarningText] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__network_warnings_001] on [dbo].[NETWORK_WARNINGS]'
GO
ALTER TABLE [dbo].[NETWORK_WARNINGS] ADD CONSTRAINT [PK__network_warnings_001] PRIMARY KEY CLUSTERED  ([Assessment_Id], [Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[COUNTRIES]'
GO
CREATE TABLE [dbo].[COUNTRIES]
(
[ISO_code] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Display_Name] [nvarchar] (58) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[COUNTRIES_ID] [int] NOT NULL IDENTITY(1, 1)
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_COUNTRIES] on [dbo].[COUNTRIES]'
GO
ALTER TABLE [dbo].[COUNTRIES] ADD CONSTRAINT [PK_COUNTRIES] PRIMARY KEY CLUSTERED  ([COUNTRIES_ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_COUNTRIES] on [dbo].[COUNTRIES]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_COUNTRIES] ON [dbo].[COUNTRIES] ([ISO_code])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[STATES_AND_PROVINCES]'
GO
CREATE TABLE [dbo].[STATES_AND_PROVINCES]
(
[ISO_code] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Display_Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[STATES_AND_PROVINCES_ID] [int] NOT NULL IDENTITY(1, 1),
[Country_Code] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_STATES_AND_PROVINCES] on [dbo].[STATES_AND_PROVINCES]'
GO
ALTER TABLE [dbo].[STATES_AND_PROVINCES] ADD CONSTRAINT [PK_STATES_AND_PROVINCES] PRIMARY KEY CLUSTERED  ([STATES_AND_PROVINCES_ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[SUB_CATEGORY_ANSWERS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[SUB_CATEGORY_ANSWERS] ADD
[Component_Guid] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_SUB_CATEGORY_ANSWERS_Component_Id] DEFAULT ((0))
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[SUB_CATEGORY_ANSWERS] DROP
COLUMN [Component_Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_SUB_CATEGORY_ANSWERS] on [dbo].[SUB_CATEGORY_ANSWERS]'
GO
ALTER TABLE [dbo].[SUB_CATEGORY_ANSWERS] ADD CONSTRAINT [PK_SUB_CATEGORY_ANSWERS] PRIMARY KEY CLUSTERED  ([Assessement_Id], [Heading_Pair_Id], [Component_Guid], [Is_Component])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[VISIO_MAPPING]'
GO
CREATE TABLE [dbo].[VISIO_MAPPING]
(
[Specific_Type] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Stencil_Name] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_VISIO_MAPPING] on [dbo].[VISIO_MAPPING]'
GO
ALTER TABLE [dbo].[VISIO_MAPPING] ADD CONSTRAINT [PK_VISIO_MAPPING] PRIMARY KEY CLUSTERED  ([Specific_Type], [Stencil_Name])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[vQUESTION_HEADINGS]'
GO

ALTER VIEW [dbo].[vQUESTION_HEADINGS]
AS
SELECT        dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS.Heading_Pair_Id, dbo.QUESTION_GROUP_HEADING.Question_Group_Heading, 
                         dbo.UNIVERSAL_SUB_CATEGORIES.Universal_Sub_Category, UNIVERSAL_SUB_CATEGORY_HEADINGS.Sub_Heading_Question_Description
FROM            dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS INNER JOIN
                         dbo.UNIVERSAL_SUB_CATEGORIES ON 
                         dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS.Universal_Sub_Category_Id = dbo.UNIVERSAL_SUB_CATEGORIES.Universal_Sub_Category_Id INNER JOIN
                         dbo.QUESTION_GROUP_HEADING ON 
                         dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS.Question_Group_Heading_Id = dbo.QUESTION_GROUP_HEADING.Question_Group_Heading_Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[Answer_Questions]'
GO



ALTER VIEW [dbo].[Answer_Questions]
AS
SELECT        Answer_Id, Assessment_Id, Mark_For_Review, Comment, Alternate_Justification, Is_Requirement, 
                         Question_Or_Requirement_Id, Question_Number, Answer_Text, Component_Guid, Is_Component, 
                         Is_Framework, FeedBack
FROM            dbo.ANSWER
WHERE        (Is_Requirement = 0)

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_GetQuestionsWithFeedBack]'
GO

--exec usp_getQuestionswithFeedback 8
CREATE PROCEDURE [dbo].[usp_GetQuestionsWithFeedBack]
@assessment_id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--EXECUTE [dbo].[FillEmptyQuestionsForAnalysis]  @Assessment_Id

	-- get the application mode
	declare @applicationMode varchar(50)
	exec dbo.GetApplicationModeDefault @assessment_id, @ApplicationMode output

	-- get currently selected sets
	IF OBJECT_ID('tempdb..#mySets') IS NOT NULL DROP TABLE #mySets
	select set_name into #mySets from AVAILABLE_STANDARDS where Assessment_Id = @assessment_Id and Selected = 1
	
	if(@ApplicationMode = 'Questions Based')	
	begin
		Select
			Simple_Question as [QuestionText],
			a.Feedback as [Feedback],
			a.Question_Or_Requirement_Id as [QuestionOrRequirementID],
			a.Answer_Id as [AnswerId],
			s.Short_Name as [ShortName]
		FROM Answer_Questions a 
			join NEW_QUESTION c on a.Question_Or_Requirement_Id = c.Question_Id
			join vQuestion_Headings h on c.Heading_Pair_Id = h.heading_pair_Id		
			join (
				select distinct s.question_id, ns.Short_Name, ns.Set_Name from NEW_QUESTION_SETS s 
					join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
					join [SETS] ns on s.Set_Name = ns.Set_Name
					join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id
					--join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
					--join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
					where v.Selected = 1 and v.Assessment_Id = @assessment_id --and l.Universal_Sal_Level = ul.Universal_Sal_Level
			)	s on c.Question_Id = s.Question_Id		
		where a.Assessment_Id = @assessment_id 
		and a.Feedback is not null
	end
	else
		begin
				SELECT 
			Requirement_Text as [QuestionText], 
			Answer_Id as [AnswerID],			
			ans.Feedback as [Feedback],			
			s.short_name as [ShortName],
			rs.Requirement_Id as [QuestionOrRequirementID]
			from REQUIREMENT_SETS rs
				left join ANSWER ans on ans.Question_Or_Requirement_Id = rs.Requirement_Id
				left join [SETS] s on rs.Set_Name = s.Set_Name
				left join NEW_REQUIREMENT req on rs.Requirement_Id = req.Requirement_Id
				left join REQUIREMENT_LEVELS rl on rl.Requirement_Id = req.Requirement_Id		
				left join STANDARD_SELECTION ss on ss.Assessment_Id = @assessment_Id
				left join UNIVERSAL_SAL_LEVEL u on u.Full_Name_Sal = ss.Selected_Sal_Level
			where rs.Set_Name in (select set_name from #mySets)
			and ans.Assessment_Id = @assessment_id
			and rl.Standard_Level = u.Universal_Sal_Level
			and ans.feedback is not null
		end	
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[convert_sal]'
GO
-- =============================================
-- Author:		WOODRK
-- Create date: 9/12/2019
-- Description:	function to convert the SAL from 
-- word to letter or vice versa
-- =============================================
CREATE FUNCTION [dbo].[convert_sal]
(
	@SAL varchar(10)
)
RETURNS varchar(10)
AS
BEGIN
	declare @rval varchar(10)
	
	select @rval = UNIVERSAL_SAL_LEVEL from UNIVERSAL_SAL_LEVEL where Full_Name_Sal = @SAL;	
	if (@rval is null)
		select @rval = Full_Name_Sal from UNIVERSAL_SAL_LEVEL where Universal_Sal_Level = @SAL;	

	RETURN @rval;

END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[convert_sal_short]'
GO
-- =============================================
-- Author:		hansbk
-- Create date: 10/10/2019
-- Description:	function to convert the SAL from 
-- word to letter or vice versa
-- =============================================
create FUNCTION [dbo].[convert_sal_short]
(
	@SAL varchar(10)
)
RETURNS varchar(10)
AS
BEGIN
	declare @rval varchar(10)
	
	select @rval = UNIVERSAL_SAL_LEVEL from UNIVERSAL_SAL_LEVEL where Full_Name_Sal = @SAL;	
	if (@rval is null)
			return @SAL	

	RETURN @rval;

END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_financial_attributes]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_financial_attributes]
	@Assessment_Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    
	INSERT INTO [dbo].[FINANCIAL_ASSESSMENT_VALUES]
			   ([Assessment_Id]
			   ,[AttributeName]
			   ,[AttributeValue])
	SELECT Assessment_Id = @Assessment_Id,a.AttributeName, isnull(AttributeValue, '') AttributeValue
	  FROM [dbo].[FINANCIAL_ATTRIBUTES] a
		left join  [dbo].[FINANCIAL_ASSESSMENT_VALUES] v on a.AttributeName = v.AttributeName and v.Assessment_Id = @Assessment_Id
		where v.AttributeName is null

	select * from FINANCIAL_ASSESSMENT_VALUES where Assessment_Id = @Assessment_Id
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[Answer_Components]'
GO

ALTER VIEW [dbo].[Answer_Components]
AS
SELECT        Answer_Id, Assessment_Id, Mark_For_Review, Comment, Alternate_Justification, Is_Requirement, Question_Or_Requirement_Id, Question_Number, Answer_Text, Component_Guid, Is_Component, Is_Framework,
                          Reviewed, FeedBack
FROM            dbo.ANSWER
WHERE        (Is_Requirement = 0) AND (Is_Component = 1)

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Answer_Components_Exploded]'
GO
-- View
CREATE VIEW [dbo].[Answer_Components_Exploded]
AS

SELECT CONVERT(varchar(100), ROW_NUMBER() OVER (ORDER BY a.Question_id)) as UniqueKey,
	a.Assessment_Id, b.Answer_Id, a.Question_Id, isnull(b.Answer_Text, c.Answer_Text) as Answer_Text, 
	CONVERT(nvarchar(1000), b.Comment) AS Comment, CONVERT(nvarchar(1000), b.Alternate_Justification) AS Alternate_Justification, 
	b.FeedBack,
	b.Question_Number, a.Simple_Question AS QuestionText, 	
	a.label AS ComponentName, a.Symbol_Name, 
	a.Question_Group_Heading, a.GroupHeadingId, 
	a.Universal_Sub_Category, a.SubCategoryId, 
	isnull(b.Is_Component,1) as Is_Component, a.Component_Guid, 
	a.Layer_Id, a.LayerName, a.Container_Id, 
	a.ZoneName, dbo.convert_sal(a.SAL) as SAL, 
	b.Mark_For_Review, Is_Requirement=cast(0 as bit), Is_Framework=cast(0 as bit),
	b.Reviewed, a.Simple_Question, a.Sub_Heading_Question_Description, a.heading_pair_id, a.label, a.Component_Symbol_Id
from (
SELECT CONVERT(varchar(100), ROW_NUMBER() OVER (ORDER BY q.Question_id)) as UniqueKey,
	adc.Assessment_Id, q.Question_Id, q.Simple_Question,
	adc.label, adc.Component_Symbol_Id, 
	h.Question_Group_Heading, usch.Question_Group_Heading_Id as GroupHeadingId, 
	h.Universal_Sub_Category, usch.Universal_Sub_Category_Id as SubCategoryId,
	adc.Component_Guid, adc.Layer_Id, l.Name AS LayerName, z.Container_Id, 
	z.Name AS ZoneName,  dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level)) AS SAL,
	h.Sub_Heading_Question_Description,h.Heading_Pair_Id, cs.Symbol_Name
from     dbo.ASSESSMENT_DIAGRAM_COMPONENTS AS adc 
			join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
			join dbo.COMPONENT_QUESTIONS AS cq ON adc.Component_Symbol_Id = cq.Component_Symbol_Id			
			join dbo.COMPONENT_SYMBOLS as cs on adc.Component_Symbol_Id = cs.Component_Symbol_Id
            join dbo.NEW_QUESTION AS q ON cq.Question_Id = q.Question_Id 
			join NEW_QUESTION_SETS s on q.Question_Id = s.Question_Id  and s.set_name = 'Components'
            join dbo.DIAGRAM_CONTAINER AS l ON adc.Layer_Id = l.Container_Id  
            left join dbo.DIAGRAM_CONTAINER AS z ON adc.Zone_Id =z.Container_Id 
			left join dbo.vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id
			left join dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS usch on usch.Heading_Pair_Id = h.Heading_Pair_Id
			join NEW_QUESTION_LEVELS nql on s.New_Question_Set_Id = nql.New_Question_Set_Id and nql.Universal_Sal_Level = dbo.convert_sal_short(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))		
WHERE l.Visible = 1) a left join Answer_Components AS b on a.Question_Id = b.Question_Or_Requirement_Id and a.Assessment_Id = b.Assessment_Id and a.component_guid = b.component_guid
left join (SELECT a.Assessment_Id, q.Question_Id, a.Answer_Text		
from   (SELECT distinct q.question_id,adc.assessment_id
				FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] adc 			
				join component_questions q on adc.Component_Symbol_Id = q.Component_Symbol_Id
				join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
				join new_question nq on q.question_id=nq.question_id		
				join new_question_sets qs on nq.question_id=qs.question_id	and qs.Set_Name = 'Components'						
				join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id 
					and nql.Universal_Sal_Level = dbo.convert_sal(ss.Selected_Sal_Level)) as f  
            join dbo.NEW_QUESTION AS q ON f.Question_Id = q.Question_Id 			
			join Answer_Components AS a on f.Question_Id = a.Question_Or_Requirement_Id and f.assessment_id = a.assessment_id	  
where component_guid = '00000000-0000-0000-0000-000000000000') c on a.Assessment_Id=c.Assessment_Id and a.Question_Id = c.Question_Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Answer_Components_Default]'
GO



/**
The default consists of one one question 
joined on the types in the diagram
filtered by level 
left joined by the answers
*/
CREATE VIEW [dbo].[Answer_Components_Default]
AS

SELECT                   
	-- This guarantees a unique column to key on in the model
	CONVERT(varchar(100), ROW_NUMBER() OVER (ORDER BY q.Question_id)) as UniqueKey,
	a.Assessment_Id, a.Answer_Id, q.Question_Id, a.Answer_Text, 
	CONVERT(nvarchar(1000), a.Comment) AS Comment, CONVERT(nvarchar(1000), a.Alternate_Justification) AS Alternate_Justification, 
	a.Question_Number, q.Simple_Question AS QuestionText, 		
	h.Question_Group_Heading, usch.Question_Group_Heading_Id as GroupHeadingId, 
	h.Universal_Sub_Category, usch.Universal_Sub_Category_Id as SubCategoryId,
	a.FeedBack,
	a.Is_Component, a.Component_Guid, 
	dbo.convert_sal(ss.Selected_Sal_Level) AS SAL, 
	a.Mark_For_Review, a.Is_Requirement, a.Is_Framework,	
	q.heading_pair_id, h.Sub_Heading_Question_Description,
	q.Simple_Question, 
	a.Reviewed, label = null, ComponentName = null, Symbol_Name = null, Component_Symbol_id = 0
from   STANDARD_SELECTION ss
		 join 
		 (SELECT distinct q.question_id,adc.assessment_id
				FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] adc 			
				join component_questions q on adc.Component_Symbol_Id = q.Component_Symbol_Id
				join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
				join new_question nq on q.question_id=nq.question_id		
				join new_question_sets qs on nq.question_id=qs.question_id	and qs.Set_Name = 'Components'		
				join dbo.DIAGRAM_CONTAINER l on adc.Layer_id=l.Container_Id
				left join dbo.DIAGRAM_CONTAINER AS z ON adc.Zone_Id =z.Container_Id
				join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id 
					and nql.Universal_Sal_Level = dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))
				where l.visible = 1) as f  on ss.assessment_id=f.assessment_id							
            join dbo.NEW_QUESTION AS q ON f.Question_Id = q.Question_Id 
			join dbo.vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id	
			join dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS usch on usch.Heading_Pair_Id = h.Heading_Pair_Id		    
			join Answer_Components AS a on f.Question_Id = a.Question_Or_Requirement_Id and f.assessment_id = a.assessment_id	  
where component_guid = '00000000-0000-0000-0000-000000000000'

--order by question_group_heading,universal_sub_category
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[Answer_Requirements]'
GO
ALTER VIEW [dbo].[Answer_Requirements]
AS
SELECT        Answer_Id, Assessment_Id, Mark_For_Review, Comment, Alternate_Justification, Is_Requirement, Question_Or_Requirement_Id, Question_Number, Answer_Text, Component_Guid, Is_Component, Is_Framework, 
                         Custom_Question_Guid, Old_Answer_Id, Reviewed, FeedBack
FROM            dbo.ANSWER
WHERE        (Is_Requirement = 1)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_getFinancialQuestions]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_getFinancialQuestions]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select r.Requirement_title, r.Requirement_text, a.Answer_text, m.MaturityLevel  from 
	filtersNormalized f 	
	join FINANCIAL_GROUPS g on f.domainid = g.domainid and f.MaturityId = g.MaturityId
	join FINANCIAL_MATURITY m on g.MaturityId = m.MaturityId
	join FINANCIAL_DETAILS fd on g.FinancialGroupId = fd.FinancialGroupId
	join FINANCIAL_REQUIREMENTS fr on fd.StmtNumber = fr.StmtNumber
	join NEW_REQUIREMENT r on fr.Requirement_Id=r.Requirement_Id
	join Answer_Requirements a on r.requirement_id = a.Question_Or_Requirement_Id 
where a.assessment_id = @assessment_id and f.assessment_id = @assessment_id
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[Answer_Questions_No_Components]'
GO
ALTER VIEW [dbo].[Answer_Questions_No_Components]
AS
SELECT        Answer_Id, Assessment_Id, Mark_For_Review, Comment, Alternate_Justification, Is_Requirement, Question_Or_Requirement_Id, Question_Number, Answer_Text, Component_Guid, Is_Component, Is_Framework, Reviewed, 
                         FeedBack, Custom_Question_Guid, Old_Answer_Id
FROM            dbo.ANSWER
WHERE        (Is_Requirement = 0) AND (Is_Component = 0)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Answer_Standards_InScope]'
GO
CREATE VIEW [dbo].[Answer_Standards_InScope]
AS
		select distinct mode='Q', a.assessment_id, a.answer_id, is_requirement=0, a.question_or_requirement_id, a.mark_for_review, 
			a.comment, a.alternate_justification, a.question_number, a.answer_text, 
			a.component_guid, a.is_component, a.custom_question_guid,a.is_framework,a.old_answer_id, a.reviewed, a.FeedBack
			,c.Simple_Question as Question_Text
			FROM Answer_Questions_No_Components a 
			join NEW_QUESTION c on a.Question_Or_Requirement_Id = c.Question_Id			
			join (
				select distinct s.question_id, ns.Short_Name from NEW_QUESTION_SETS s 
					join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
					join SETS ns on s.Set_Name = ns.Set_Name
					join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id
					join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
					join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
					where v.Selected = 1 and v.Assessment_Id = ss.assessment_id and l.Universal_Sal_Level = ul.Universal_Sal_Level
			)	s on c.Question_Id = s.Question_Id					
		union	
		select distinct mode='R', a.assessment_id, a.answer_id, is_requirement=1, a.question_or_requirement_id,a.mark_for_review, 
			a.comment, a.alternate_justification, a.question_number, a.answer_text, 
			a.component_guid, a.is_component, a.custom_question_guid, a.is_framework, a.old_answer_id, a.reviewed, a.FeedBack
			,req.Requirement_Text as Question_Text
			from Answer_Requirements a
				join REQUIREMENT_SETS rs on a.Question_Or_Requirement_Id = rs.Requirement_Id and a.is_requirement= 1
				join STANDARD_SELECTION ss on a.Assessment_Id = ss.assessment_id		
				join [SETS] s on rs.Set_Name = s.Set_Name
				join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name and ss.assessment_id = v.assessment_id
				join NEW_REQUIREMENT req on rs.Requirement_Id = req.Requirement_Id
				join REQUIREMENT_LEVELS rl on rl.Requirement_Id = req.Requirement_Id and rl.Standard_Level=dbo.convert_sal(ss.Selected_Sal_Level)
			where v.selected=1 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Answer_Components_Overrides]'
GO
-- View

CREATE VIEW [dbo].[Answer_Components_Overrides]
AS
/**
retreives only overriden component answers
so it is the same normal query but only returns 
those records where component guid is not null
*/
SELECT [UniqueKey]
      ,[Assessment_Id]
      ,[Answer_Id]
      ,[Question_Id]
      ,[Answer_Text]
      ,[Comment]
      ,[Alternate_Justification]
      ,[Question_Number]
      ,[QuestionText]
      ,[ComponentName]
      ,[Symbol_Name]
      ,[Question_Group_Heading]
      ,[GroupHeadingId]
      ,[Universal_Sub_Category]
      ,[SubCategoryId]
      ,[Is_Component]
      ,[Component_Guid]
      ,[Layer_Id]
      ,[LayerName]
      ,[Container_Id]
      ,[ZoneName]
      ,[SAL]
      ,[Mark_For_Review]
      ,[Is_Requirement]
      ,[Is_Framework]
      ,[Reviewed]
      ,[Simple_Question]
      ,[Sub_Heading_Question_Description]
      ,[heading_pair_id]
      ,[label]
      ,[Component_Symbol_Id]
	  ,[FeedBack]
  FROM [dbo].[Answer_Components_Exploded] where Answer_Id is not null
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Answer_Components_InScope]'
GO

CREATE VIEW [dbo].[Answer_Components_InScope]
AS
SELECT DISTINCT 
                         a.Assessment_Id, a.Answer_Id, a.Question_Or_Requirement_Id, a.Answer_Text, CONVERT(nvarchar(1000), a.Comment) AS Comment, CONVERT(nvarchar(1000), a.Alternate_Justification) AS Alternate_Justification, 
                         a.Question_Number, q.Simple_Question AS QuestionText, adc.label AS ComponentName, adc.Component_Symbol_Id, adc.Layer_Id, l.Name AS LayerName, z.Container_Id, 
                         z.Name AS ZoneName, z.Universal_Sal_Level AS SAL, a.Is_Component, a.Component_Guid, a.Custom_Question_Guid, a.Old_Answer_Id, a.Reviewed, a.Mark_For_Review, a.Is_Requirement, 
                         a.Is_Framework
FROM            dbo.ANSWER AS a INNER JOIN
                         dbo.COMPONENT_QUESTIONS AS cq ON cq.Question_Id = a.Question_Or_Requirement_Id INNER JOIN
                         dbo.NEW_QUESTION AS q ON cq.Question_Id = q.Question_Id INNER JOIN
                         dbo.ASSESSMENT_DIAGRAM_COMPONENTS AS adc ON a.Assessment_Id = adc.Assessment_Id AND adc.Component_Symbol_Id = cq.Component_Symbol_Id LEFT OUTER JOIN
                         dbo.DIAGRAM_CONTAINER AS l ON adc.Layer_Id = l.Container_Id 
						 LEFT OUTER JOIN dbo.DIAGRAM_CONTAINER AS z ON z.Assessment_Id = adc.Assessment_Id AND z.Container_Id = adc.Zone_Id
WHERE        (a.Is_Component = 1) AND (COALESCE (l.Visible, 1) = 1)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_getRankedCategories]'
GO
-- =============================================
-- Author:		barry
-- Create date: 7/20/2018
-- Description:	returns the ranked categories
-- =============================================
ALTER PROCEDURE [dbo].[usp_getRankedCategories]
	@assessment_id int	
AS
BEGIN
	SET NOCOUNT ON;
	-- ranked category calculation is 
	-- sum up the total category risk
	-- for the questions on this assessment
	-- then take the number of questions - the question rank 

/*
TODO this needs to take into account requirements vs questions
get the question set then for all the questions take the total risk (in this set only)
then calculate the total risk in each question_group_heading(category) 
then calculate the actual percentage of the total risk in each category 
order by the total
*/
declare @applicationMode varchar(50)

exec dbo.GetApplicationModeDefault @assessment_id, @ApplicationMode output


declare @maxRank int 
if(@ApplicationMode = 'Questions Based')	
begin
	select @maxRank = max(c.Ranking) 
		FROM NEW_QUESTION c 
		join (select distinct question_id,Assessment_Id from NEW_QUESTION_SETS s join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name where v.Selected = 1)
		s on c.Question_Id = s.Question_Id
		where s.Assessment_Id = @assessment_id 
	

	IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp
	IF OBJECT_ID('tempdb..#TempAnswered') IS NOT NULL DROP TABLE #TempAnswered

	SELECT h.Question_Group_Heading,isnull(count(c.question_id),0) qc,  isnull(SUM(@maxRank-c.Ranking),0) cr, sum(sum(@maxrank - c.Ranking)) OVER() AS Total into #temp
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id
		join vQuestion_Headings h on c.Heading_Pair_Id=h.heading_pair_Id
		
		join (
			select distinct s.question_id from NEW_QUESTION_SETS s 
				join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
				join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id
				join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
				join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
				where v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = ul.Universal_Sal_Level
		)
		s on c.Question_Id = s.Question_Id
		where a.Assessment_Id = @assessment_id and a.Answer_Text != 'NA'
		group by Question_Group_Heading
     
	 SELECT h.Question_Group_Heading, isnull(count(c.question_id),0) nuCount, isnull(SUM(@maxRank-c.Ranking),0) cr into #tempAnswered
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id
		join vQuestion_Headings h on c.Heading_Pair_Id=h.heading_pair_Id
		join (
			select distinct s.question_id from NEW_QUESTION_SETS s 
				join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
				join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id
				join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
				join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
				where v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = ul.Universal_Sal_Level
		)	s on c.Question_Id = s.Question_Id
		where a.Assessment_Id = @assessment_id and a.Answer_Text in ('N','U')
		group by Question_Group_Heading

	select t.*, isnull(a.nuCount,0) nuCount, isnull(a.cr,0) Actualcr, isnull(cast(a.cr as decimal(18,3))/Total,0)*100 [prc],  isnull(a.nuCount,0)/(cast(qc as decimal(18,3))) as [Percent]
	from #temp t left join #tempAnswered a on t.Question_Group_Heading = a.Question_Group_Heading
	order by prc desc	
end
else 
begin 
	select @maxRank = max(c.Ranking) 
		FROM NEW_REQUIREMENT c 
		join (select distinct requirement_id,Assessment_Id from REQUIREMENT_SETS s join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name where v.Selected = 1)
		s on c.Requirement_Id=s.Requirement_Id
		where s.Assessment_Id = @assessment_id 
	

	IF OBJECT_ID('tempdb..#TempR') IS NOT NULL DROP TABLE #TempR

	SELECT h.Question_Group_Heading,count(c.Requirement_Id) qc,  SUM(@maxRank-c.Ranking) cr, sum(sum(@maxrank - c.Ranking)) OVER() AS Total into #tempR
		FROM Answer_Requirements a 
		join NEW_REQUIREMENT c on a.Question_Or_Requirement_Id=c.Requirement_Id
		join QUESTION_GROUP_HEADING h on c.Question_Group_Heading_Id = h.Question_Group_Heading_Id
		join (select distinct requirement_id from REQUIREMENT_SETS s join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name where v.Selected = 1)
		s on c.Requirement_Id = s.Requirement_Id
		where a.Assessment_Id = @assessment_id 
		group by Question_Group_Heading

	
	select *, isnull(cast(cr as decimal(18,3))/Total, 0) * 100 [prc] from #tempR
	order by prc desc
end
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[GetCombinedOveralls]'
GO
ALTER PROCEDURE [dbo].[GetCombinedOveralls]	
@Assessment_Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Generate temporary tables containing all relevant/in-scope answers for the Assessment	

	SELECT a.*
	into #questionAnswers
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id				
		join NEW_QUESTION_SETS s on c.Question_Id = s.Question_Id
		join [sets] ms on s.Set_Name = ms.Set_Name
		join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
		join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id 
		join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
		join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
		where a.Assessment_Id = @assessment_id 
			and v.Selected = 1 
			and v.Assessment_Id = @assessment_id 
			and l.Universal_Sal_Level = ul.Universal_Sal_Level
	
	SELECT ar.*
	into #requirementAnswers
		FROM Answer_Requirements ar
		join NEW_REQUIREMENT r on ar.Question_Or_Requirement_Id = r.Requirement_Id
		join REQUIREMENT_SETS s on r.Requirement_Id = s.Requirement_Id
		join REQUIREMENT_LEVELS l on ar.Question_Or_Requirement_Id = l.Requirement_Id
		join [sets] ms on s.Set_Name = ms.Set_Name
		join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name
		join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
		join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
		where ar.Assessment_Id = @assessment_id 
			and v.Selected = 1 
			and v.Assessment_Id = @assessment_id 
			and l.Standard_Level = ul.Universal_Sal_Level
	
	SELECT ac.*
	into #componentAnswers 
		FROM Answer_Components_Exploded ac
		where ac.Assessment_Id = @Assessment_Id

	

	if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = '#assessmentAnswers')
		drop table #asessmentAnswers;
	create table #assessmentAnswers (answer_text varchar(50), assessment_id int, is_requirement bit, is_component bit, is_framework bit)


	-- Populate #assessmentAnswers from the correct source table
	declare @applicationMode varchar(50)
	exec dbo.GetApplicationModeDefault @assessment_id, @ApplicationMode output

	if(@ApplicationMode = 'Questions Based')
	begin		
		insert into #assessmentAnswers 
		select answer_text, assessment_id, is_requirement, is_component, is_framework 
		from #questionAnswers
	end
	else
	begin		
		insert into #assessmentAnswers 
		select answer_text, assessment_id, is_requirement, is_component, is_framework 
		from #requirementAnswers
	end

	-- Include component answers regardless of the application mode
	insert into #assessmentAnswers
		select answer_text, assessment_id, is_requirement, is_component, is_framework 
		from #componentAnswers


    -- Insert statements for procedure here
	SELECT StatType,isNull(Total,0) as Total, 
					cast(IsNull(Round((cast(([Y]) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int) as [Y],
					cast(IsNull(Round((cast(([N]) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int) as [N],
					cast(IsNull(Round((cast(([NA]) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int) as [NA],
					cast(IsNull(Round((cast(([A]) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int) as [A],
					cast(IsNull(Round((cast(([U]) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int) as [U],
					[Y] as [YCount],[N] as [NCount],[NA] as [NACount],[A] as [ACount],[U] as [UCount],
					--Value = (IsNull(cast(([Y]+[A]) as float)/((isnull(nullif(Total,0),1)-isnull([NA],0))),0))*100, 					
					Value = (cast(([Y]+[A]) as float)/ isnull(nullif((isnull(Total,0)-isnull([NA],0)),0),1))*100, 					
					
					--Value = cast(1 as float), 					
					TotalNoNA = isnull(Total,0)- isnull(NA,0)
		FROM 
		(
			select [StatType]='Overall', isnull(Acount,0) as Acount, aw.answer_text, SUM(acount) OVER(PARTITION BY aw.t) AS Total  
				from (select t=1, ANSWER_LOOKUP.Answer_Text from ANSWER_LOOKUP) aw left join (select count(answer_text) as Acount, answer_text 
				from #assessmentAnswers  -- !!! 
				where Assessment_Id  = @Assessment_Id
				group by answer_Text) B on aw.Answer_Text=b.Answer_Text 
			union
				select [StatType]='Requirement', isnull(Acount,0) as Acount, aw.answer_text, SUM(acount) OVER(PARTITION BY aw.t) AS Total  		
				from (select t=2, ANSWER_LOOKUP.Answer_Text from ANSWER_LOOKUP) aw left join (select count(answer_text) as Acount, answer_text
				from #assessmentAnswers 
				where Is_Requirement = 1 and assessment_id = @assessment_id
				group by answer_Text) B on aw.Answer_Text=b.Answer_Text 
			union
				select [StatType]='Questions', isnull(Acount,0) as Acount, aw.answer_text, SUM(acount) OVER(PARTITION BY aw.t) AS Total  
				from (select t=3, ANSWER_LOOKUP.Answer_Text from ANSWER_LOOKUP) aw left join (select count(answer_text) as Acount, answer_text
				from #assessmentAnswers 
				where Is_Requirement = 0 and Is_Component = 0 and Assessment_Id = @Assessment_Id
				group by answer_Text) B on aw.Answer_Text=b.Answer_Text 	
			union
				select [StatType]='Components', isnull(Acount,0) as Acount, aw.answer_text, SUM(acount) OVER(PARTITION BY aw.t) AS Total  
				from (select t=4, ANSWER_LOOKUP.Answer_Text from ANSWER_LOOKUP) aw left join (select count(answer_text) as Acount, answer_text
				from #assessmentAnswers 
				where Is_Requirement = 0 and Is_Component = 1 and Assessment_Id = @Assessment_Id
				group by answer_Text) B on aw.Answer_Text=b.Answer_Text 
			union
				select [StatType]='Framework', isnull(Acount,0) as Acount, aw.answer_text, SUM(acount) OVER(PARTITION BY aw.t) AS Total    
				from (select t=5, ANSWER_LOOKUP.Answer_Text from ANSWER_LOOKUP) aw left join (select count(answer_text) as Acount, answer_text
				from #assessmentAnswers 
				where Is_Framework = 1 and Assessment_Id = @Assessment_Id
				group by answer_Text) B on aw.Answer_Text=b.Answer_Text 
		) p
		PIVOT
		(
		sum(acount)
		FOR answer_text IN
		( [Y],[N],[NA],[A],[U] )
		) AS pvt
		ORDER BY pvt.StatType;

END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[FillEmptyQuestionsForAnalysis]'
GO
-- =============================================
-- Author:		hansbk
-- Create date: 7/9/2018
-- Description:	CopyData
-- =============================================
ALTER PROCEDURE [dbo].[FillEmptyQuestionsForAnalysis]
	-- Add the parameters for the stored procedure here
	@Assessment_Id int	
AS
BEGIN	
	--SET NOCOUNT ON;
	--get the list of selected standards
	--get the mode
	--for the given mode 
	--select the new_questions_sets or requirement_sets table with left join answers (possibly on the view)
	-- and do the insert
	declare @ApplicationMode varchar(100)
	declare @SALevel varchar(10)
	declare @NumRowsChanged int

	select @SALevel = ul.Universal_Sal_Level from STANDARD_SELECTION ss join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
	where @Assessment_Id = @Assessment_Id 

	DECLARE @result int;  
	exec GetApplicationModeDefault @assessment_id,@applicationmode output
	if(@ApplicationMode = 'Questions Based')
		begin
		BEGIN TRANSACTION;  
		
		EXEC @result = sp_getapplock @DbPrincipal = 'dbo', @Resource = '[Answer]', @LockMode = 'Exclusive';  
			INSERT INTO [dbo].[ANSWER]  ([Is_Requirement],[Question_Or_Requirement_Id],[Answer_Text],[Is_Component],[Is_Framework],[Assessment_Id])     
		select Is_Requirement=0,s.Question_id,Answer_Text = 'U', Is_Component='0',Is_Framework=0, Assessment_Id =@Assessment_Id
			from (select distinct s.Question_Id from NEW_QUESTION_SETS s 
				join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
				join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.new_question_set_id
				where v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = @SALevel) s
			left join (select * from ANSWER where Assessment_Id = @Assessment_Id and Is_Requirement = 0) a on s.Question_Id = a.Question_Or_Requirement_Id
		where a.Question_Or_Requirement_Id is null
		IF @result = -3  
		BEGIN  
			ROLLBACK TRANSACTION;  
		END  
		ELSE  
		BEGIN  
			EXEC sp_releaseapplock @DbPrincipal = 'dbo', @Resource = '[Answer]'; 	
			COMMIT TRANSACTION;  
		END;  
		if(@@ROWCOUNT>0) 
			begin 			
			exec usp_BuildCatNumbers @assessment_id
			end
		end
	else
	begin
		BEGIN TRANSACTION;  		
		EXEC @result = sp_getapplock @DbPrincipal = 'dbo', @Resource = '[Answer]', @LockMode = 'Exclusive';  
		INSERT INTO [dbo].[ANSWER]  ([Is_Requirement],[Question_Or_Requirement_Id]
           ,[Answer_Text],[Is_Component],[Is_Framework],[Assessment_Id])     
		select distinct Is_Requirement=1,s.Requirement_Id, Answer_Text = 'U', Is_Component='0',Is_Framework=0,av.Assessment_Id 
			from requirement_sets s 
			join AVAILABLE_STANDARDS av on s.Set_Name=av.Set_Name
			join REQUIREMENT_LEVELS rl on s.Requirement_Id = rl.Requirement_Id
			left join (select * from ANSWER where Assessment_Id = @Assessment_Id and Is_Requirement = 1) a on s.Requirement_Id = a.Question_Or_Requirement_Id
		where av.Selected = 1 and av.Assessment_Id = @Assessment_Id and a.Question_Or_Requirement_Id is null and rl.Standard_Level = @SALevel and rl.Level_Type = 'NST'
			IF @result = -3  
		BEGIN  
			ROLLBACK TRANSACTION;  
		END  
		ELSE  
		BEGIN  
			EXEC sp_releaseapplock @DbPrincipal = 'dbo', @Resource = '[Answer]'; 	
			COMMIT TRANSACTION;  
		END;  
		if(@@ROWCOUNT>0) exec usp_BuildCatNumbers @assessment_id
	end   
	
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_getFirstPage]'
GO
-- =============================================
-- Author:		hansbk
-- Create date: 7/30/2018
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_getFirstPage]
	@assessment_id int	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	EXECUTE [dbo].[FillEmptyQuestionsForAnalysis]  @Assessment_Id
	EXECUTE [dbo].[GetCombinedOveralls] @Assessment_Id	
	EXECUTE [dbo].[usp_GetOverallRankedCategoriesPage] @assessment_id
	-- EXECUTE [dbo].[usp_getRankedCategories] @assessment_id

END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[GetRelevantAnswers]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Returns a table containing ANSWER rows that are relevant
--              to the assessment's current question mode, standard selection and SAL level.
-- =============================================
ALTER PROCEDURE [dbo].[GetRelevantAnswers]
	@assessment_id int	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	EXECUTE [dbo].[FillEmptyQuestionsForAnalysis]  @Assessment_Id

	-- get the application mode
	declare @applicationMode varchar(50)
	exec dbo.GetApplicationModeDefault @assessment_id, @ApplicationMode output

	-- get currently selected sets
	IF OBJECT_ID('tempdb..#mySets') IS NOT NULL DROP TABLE #mySets
	select set_name into #mySets from AVAILABLE_STANDARDS where Assessment_Id = @assessment_Id and Selected = 1
	
	if(@ApplicationMode = 'Questions Based')	
	begin
		
		select a.assessment_id, a.answer_id, a.is_requirement, a.question_or_requirement_id, a.mark_for_review, 
			a.comment, a.alternate_justification, a.question_number, a.answer_text, 
			a.component_guid, a.is_component, a.custom_question_guid, a.is_framework, a.old_answer_id, a.reviewed

			FROM ANSWER a 
			join NEW_QUESTION c on a.Question_Or_Requirement_Id = c.Question_Id			
			join (
				select distinct s.question_id, ns.Short_Name from NEW_QUESTION_SETS s 
					join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
					join SETS ns on s.Set_Name = ns.Set_Name
					join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id
					join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
					join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
					where v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = ul.Universal_Sal_Level
			)	s on c.Question_Id = s.Question_Id		
			where a.Assessment_Id = @assessment_id 
			and a.Is_Requirement = 0
	
	end
	else
	begin		

		select a.assessment_id, a.answer_id, a.is_requirement, a.question_or_requirement_id,a.mark_for_review, 
			a.comment, a.alternate_justification, a.question_number, a.answer_text, 
			a.component_guid, a.is_component, a.custom_question_guid, a.is_framework, a.old_answer_id, a.reviewed

			from REQUIREMENT_SETS rs
				left join ANSWER a on a.Question_Or_Requirement_Id = rs.Requirement_Id
				left join [SETS] s on rs.Set_Name = s.Set_Name
				left join NEW_REQUIREMENT req on rs.Requirement_Id = req.Requirement_Id
				left join REQUIREMENT_LEVELS rl on rl.Requirement_Id = req.Requirement_Id		
				left join STANDARD_SELECTION ss on ss.Assessment_Id = @assessment_Id
				left join UNIVERSAL_SAL_LEVEL u on u.Full_Name_Sal = ss.Selected_Sal_Level
			where rs.Set_Name in (select set_name from #mySets)
			and a.Assessment_Id = @assessment_id
			and rl.Standard_Level = u.Universal_Sal_Level 	

	end
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_StatementsReviewed]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_StatementsReviewed]
	@Assessment_Id int	
AS
BEGIN

------------- get relevant answers ----------------
	IF OBJECT_ID('tempdb..#answers') IS NOT NULL DROP TABLE #answers

	create table #answers (assessment_id int, answer_id int, is_requirement bit, question_or_requirement_id int, mark_for_review bit, 
	comment ntext, alternate_justification ntext, question_number int, answer_text varchar(50), 
	component_guid varchar(36), is_component bit, custom_question_guid varchar(50), is_framework bit, old_answer_id int, reviewed bit)

	insert into #answers exec [GetRelevantAnswers] @assessment_id

----------------------------------------

	declare @applicationMode varchar(50)

	exec dbo.GetApplicationModeDefault @assessment_id, @ApplicationMode output

	SET NOCOUNT ON;

	EXECUTE [dbo].[FillEmptyQuestionsForAnalysis]  @Assessment_Id

	if(@ApplicationMode = 'Questions Based')	
	BEGIN

		SELECT assessment_id, c.Component, ReviewType, Hours, isnull(ReviewedCount, 0) as ReviewedCount, f.OtherSpecifyValue, c.DomainId, PresentationOrder, grouporder acount
		from FINANCIAL_HOURS f 
			join FINANCIAL_HOURS_COMPONENT c on f.Component = c.Component
			left join (
				select grouporder, a.DomainId, isnull(ReviewedCount, 0) as ReviewedCount
				from (
						select distinct min(StmtNumber) as grouporder, d.Domain, g.DomainId,count(stmtnumber) Total from [FINANCIAL_DETAILS] fd 
						INNER JOIN dbo.FINANCIAL_GROUPS G on FD.FinancialGroupId = g.FinancialGroupId		
						INNER JOIN [dbo].[FINANCIAL_DOMAINS] AS D ON g.[DomainId] = D.[DomainId]						
						group by g.DomainId, d.Domain
						)  a left join (
						SELECT  g.DomainId, isnull(count(ans_rev.answer_id), 0) as ReviewedCount
						FROM       [dbo].[FINANCIAL_QUESTIONS] f			
						INNER JOIN [dbo].[NEW_QUESTION] q ON f.[Question_Id] = q.[Question_Id]
						INNER JOIN #answers a ON q.[Question_Id] = a.[Question_Or_Requirement_Id]
						INNER JOIN #answers ans_rev ON q.[Question_Id] = ans_rev.[Question_Or_Requirement_Id]
						INNER JOIN [dbo].[FINANCIAL_DETAILS] AS FD ON f.[StmtNumber] = FD.[StmtNumber]    
						inner join dbo.FINANCIAL_GROUPS G on FD.FinancialGroupId = g.FinancialGroupId
						WHERE ans_rev.Reviewed = 1
						group by g.DomainId
						) b  on a.DomainId = b.DomainId
		) b on c.DomainId = b.DomainId		
		where f.assessment_id = @assessment_id
		order by PresentationOrder

	END 
	ELSE
	BEGIN 

		SELECT Assessment_id, c.Component, ReviewType, Hours, isnull(ReviewedCount, 0) as ReviewedCount, f.OtherSpecifyValue, c.DomainId, PresentationOrder, grouporder acount
		from FINANCIAL_HOURS f 
		join FINANCIAL_HOURS_COMPONENT c on f.Component = c.Component
		left join (
			select grouporder, a.DomainId, isnull(ReviewedCount, 0) as ReviewedCount
			from (
					select distinct min(StmtNumber) as grouporder, d.Domain, g.DomainId, count(stmtnumber) Total from [FINANCIAL_DETAILS] fd 
					INNER JOIN dbo.FINANCIAL_GROUPS G on FD.FinancialGroupId = g.FinancialGroupId		
					INNER JOIN [dbo].[FINANCIAL_DOMAINS] AS D ON g.[DomainId] = D.[DomainId]			
					group by g.DomainId, d.Domain
					)  a left join (
					SELECT  g.DomainId, isnull(count(ans_rev.Answer_Id), 0) as ReviewedCount
					FROM       [dbo].[FINANCIAL_REQUIREMENTS] f
					INNER JOIN [dbo].[NEW_REQUIREMENT] q ON f.[Requirement_Id] = q.[Requirement_Id]
					INNER JOIN #answers a ON q.[Requirement_Id] = a.[Question_Or_Requirement_Id]
					INNER JOIN #answers ans_rev ON q.[Requirement_Id] = ans_rev.[Question_Or_Requirement_Id]
					INNER JOIN [dbo].[FINANCIAL_DETAILS] AS FD ON f.[StmtNumber] = FD.[StmtNumber]    
					inner join dbo.FINANCIAL_GROUPS G on FD.FinancialGroupId = g.FinancialGroupId
					WHERE ans_rev.Reviewed = 1
					group by g.DomainId
					) b  on a.DomainId = b.DomainId 		
		) b on c.DomainId = b.DomainId
		where f.assessment_id = @assessment_id
		order by PresentationOrder		
			
	END
	
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_getComponentsSummary]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_getComponentsSummary]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select l.Answer_Text, l.Answer_Full_Name, isnull(b.vcount, 0) vcount, round(isnull(b.value, 0),0) [value] 
	from ANSWER_LOOKUP l 
	left join (select Answer_Text, count(answer_text) vcount, cast((count(answer_text) * 100.0)/sum(count(*)) over() as decimal(18,1)) [value] 
	from  Answer_Components_InScope 
	where assessment_id = @assessment_id
	group by answer_text) b on l.Answer_Text = b.Answer_Text
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_getStandardsSummary]'
GO
-- =============================================
-- Author:		hansbk
-- Create date: 8/1/2018
-- Description:	Stub needs completed
-- =============================================
ALTER PROCEDURE [dbo].[usp_getStandardsSummary]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	/*
TODO this needs to take into account requirements vs questions
get the question set then for all the questions take the total risk (in this set only)
then calculate the total risk in each question_group_heading(category) 
then calculate the actual percentage of the total risk in each category 
order by the total
*/
declare @applicationMode varchar(50)

exec dbo.GetApplicationModeDefault @assessment_id, @ApplicationMode output


declare @maxRank int 
if(@ApplicationMode = 'Questions Based')	
begin	
		select a.Answer_Full_Name, a.Short_Name, a.Answer_Text, 
			isnull(m.qc,0) as [qc],
			isnull(m.Total,0) as [Total], 
			isnull(cast(IsNull(Round((cast((qc) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int),0) as [Percent] 
		from (select Short_Name,l.Answer_Full_Name,l.Answer_Text from AVAILABLE_STANDARDS a 
		join SETS s on a.Set_Name = s.Set_Name
		, ANSWER_LOOKUP l
		where a.Assessment_Id = @assessment_id) a left join (
		SELECT ms.Short_Name, a.Answer_Text, isnull(count(c.question_id),0) qc, SUM(count(c.question_id)) OVER(PARTITION BY Short_Name) AS Total
				FROM Answer_Questions a 
				join NEW_QUESTION c on a.Question_Or_Requirement_Id = c.Question_Id				
				join NEW_QUESTION_SETS s on c.Question_Id = s.Question_Id
				join [sets] ms on s.Set_Name = ms.Set_Name
				join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
				join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id 
				join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
				join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
				where a.Assessment_Id = @assessment_id and v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = ul.Universal_Sal_Level
				group by ms.Short_Name, a.Answer_Text
		) m on a.Answer_Text = m.Answer_Text AND a.Short_Name = m.Short_Name
		order by Short_Name
end
else 
begin 
		select a.Answer_Full_Name, a.Short_Name, a.Answer_Text,
			isnull(m.[qc], 0) as [qc], 
			isnull(m.[Total], 0) as [Total],
			isnull(cast(IsNull(Round((cast((qc) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int),0) as [Percent] 
		from (select Short_Name,l.Answer_Full_Name,l.Answer_Text from AVAILABLE_STANDARDS a 
		join SETS s on a.Set_Name = s.Set_Name
		, ANSWER_LOOKUP l
		where a.Assessment_Id = @assessment_id) a left join (
		SELECT ms.Short_Name, a.Answer_Text, isnull(count(c.Requirement_Id),0) qc, SUM(count(c.Requirement_Id)) OVER(PARTITION BY Short_Name) AS Total  
				FROM Answer_Requirements a 
				join NEW_REQUIREMENT c on a.Question_Or_Requirement_Id = c.Requirement_Id				
				join REQUIREMENT_SETS s on c.Requirement_Id = s.Requirement_Id		
				join [sets] ms on s.Set_Name = ms.Set_Name		
				join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 			
				join REQUIREMENT_LEVELS rl on c.Requirement_Id = rl.Requirement_Id									
				join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
				join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
				where a.Assessment_Id = @assessment_id and v.Selected = 1 and v.Assessment_Id = @assessment_id and rl.Standard_Level = ul.Universal_Sal_Level
				group by ms.Short_Name, a.Answer_Text
	   ) m on a.Answer_Text = m.Answer_Text AND a.Short_Name = m.Short_Name
	   order by Short_Name
end
END







GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_getStandardsResultsByCategory]'
GO
-- =============================================
-- Author:		hansbk
-- Create date: 8/1/2018
-- Description:	Stub needs completed
-- =============================================
ALTER PROCEDURE [dbo].[usp_getStandardsResultsByCategory]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	/*
TODO this needs to take into account requirements vs questions
get the question set then for all the questions take the total risk (in this set only)
then calculate the total risk in each question_group_heading(category) 
then calculate the actual percentage of the total risk in each category 
order by the total
*/
declare @applicationMode varchar(50)

exec dbo.GetApplicationModeDefault @assessment_id, @ApplicationMode output


declare @maxRank int 
if(@ApplicationMode = 'Questions Based')	
begin
	

	
	IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp
	IF OBJECT_ID('tempdb..#TempAnswered') IS NOT NULL DROP TABLE #TempAnswered

	SELECT s.Set_Name,Question_Group_Heading,isnull(count(c.question_id),0) qc into #temp	
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id
		join vQuestion_Headings h on c.Heading_Pair_Id=h.heading_pair_Id		
		join NEW_QUESTION_SETS s on c.Question_Id = s.Question_Id
		join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
		join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id 
		join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
		join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
		where a.Assessment_Id = @assessment_id and a.Answer_Text != 'NA' and v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = ul.Universal_Sal_Level
		group by s.Set_Name, Question_Group_Heading

	insert into #temp (Set_Name,Question_Group_Heading, QC) 
	select a.Set_name,a.Question_Group_Heading, qc=0 from 
	(select * from (select distinct question_group_heading from #temp) a, (select distinct set_name from #temp) b) a 
	left join #temp on a.question_group_heading=#temp.question_group_heading and a.set_name = #temp.set_name
	where #temp.set_name is null

	SELECT s.Set_Name,Question_Group_Heading,isnull(count(c.question_id),0) qc into #tempAnswered
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id
		join vQuestion_Headings h on c.Heading_Pair_Id=h.heading_pair_Id		
		join NEW_QUESTION_SETS s on c.Question_Id = s.Question_Id
		join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
		join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id 
		join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
		join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
		where a.Assessment_Id = @assessment_id and a.Answer_Text in ('Y','A') and v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = ul.Universal_Sal_Level
		group by s.Set_Name, Question_Group_Heading
     
	select t.Set_Name,
	s.Short_Name,
	t.Question_Group_Heading, 
	isnull(a.qc,0) yaCount, 
	isnull(t.qc,0) Actualcr, 
	round(isnull(cast(a.qc as decimal(18,3))/t.qc,0),5) * 100 [prc]
	from #temp t left join #tempAnswered a on t.Set_Name = a.Set_Name and  t.Question_Group_Heading = a.Question_Group_Heading
	join [SETS] s on t.Set_Name = s.Set_Name
	order by Question_Group_Heading desc	
end
else 
begin 

	IF OBJECT_ID('tempdb..#TempR') IS NOT NULL DROP TABLE #TempR
	IF OBJECT_ID('tempdb..#TempRAnswer') IS NOT NULL DROP TABLE #TempRAnswer

	SELECT s.set_name, h.Question_Group_Heading, isnull(count(c.Requirement_Id),0) qc into #tempR
		FROM Answer_Requirements a 
		join NEW_REQUIREMENT c on a.Question_Or_Requirement_Id=c.Requirement_Id
		join QUESTION_GROUP_HEADING h on c.Question_Group_Heading_Id = h.Question_Group_Heading_Id
		join REQUIREMENT_SETS s on c.Requirement_Id = s.Requirement_Id
		join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 		
		where a.Assessment_Id = @assessment_id and v.Assessment_Id = a.Assessment_Id and v.Selected = 1 and a.Answer_Text <> 'NA'
		group by s.set_name, Question_Group_Heading

			/**for multiple sets get the unique list of sets and question_group headers
	   take the cross product 
	   left join and fill with zero
	   Essentially fill in the gaps on the categories
	   */


	insert into #tempR (Set_Name,Question_Group_Heading, QC) 
	select a.Set_name,a.Question_Group_Heading, qc=0 from 
	(select * from (select distinct question_group_heading from #tempR) a, (select distinct set_name from #tempR) b) a 
	left join #tempR on a.question_group_heading=#tempR.question_group_heading and a.set_name = #tempR.set_name
	where #tempR.set_name is null

	SELECT s.set_name, h.Question_Group_Heading,count(c.Requirement_Id) qc into #tempRAnswer
		FROM Answer_Requirements a 
		join NEW_REQUIREMENT c on a.Question_Or_Requirement_Id=c.Requirement_Id
		join QUESTION_GROUP_HEADING h on c.Question_Group_Heading_Id = h.Question_Group_Heading_Id
		join REQUIREMENT_SETS s on c.Requirement_Id = s.Requirement_Id
		join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 		
		where a.Assessment_Id = @assessment_id and v.Assessment_Id = a.Assessment_Id and v.Selected = 1 and a.Answer_Text in ('Y','A')
		group by s.set_name, Question_Group_Heading

	select t.Set_Name, 
	s.Short_Name, 
	t.Question_Group_Heading, 
	isnull(a.qc,0) yaCount, 
	isnull(t.qc,0) Actualcr, 
	--isnull(a.qc,0)/cast(t.qc as decimal(18,3)) * 100 [prc]
	round(isnull(cast(a.qc as decimal(18,3))/t.qc,0),5) * 100 [prc]
	from #tempR t 
	left join #tempRAnswer a on t.Set_Name = a.Set_Name and t.Question_Group_Heading = a.Question_Group_Heading
	join [SETS] s on t.Set_Name = s.Set_Name
	order by Question_Group_Heading desc
end
END



	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_getComponentsResultsByCategory]'
GO
-- =============================================
-- Author:		woodrk
-- Create date: 8/20/2019
-- Description:	Get answered component questions by category
-- =============================================
ALTER PROCEDURE [dbo].[usp_getComponentsResultsByCategory]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	-- get all answers
	select Question_Group_Heading, ISNULL(COUNT(q.question_id),0) qc into #temp	
	from Answer_Components_InScope a
	left join NEW_QUESTION q on q.Question_Id = a.question_or_requirement_id
	left join vQUESTION_HEADINGS h on h.Heading_Pair_Id = q.Heading_Pair_Id
	where a.Assessment_Id = @assessment_id and a.Answer_Text != 'NA' 
	group by Question_Group_Heading


	-- get passing answers (Y, A)
	SELECT Question_Group_Heading, ISNULL(COUNT(q.question_id),0) qc into #tempAnswered
	from Answer_Components_InScope a
	left join NEW_QUESTION q on q.Question_Id = a.question_or_requirement_id
	left join vQUESTION_HEADINGS h on h.Heading_Pair_Id = q.Heading_Pair_Id		
	where a.Assessment_Id = @assessment_id and a.Answer_Text in ('Y','A') 	
	group by Question_Group_Heading


	-- calc totals/percentage of passing		 
	select t.Question_Group_Heading, 
	ISNULL(a.qc,0) as [passed], 
	ISNULL(t.qc,0) as [total], 
	ROUND(ISNULL(CAST(a.qc as decimal(18,3))/t.qc,0),5) * 100 as [percent]
	from #temp t left join #tempAnswered a on t.Question_Group_Heading = a.Question_Group_Heading
	order by Question_Group_Heading	
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_getComponentsRankedCategories]'
GO

-- =============================================
-- Author:		hansbk
-- Create date: 8/1/2018
-- Description:	Stub needs completed
-- =============================================
ALTER PROCEDURE [dbo].[usp_getComponentsRankedCategories]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

/*
TODO this needs to take into account requirements vs questions
get the question set then for all the questions take the total risk (in this set only)
then calculate the total risk in each question_group_heading(category) 
then calculate the actual percentage of the total risk in each category 
order by the total
*/
declare @applicationMode varchar(50)

exec dbo.GetApplicationModeDefault @assessment_id, @ApplicationMode output


declare @maxRank int 
begin

	--declare @assessment_id int
	--set @assessment_id = 1041
	select @maxRank = max(c.Ranking) 
		FROM NEW_QUESTION c 
		join (select distinct question_id from NEW_QUESTION_SETS where Set_Name = 'Components')
		s on c.Question_Id = s.Question_Id

	

	IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp
	IF OBJECT_ID('tempdb..#TempAnswered') IS NOT NULL DROP TABLE #TempAnswered

	SELECT h.Question_Group_Heading,isnull(count(c.question_id),0) qc,  isnull(SUM(@maxRank-c.Ranking),0) cr, sum(sum(@maxrank - c.Ranking)) OVER() AS Total into #temp
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id
		join vQuestion_Headings h on c.Heading_Pair_Id=h.heading_pair_Id		
		join (
			select distinct s.question_id from NEW_QUESTION_SETS s 
				join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id				
				join UNIVERSAL_SAL_LEVEL ul on l.Universal_Sal_Level = ul.Universal_Sal_Level
				where s.Set_Name = 'Components'
		)
		s on c.Question_Id = s.Question_Id
		where a.Assessment_Id = @assessment_id and a.Answer_Text != 'NA'
		group by Question_Group_Heading
     
	 SELECT h.Question_Group_Heading, isnull(count(c.question_id),0) nuCount, isnull(SUM(@maxRank-c.Ranking),0) cr into #tempAnswered
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id
		join vQuestion_Headings h on c.Heading_Pair_Id=h.heading_pair_Id
		join (
			select distinct s.question_id from NEW_QUESTION_SETS s 
				join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id				
				join UNIVERSAL_SAL_LEVEL ul on l.Universal_Sal_Level = ul.Universal_Sal_Level
				where s.Set_Name = 'Components'
		)	s on c.Question_Id = s.Question_Id
		where a.Assessment_Id = @assessment_id and a.Answer_Text in ('N','U')
		group by Question_Group_Heading

	select t.*, isnull(a.nuCount,0) nuCount, isnull(a.cr,0) Actualcr, isnull(cast(a.cr as decimal(18,3))/Total,0)*100 [prc],  isnull(a.nuCount,0)/(cast(qc as decimal(18,3))) as [Percent]
	from #temp t left join #tempAnswered a on t.Question_Group_Heading = a.Question_Group_Heading
	order by prc desc	
end
END

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_getComponentTypes]'
GO
-- =============================================
-- Author:		hansbk
-- Create date: 8/1/2018
-- Description:	remember the answer values are percents
-- =============================================
ALTER PROCEDURE [dbo].[usp_getComponentTypes]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		SELECT Assessment_Id,
			Component_Symbol_Id,
			Symbol_Name,
			cast(IsNull(Round((cast(([Y]) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int) as [Y],			
			cast(IsNull(Round((cast(([N]) as float)/isnull(nullif(Total,0),1))*100,0),0) as int) as [N],
			cast(IsNull(Round((cast(([NA]) as float)/isnull(nullif(Total,0),1))*100,0),0) as int) as [NA],
			cast(IsNull(Round((cast(([A]) as float)/isnull(nullif(Total,0),1))*100,0),0) as int) as [A],
			cast(IsNull(Round((cast(([U]) as float)/isnull(nullif(Total,0),1))*100,0),0) as int) as [U],
			ISNULL(Total,0) as [Total], 
			((cast(([Y]+ isnull([A],0)) as float)/isnull(nullif(Total-nullif([NA],0),0),1))*100) as Value, 			
			(Total-[NA]) as TotalNoNA 
		FROM 
		(	
			select Assessment_Id, b.Component_Symbol_Id, s.Symbol_Name,
			isnull(Acount,0) as Acount, aw.answer_text, SUM(acount) OVER(PARTITION BY Assessment_Id, b.Component_Symbol_Id) AS Total  
			from (select Component_Symbol_Id, answer_text from ANSWER_LOOKUP a, assessment_diagram_components c
			where c.assessment_id = @assessment_id) aw 
			left join (
				select assessment_id, a.Component_Symbol_Id, a.answer_text, count(a.answer_text) acount 
				from Answer_Components_Inscope a 
				where a.assessment_id = @assessment_id
				group by assessment_id, Component_Symbol_Id, a.answer_text) b 
			on aw.Answer_Text = b.answer_text and aw.Component_Symbol_Id = b.Component_Symbol_Id
			left join COMPONENT_SYMBOLS s on s.Component_Symbol_Id = b.Component_Symbol_Id
			where b.Component_Symbol_Id is not null
		) p
		PIVOT
		(
		sum(acount)
		FOR answer_text IN
		( [Y],[N],[NA],[A],[U] )
		) AS pvt
		where Assessment_Id is not null
		ORDER BY pvt.Component_Symbol_Id;

END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[FillNetworkDiagramQuestions]'
GO
-- =============================================
-- Author:		hansbk
-- Create date: 9/27/2019
-- Description:	calll to get defaults
-- =============================================
CREATE PROCEDURE [dbo].[FillNetworkDiagramQuestions]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

	delete a from ANSWER a 
		left join (SELECT distinct q.question_id 
				FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] a 			
				join component_questions q on a.Component_Symbol_Id = q.Component_Symbol_Id
				join STANDARD_SELECTION ss on a.Assessment_Id = ss.Assessment_Id
				join new_question nq on q.question_id=nq.question_id
				join new_question_sets qs on nq.question_id=qs.question_id		
				left join dbo.DIAGRAM_CONTAINER AS z ON a.Zone_Id =z.Container_Id
				join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id and nql.Universal_Sal_Level = dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))
				where a.assessment_id = @assessment_id and qs.Set_Name = 'Components') b on a.Question_Or_Requirement_Id = b.Question_Id and a.Assessment_Id = @assessment_id
		where b.Question_Id is null and Is_Component = 1 and Assessment_Id = @assessment_id

    /*Rules for Component questions
	For the default questions 
	select the set of component types and questions associated with the component types
	then insert an answer for each unique question in that list. 
	this needs filterd for level

	the major dimensions are 
	*/
	--generate defaults 
	INSERT INTO [dbo].[ANSWER]  ([Is_Requirement],[Question_Or_Requirement_Id],[Answer_Text],[Is_Component],[Is_Framework],[Assessment_Id])   	  		
		select Is_Requirement = 0,Question_id, Answer_Text = 'U', Is_Component = '1', Is_Framework = 0, Assessment_Id = @Assessment_Id 
		from (select * from [ANSWER] where [Assessment_Id] = @assessment_id and [IS_COMPONENT] = 1) a 		
		right join 
		(SELECT distinct q.question_id 
		FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] a 			
		join component_questions q on a.Component_Symbol_Id = q.Component_Symbol_Id
		join STANDARD_SELECTION ss on a.Assessment_Id = ss.Assessment_Id
		join new_question nq on q.question_id=nq.question_id
		join new_question_sets qs on nq.question_id=qs.question_id		
		left join dbo.DIAGRAM_CONTAINER AS z ON a.Zone_Id =z.Container_Id
		join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id and nql.Universal_Sal_Level = dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))
		where a.assessment_id = @assessment_id and qs.Set_Name = 'Components'
		) t 		
		on a.Question_Or_Requirement_Id = t.question_id
		where assessment_id is null
		and Question_Or_Requirement_Id not in 
		(select [Question_Or_Requirement_Id] from [ANSWER] where [Assessment_Id] = @assessment_id and [Component_Guid] = CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER))
END

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[RelevantAnswers]'
GO
-- =============================================
-- Author:		Randy Woods
-- Create date: 29-May-2019
-- Description:	This proc is a wrapper for GetRelevantAnswers and returns 
--              everything it comes up with.
-- =============================================
CREATE PROCEDURE [dbo].[RelevantAnswers]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    ------------- get relevant answers ----------------
	IF OBJECT_ID('tempdb..#answers') IS NOT NULL DROP TABLE #answers

	create table #answers (assessment_id int, answer_id int, is_requirement bit, question_or_requirement_id int, mark_for_review bit, 
	comment ntext, alternate_justification ntext, question_number int, answer_text varchar(50), 
	component_guid varchar(36), is_component bit, custom_question_guid varchar(50), is_framework bit, old_answer_id int, reviewed bit)

	insert into #answers exec [GetRelevantAnswers] @assessment_id

----------------------------------------

	
	SELECT a.*
			FROM #answers a 				
			where a.Assessment_Id = @assessment_id 
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_getStandardSummaryOverall]'
GO
-- =============================================
-- Author:		hansbk
-- Create date: 8/30/2018
-- Description:	Stub needs completed
-- =============================================
ALTER PROCEDURE [dbo].[usp_getStandardSummaryOverall]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	/*
TODO this needs to take into account requirements vs questions
get the question set then for all the questions take the total risk (in this set only)
then calculate the total risk in each question_group_heading(category) 
then calculate the actual percentage of the total risk in each category 
order by the total
*/
declare @applicationMode varchar(50)

exec dbo.GetApplicationModeDefault @assessment_id, @ApplicationMode output


------------- get relevant answers ----------------
	IF OBJECT_ID('tempdb..#answers') IS NOT NULL DROP TABLE #answers

	create table #answers (assessment_id int, answer_id int, is_requirement bit, question_or_requirement_id int, mark_for_review bit, 
	comment ntext, alternate_justification ntext, question_number int, answer_text varchar(50), 
	component_guid varchar(36), is_component bit, custom_question_guid varchar(50), is_framework bit, old_answer_id int, reviewed bit)

	insert into #answers exec [GetRelevantAnswers] @assessment_id

----------------------------------------

	
	select a.Answer_Full_Name,a.Answer_Text, isnull(m.qc,0) qc,isnull(m.Total,0) Total, isnull(cast(IsNull(Round((cast((qc) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int),0)  as [Percent] 
	from ANSWER_LOOKUP a left join (
	SELECT a.Answer_Text, isnull(count(a.question_or_requirement_id),0) qc, SUM(count(a.question_or_requirement_id)) OVER() AS Total
			FROM #answers a 				
			where a.Assessment_Id = @assessment_id 
			group by a.Answer_Text
	) m on a.Answer_Text = m.Answer_Text

END

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[DIAGRAM_TEMPLATES]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[DIAGRAM_TEMPLATES] ADD
[Diagram_Markup] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Image_Source] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[COMPONENT_SYMBOLS_GM_TO_CSET]'
GO
CREATE TABLE [dbo].[COMPONENT_SYMBOLS_GM_TO_CSET]
(
[GM_FingerType] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Id] [int] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_COMPONENT_SYMBOLS_GM_TO_CSET] on [dbo].[COMPONENT_SYMBOLS_GM_TO_CSET]'
GO
ALTER TABLE [dbo].[COMPONENT_SYMBOLS_GM_TO_CSET] ADD CONSTRAINT [PK_COMPONENT_SYMBOLS_GM_TO_CSET] PRIMARY KEY CLUSTERED  ([GM_FingerType])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SHAPE_TYPES]'
GO
CREATE TABLE [dbo].[SHAPE_TYPES]
(
[Diagram_Type_XML] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Telerik_Shape_Type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Visio_Shape_Type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsDefault] [bit] NOT NULL,
[DisplayName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Shape_Types] on [dbo].[SHAPE_TYPES]'
GO
ALTER TABLE [dbo].[SHAPE_TYPES] ADD CONSTRAINT [PK_Shape_Types] PRIMARY KEY CLUSTERED  ([Diagram_Type_XML])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[USERS]'
GO
ALTER TABLE [dbo].[USERS] ADD CONSTRAINT [IX_USERS] UNIQUE NONCLUSTERED  ([PrimaryEmail])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[ASSESSMENTS_REQUIRED_DOCUMENTATION]'
GO
ALTER TABLE [dbo].[ASSESSMENTS_REQUIRED_DOCUMENTATION] ADD CONSTRAINT [CK_ASSESSMENTS_REQUIRED_DOCUMENTATION] CHECK (([Answer]='NA' OR [Answer]='N' OR [Answer]='Y' OR [Answer]='U'))
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[COMPONENT_QUESTIONS]'
GO
ALTER TABLE [dbo].[COMPONENT_QUESTIONS] WITH NOCHECK  ADD CONSTRAINT [FK_Component_Questions_NEW_QUESTION] FOREIGN KEY ([Question_Id]) REFERENCES [dbo].[NEW_QUESTION] ([Question_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[DIAGRAM_CONTAINER]'
GO
ALTER TABLE [dbo].[DIAGRAM_CONTAINER] WITH NOCHECK  ADD CONSTRAINT [FK_DIAGRAM_CONTAINER_DIAGRAM_CONTAINER] FOREIGN KEY ([Parent_Id]) REFERENCES [dbo].[DIAGRAM_CONTAINER] ([Container_Id]) NOT FOR REPLICATION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[VISIO_MAPPING]'
GO
ALTER TABLE [dbo].[VISIO_MAPPING] WITH NOCHECK  ADD CONSTRAINT [FK_VISIO_MAPPING_DIAGRAM_TYPES] FOREIGN KEY ([Specific_Type]) REFERENCES [dbo].[DIAGRAM_TYPES] ([Specific_Type]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[NEW_QUESTION_SETS]'
GO
ALTER TABLE [dbo].[NEW_QUESTION_SETS] WITH NOCHECK  ADD CONSTRAINT [FK_NEW_QUESTION_SETS_NEW_QUESTION] FOREIGN KEY ([Question_Id]) REFERENCES [dbo].[NEW_QUESTION] ([Question_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[NEW_REQUIREMENT]'
GO
ALTER TABLE [dbo].[NEW_REQUIREMENT] WITH NOCHECK  ADD CONSTRAINT [FK_NEW_REQUIREMENT_NCSF_Category] FOREIGN KEY ([NCSF_Cat_Id]) REFERENCES [dbo].[NCSF_CATEGORY] ([NCSF_Cat_Id])
GO
ALTER TABLE [dbo].[NEW_REQUIREMENT] WITH NOCHECK  ADD CONSTRAINT [FK_NEW_REQUIREMENT_SETS] FOREIGN KEY ([Original_Set_Name]) REFERENCES [dbo].[SETS] ([Set_Name]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[NEW_REQUIREMENT] WITH NOCHECK  ADD CONSTRAINT [FK_NEW_REQUIREMENT_STANDARD_CATEGORY] FOREIGN KEY ([Standard_Category]) REFERENCES [dbo].[STANDARD_CATEGORY] ([Standard_Category]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[PARAMETER_REQUIREMENTS]'
GO
ALTER TABLE [dbo].[PARAMETER_REQUIREMENTS] WITH NOCHECK  ADD CONSTRAINT [FK_Parameter_Requirements_NEW_REQUIREMENT] FOREIGN KEY ([Requirement_Id]) REFERENCES [dbo].[NEW_REQUIREMENT] ([Requirement_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[REQUIREMENT_REFERENCES]'
GO
ALTER TABLE [dbo].[REQUIREMENT_REFERENCES] WITH NOCHECK  ADD CONSTRAINT [FK_REQUIREMENT_REFERENCES_NEW_REQUIREMENT] FOREIGN KEY ([Requirement_Id]) REFERENCES [dbo].[NEW_REQUIREMENT] ([Requirement_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[REQUIREMENT_SOURCE_FILES]'
GO
ALTER TABLE [dbo].[REQUIREMENT_SOURCE_FILES] WITH NOCHECK  ADD CONSTRAINT [FK_REQUIREMENT_SOURCE_FILES_NEW_REQUIREMENT] FOREIGN KEY ([Requirement_Id]) REFERENCES [dbo].[NEW_REQUIREMENT] ([Requirement_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[ANSWER]'
GO
ALTER TABLE [dbo].[ANSWER] WITH NOCHECK  ADD CONSTRAINT [FK_ANSWER_ASSESSMENTS] FOREIGN KEY ([Assessment_Id]) REFERENCES [dbo].[ASSESSMENTS] ([Assessment_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[NERC_RISK_RANKING]'
GO
ALTER TABLE [dbo].[NERC_RISK_RANKING] WITH NOCHECK  ADD CONSTRAINT [FK_NERC_RISK_RANKING_NEW_REQUIREMENT] FOREIGN KEY ([Requirement_Id]) REFERENCES [dbo].[NEW_REQUIREMENT] ([Requirement_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[REQUIREMENT_LEVELS]'
GO
ALTER TABLE [dbo].[REQUIREMENT_LEVELS] WITH NOCHECK  ADD CONSTRAINT [FK_REQUIREMENT_LEVELS_NEW_REQUIREMENT] FOREIGN KEY ([Requirement_Id]) REFERENCES [dbo].[NEW_REQUIREMENT] ([Requirement_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[REQUIREMENT_QUESTIONS]'
GO
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS] WITH NOCHECK  ADD CONSTRAINT [FK_REQUIREMENT_QUESTIONS_NEW_REQUIREMENT] FOREIGN KEY ([Requirement_Id]) REFERENCES [dbo].[NEW_REQUIREMENT] ([Requirement_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[REQUIREMENT_SETS]'
GO
ALTER TABLE [dbo].[REQUIREMENT_SETS] WITH NOCHECK  ADD CONSTRAINT [FK_REQUIREMENT_SETS_NEW_REQUIREMENT] FOREIGN KEY ([Requirement_Id]) REFERENCES [dbo].[NEW_REQUIREMENT] ([Requirement_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS]'
GO
ALTER TABLE [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] ADD CONSTRAINT [FK_ASSESSMENT_DIAGRAM_COMPONENTS_ASSESSMENTS] FOREIGN KEY ([Assessment_Id]) REFERENCES [dbo].[ASSESSMENTS] ([Assessment_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] ADD CONSTRAINT [FK_ASSESSMENT_DIAGRAM_COMPONENTS_COMPONENT_SYMBOLS1] FOREIGN KEY ([Component_Symbol_Id]) REFERENCES [dbo].[COMPONENT_SYMBOLS] ([Component_Symbol_Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] ADD CONSTRAINT [FK_ASSESSMENT_DIAGRAM_COMPONENTS_DIAGRAM_CONTAINER1] FOREIGN KEY ([Zone_Id]) REFERENCES [dbo].[DIAGRAM_CONTAINER] ([Container_Id])
GO
ALTER TABLE [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] ADD CONSTRAINT [FK_ASSESSMENT_DIAGRAM_COMPONENTS_DIAGRAM_CONTAINER] FOREIGN KEY ([Layer_Id]) REFERENCES [dbo].[DIAGRAM_CONTAINER] ([Container_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[COMPONENT_NAMES_LEGACY]'
GO
ALTER TABLE [dbo].[COMPONENT_NAMES_LEGACY] ADD CONSTRAINT [FK_COMPONENT_NAMES_LEGACY_COMPONENT_SYMBOLS] FOREIGN KEY ([Component_Symbol_id]) REFERENCES [dbo].[COMPONENT_SYMBOLS] ([Component_Symbol_Id]) ON DELETE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[COMPONENT_QUESTIONS]'
GO
ALTER TABLE [dbo].[COMPONENT_QUESTIONS] ADD CONSTRAINT [FK_COMPONENT_QUESTIONS_COMPONENT_SYMBOLS] FOREIGN KEY ([Component_Symbol_Id]) REFERENCES [dbo].[COMPONENT_SYMBOLS] ([Component_Symbol_Id]) ON DELETE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[COMPONENT_SYMBOLS]'
GO
ALTER TABLE [dbo].[COMPONENT_SYMBOLS] ADD CONSTRAINT [FK_COMPONENT_SYMBOLS_COMPONENT_FAMILY] FOREIGN KEY ([Component_Family_Name]) REFERENCES [dbo].[COMPONENT_FAMILY] ([Component_Family_Name]) ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[COMPONENT_SYMBOLS] ADD CONSTRAINT [FK_COMPONENT_SYMBOLS_SYMBOL_GROUPS] FOREIGN KEY ([Symbol_Group_Id]) REFERENCES [dbo].[SYMBOL_GROUPS] ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[STATES_AND_PROVINCES]'
GO
ALTER TABLE [dbo].[STATES_AND_PROVINCES] ADD CONSTRAINT [FK_STATES_AND_PROVINCES_COUNTRIES] FOREIGN KEY ([Country_Code]) REFERENCES [dbo].[COUNTRIES] ([ISO_code]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[DIAGRAM_CONTAINER]'
GO
ALTER TABLE [dbo].[DIAGRAM_CONTAINER] ADD CONSTRAINT [FK_DIAGRAM_CONTAINER_DIAGRAM_CONTAINER_TYPES] FOREIGN KEY ([ContainerType]) REFERENCES [dbo].[DIAGRAM_CONTAINER_TYPES] ([ContainerType]) ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[DIAGRAM_TYPES]'
GO
ALTER TABLE [dbo].[DIAGRAM_TYPES] ADD CONSTRAINT [FK_DIAGRAM_TYPES_DIAGRAM_OBJECT_TYPES] FOREIGN KEY ([Object_Type]) REFERENCES [dbo].[DIAGRAM_OBJECT_TYPES] ([Object_Type])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[FINANCIAL_DOMAIN_FILTERS]'
GO
ALTER TABLE [dbo].[FINANCIAL_DOMAIN_FILTERS] ADD CONSTRAINT [FK_FINANCIAL_DOMAIN_FILTERS_ASSESSMENTS] FOREIGN KEY ([Assessment_Id]) REFERENCES [dbo].[ASSESSMENTS] ([Assessment_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[FINANCIAL_DOMAIN_FILTERS] ADD CONSTRAINT [FK_FINANCIAL_DOMAIN_FILTERS_FINANCIAL_DOMAINS] FOREIGN KEY ([DomainId]) REFERENCES [dbo].[FINANCIAL_DOMAINS] ([DomainId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[FINANCIAL_QUESTIONS]'
GO
ALTER TABLE [dbo].[FINANCIAL_QUESTIONS] ADD CONSTRAINT [FK_FINANCIAL_QUESTIONS_NEW_QUESTION] FOREIGN KEY ([Question_Id]) REFERENCES [dbo].[NEW_QUESTION] ([Question_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[FINANCIAL_REQUIREMENTS]'
GO
ALTER TABLE [dbo].[FINANCIAL_REQUIREMENTS] ADD CONSTRAINT [FK_FINANCIAL_REQUIREMENTS_NEW_REQUIREMENT] FOREIGN KEY ([Requirement_Id]) REFERENCES [dbo].[NEW_REQUIREMENT] ([Requirement_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[NETWORK_WARNINGS]'
GO
ALTER TABLE [dbo].[NETWORK_WARNINGS] ADD CONSTRAINT [FK_NETWORK_WARNING_ASSESSMENTS] FOREIGN KEY ([Assessment_Id]) REFERENCES [dbo].[ASSESSMENTS] ([Assessment_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[NEW_REQUIREMENT]'
GO
ALTER TABLE [dbo].[NEW_REQUIREMENT] ADD CONSTRAINT [FK_NEW_REQUIREMENT_QUESTION_GROUP_HEADING] FOREIGN KEY ([Question_Group_Heading_Id]) REFERENCES [dbo].[QUESTION_GROUP_HEADING] ([Question_Group_Heading_Id]) ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[REQUIREMENT_QUESTIONS_SETS]'
GO
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS_SETS] ADD CONSTRAINT [FK_REQUIREMENT_QUESTIONS_SETS_NEW_REQUIREMENT] FOREIGN KEY ([Requirement_Id]) REFERENCES [dbo].[NEW_REQUIREMENT] ([Requirement_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS_SETS] ADD CONSTRAINT [FK_REQUIREMENT_QUESTIONS_SETS_NEW_QUESTION] FOREIGN KEY ([Question_Id]) REFERENCES [dbo].[NEW_QUESTION] ([Question_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[SUB_CATEGORY_ANSWERS]'
GO
ALTER TABLE [dbo].[SUB_CATEGORY_ANSWERS] ADD CONSTRAINT [FK_SUB_CATEGORY_ANSWERS_ASSESSMENTS] FOREIGN KEY ([Assessement_Id]) REFERENCES [dbo].[ASSESSMENTS] ([Assessment_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[SUB_CATEGORY_ANSWERS] ADD CONSTRAINT [FK_SUB_CATEGORY_ANSWERS_UNIVERSAL_SUB_CATEGORY_HEADINGS] FOREIGN KEY ([Heading_Pair_Id]) REFERENCES [dbo].[UNIVERSAL_SUB_CATEGORY_HEADINGS] ([Heading_Pair_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[ASSESSMENT_CONTACTS]'
GO
ALTER TABLE [dbo].[ASSESSMENT_CONTACTS] ADD CONSTRAINT [FK_ASSESSMENT_CONTACTS_USERS] FOREIGN KEY ([UserId]) REFERENCES [dbo].[USERS] ([UserId]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[ASSESSMENTS]'
GO
ALTER TABLE [dbo].[ASSESSMENTS] ADD CONSTRAINT [FK_ASSESSMENTS_USERS] FOREIGN KEY ([AssessmentCreatorId]) REFERENCES [dbo].[USERS] ([UserId]) ON DELETE SET NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[USER_SECURITY_QUESTIONS]'
GO
ALTER TABLE [dbo].[USER_SECURITY_QUESTIONS] ADD CONSTRAINT [FK_USER_SECURITY_QUESTIONS_USERS] FOREIGN KEY ([UserId]) REFERENCES [dbo].[USERS] ([UserId]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Disabling constraints on [dbo].[DIAGRAM_CONTAINER]'
GO
ALTER TABLE [dbo].[DIAGRAM_CONTAINER] NOCHECK CONSTRAINT [FK_DIAGRAM_CONTAINER_DIAGRAM_CONTAINER]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Disabling constraints on [dbo].[NEW_REQUIREMENT]'
GO
ALTER TABLE [dbo].[NEW_REQUIREMENT] NOCHECK CONSTRAINT [FK_NEW_REQUIREMENT_SETS]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Disabling constraints on [dbo].[NEW_QUESTION]'
GO
ALTER TABLE [dbo].[NEW_QUESTION] NOCHECK CONSTRAINT [FK_NEW_QUESTION_SETS]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[ASSESSMENTS_REQUIRED_DOCUMENTATION]'
GO
ALTER TABLE [dbo].[ASSESSMENTS_REQUIRED_DOCUMENTATION] ADD CONSTRAINT [DF_ASSESSMENTS_REQUIRED_DOCUMENTATION_Answer] DEFAULT ('U') FOR [Answer]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating extended properties'
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'BELONGS_IN_EA', 'YES', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_QUESTIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', '', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_QUESTIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', 'The Question Id is used to', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_QUESTIONS', 'COLUMN', N'Question_Id'
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', 'The Rank is used to', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_QUESTIONS', 'COLUMN', N'Rank'
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', 'The Seq is used to', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_QUESTIONS', 'COLUMN', N'Seq'
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', 'The Weight is used to', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_QUESTIONS', 'COLUMN', N'Weight'
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'BELONGS_IN_EA', 'YES', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_SYMBOLS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', '', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_SYMBOLS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', 'The Abbreviation is used to', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_SYMBOLS', 'COLUMN', N'Abbreviation'
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', 'The Component Family Name is used to', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_SYMBOLS', 'COLUMN', N'Component_Family_Name'
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', 'The Id is used to', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_SYMBOLS', 'COLUMN', N'Component_Symbol_Id'
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', 'The File Name is used to', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_SYMBOLS', 'COLUMN', N'File_Name'
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', 'The Symbol Group Id is used to', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_SYMBOLS', 'COLUMN', N'Symbol_Group_Id'
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'BELONGS_IN_EA', 'YES', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_SYMBOLS_GM_TO_CSET', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', '', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_SYMBOLS_GM_TO_CSET', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'BELONGS_IN_EA', 'YES', 'SCHEMA', N'dbo', 'TABLE', N'DIAGRAM_OBJECT_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', '', 'SCHEMA', N'dbo', 'TABLE', N'DIAGRAM_OBJECT_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'BELONGS_IN_EA', 'YES', 'SCHEMA', N'dbo', 'TABLE', N'DIAGRAM_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', '', 'SCHEMA', N'dbo', 'TABLE', N'DIAGRAM_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'BELONGS_IN_EA', 'YES', 'SCHEMA', N'dbo', 'TABLE', N'SHAPE_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', '', 'SCHEMA', N'dbo', 'TABLE', N'SHAPE_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', 'The Component Id is used to', 'SCHEMA', N'dbo', 'TABLE', N'SUB_CATEGORY_ANSWERS', 'COLUMN', N'Component_Guid'
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'BELONGS_IN_EA', 'YES', 'SCHEMA', N'dbo', 'TABLE', N'VISIO_MAPPING', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', '', 'SCHEMA', N'dbo', 'TABLE', N'VISIO_MAPPING', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ANSWER"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 427
               Right = 281
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'Answer_Components', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'Answer_Components', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ANSWER"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 413
               Right = 281
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'Answer_Questions_No_Components', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'Answer_Questions_No_Components', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ANSWER"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 465
               Right = 281
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'Answer_Requirements', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'Answer_Requirements', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ADDRESS"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'Answer_Standards_InScope', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'Answer_Standards_InScope', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping users'
GO
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'[INEL-NT\SAMORC]')
	DROP USER [INEL-NT\SAMORC]
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
PRINT N'Altering [dbo].[Answer_Components]'
GO


ALTER VIEW [dbo].[Answer_Components]
AS
SELECT        Answer_Id, Assessment_Id, Mark_For_Review, Comment, Alternate_Justification, Is_Requirement, Question_Or_Requirement_Id, Question_Number, Answer_Text, Component_Guid, Is_Component, Is_Framework,
                          Reviewed
FROM            dbo.ANSWER
WHERE        (Is_Requirement = 0) AND (Is_Component = 1)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[Answer_Components_Default]'
GO

/**
The default consists of one one question 
joined on the types in the diagram
filtered by level 
left joined by the answers
*/
ALTER VIEW [dbo].[Answer_Components_Default]
AS

SELECT                   
	-- This guarantees a unique column to key on in the model
	CONVERT(varchar(100), ROW_NUMBER() OVER (ORDER BY q.Question_id)) as UniqueKey,
	a.Assessment_Id, a.Answer_Id, q.Question_Id, a.Answer_Text, 
	CONVERT(nvarchar(1000), a.Comment) AS Comment, CONVERT(nvarchar(1000), a.Alternate_Justification) AS Alternate_Justification, 
	a.Question_Number, q.Simple_Question AS QuestionText, 		
	h.Question_Group_Heading, usch.Question_Group_Heading_Id as GroupHeadingId, 
	h.Universal_Sub_Category, usch.Universal_Sub_Category_Id as SubCategoryId,
	a.Is_Component, a.Component_Guid, 
	dbo.convert_sal(ss.Selected_Sal_Level) AS SAL, 
	a.Mark_For_Review, a.Is_Requirement, a.Is_Framework,	
	q.heading_pair_id, h.Sub_Heading_Question_Description,
	q.Simple_Question, 
	a.Reviewed, label = null, ComponentName = null, Symbol_Name = null, Component_Symbol_id = 0
from   STANDARD_SELECTION ss
		 join 
		 (SELECT distinct q.question_id,adc.assessment_id
				FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] adc 			
				join component_questions q on adc.Component_Symbol_Id = q.Component_Symbol_Id
				join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
				join new_question nq on q.question_id=nq.question_id		
				join new_question_sets qs on nq.question_id=qs.question_id	and qs.Set_Name = 'Components'		
				join dbo.DIAGRAM_CONTAINER l on adc.Layer_id=l.Container_Id
				left join dbo.DIAGRAM_CONTAINER AS z ON adc.Zone_Id =z.Container_Id
				join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id 
					and nql.Universal_Sal_Level = dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))
				where l.visible = 1) as f  on ss.assessment_id=f.assessment_id							
            join dbo.NEW_QUESTION AS q ON f.Question_Id = q.Question_Id 
			join dbo.vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id	
			join dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS usch on usch.Heading_Pair_Id = h.Heading_Pair_Id		    
			join Answer_Components AS a on f.Question_Id = a.Question_Or_Requirement_Id and f.assessment_id = a.assessment_id	  
where component_guid = '00000000-0000-0000-0000-000000000000'
--order by question_group_heading,universal_sub_category
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'add delete answers trigger'
GO


CREATE TRIGGER dbo.ASSESSMENT_DIAGRAM_COMPONENT_DELETE_Trigger
   ON  dbo.ASSESSMENT_DIAGRAM_COMPONENTS
   For DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	 DELETE dbo.answer FROM deleted
		WHERE answer.Assessment_Id = deleted.Assessment_Id and answer.Component_Guid = deleted.Component_Guid

END
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
