USE [master]
GO
/****** Object:  Database [BankStatements]    Script Date: 8/20/2017 11:25:19 PM ******/
CREATE DATABASE [BankStatements]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BankStatements', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BankStatements.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BankStatements_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BankStatements_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BankStatements] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BankStatements].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BankStatements] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BankStatements] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BankStatements] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BankStatements] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BankStatements] SET ARITHABORT OFF 
GO
ALTER DATABASE [BankStatements] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BankStatements] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BankStatements] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BankStatements] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BankStatements] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BankStatements] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BankStatements] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BankStatements] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BankStatements] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BankStatements] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BankStatements] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BankStatements] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BankStatements] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BankStatements] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BankStatements] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BankStatements] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BankStatements] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BankStatements] SET RECOVERY FULL 
GO
ALTER DATABASE [BankStatements] SET  MULTI_USER 
GO
ALTER DATABASE [BankStatements] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BankStatements] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BankStatements] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BankStatements] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BankStatements] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BankStatements', N'ON'
GO
USE [BankStatements]
GO
/****** Object:  Table [dbo].[AuditStatement]    Script Date: 8/20/2017 11:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditStatement](
	[AuditId] [bigint] IDENTITY(1,1) NOT NULL,
	[StatementId] [bigint] NULL,
	[FileName] [xml] NULL,
	[AuditDate] [datetime] NULL,
 CONSTRAINT [PK_AuditStatement] PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Statement]    Script Date: 8/20/2017 11:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Statement](
	[StatementId] [bigint] IDENTITY(1,1) NOT NULL,
	[BankName] [nvarchar](50) NULL,
	[AccountNumber] [nvarchar](50) NULL,
	[FileName] [xml] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[Status] [varchar](30) NULL,
 CONSTRAINT [PK_Statement] PRIMARY KEY CLUSTERED 
(
	[StatementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[AuditStatement]  WITH CHECK ADD  CONSTRAINT [FK_Statement_Audit] FOREIGN KEY([StatementId])
REFERENCES [dbo].[Statement] ([StatementId])
GO
ALTER TABLE [dbo].[AuditStatement] CHECK CONSTRAINT [FK_Statement_Audit]
GO
ALTER TABLE [dbo].[Statement]  WITH CHECK ADD  CONSTRAINT [FK_Statement_Statement] FOREIGN KEY([StatementId])
REFERENCES [dbo].[Statement] ([StatementId])
GO
ALTER TABLE [dbo].[Statement] CHECK CONSTRAINT [FK_Statement_Statement]
GO
/****** Object:  StoredProcedure [dbo].[proc_DeleteStatment]    Script Date: 8/20/2017 11:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_DeleteStatment]
	-- Add the parameters for the stored procedure here
	 @Id Bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
    -- Delete statement for procedure here
	DELETE FROM [dbo].[Statement] WHERE [StatementId] = @Id
	SELECT 1
END
 

GO
/****** Object:  StoredProcedure [dbo].[proc_GetAllStatment]    Script Date: 8/20/2017 11:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_GetAllStatment] 
@Count BIGINT
AS
BEGIN

	SELECT top(@Count)* FROM [dbo].[Statement]
END

GO
/****** Object:  StoredProcedure [dbo].[proc_GetStatementbyID]    Script Date: 8/20/2017 11:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dipendra
-- Create date: 20 August 2017
-- Description:	GetStatmentId
-- =============================================
CREATE PROCEDURE [dbo].[proc_GetStatementbyID] 
	-- Add the parameters for the stored procedure here
	@Id BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
    -- Insert statements for procedure here
	SELECT * FROM [dbo].[Statement]
	WHERE  StatementId = @Id
END
 

GO
/****** Object:  StoredProcedure [dbo].[proc_InsertStatement]    Script Date: 8/20/2017 11:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dipendra
-- Create date: 20 August 2017
-- Description:	GetStatmentId
-- =============================================

CREATE PROCEDURE [dbo].[proc_InsertStatement]
	-- Add the parameters for the stored procedure here
	 @BankName Nvarchar(50),
	 @AccountNumber Nvarchar(50),
	 @FileName xml,
	 @CreatedDate datetime,
	 @ModifiedDate datetime,
	 @Status varchar(30)
AS
BEGIN
 
    -- Insert statements for procedure here
	INSERT INTO [dbo].[Statement] ([BankName],[AccountNumber],[FileName],[CreatedDate],[ModifiedDate],[Status])
	VALUES(@BankName,@AccountNumber,@FileName,GETDATE(),GETDATE(),@Status)
	SELECT 1
END
 

GO
/****** Object:  StoredProcedure [dbo].[proc_UpdateStatement]    Script Date: 8/20/2017 11:25:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dipendra
-- Create date: 20 August 2017
-- Description:	GetStatmentId
-- =============================================

CREATE PROCEDURE [dbo].[proc_UpdateStatement]
	-- Add the parameters for the stored procedure here
	 @StatementId bigint,
	 @BankName Nvarchar(50),
	 @AccountNumber Nvarchar(50),
	 @FileName xml,
	 @CreatedDate datetime,
	 @ModifiedDate datetime,
	 @Status varchar(30)
AS
BEGIN
 
    -- UPDATE statements for procedure here
	UPDATE [dbo].[Statement] 
	       set [BankName] = @BankName,
		       [AccountNumber] = @AccountNumber,
			   [FileName] = @FileName ,
			   [ModifiedDate] = getdate(),
			   [Status] =@Status
	WHERE [StatementId] = @StatementId
	SELECT 1
	
END
 

GO
USE [master]
GO
ALTER DATABASE [BankStatements] SET  READ_WRITE 
GO
