USE [master]
GO
/****** Object:  Database [ReviewIT]    Script Date: 05-07-2016 16:57:11 ******/
CREATE DATABASE [ReviewIT]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ReviewIT', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\ReviewIT.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ReviewIT_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\ReviewIT_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ReviewIT] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ReviewIT].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ReviewIT] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ReviewIT] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ReviewIT] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ReviewIT] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ReviewIT] SET ARITHABORT OFF 
GO
ALTER DATABASE [ReviewIT] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ReviewIT] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ReviewIT] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ReviewIT] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ReviewIT] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ReviewIT] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ReviewIT] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ReviewIT] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ReviewIT] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ReviewIT] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ReviewIT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ReviewIT] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ReviewIT] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ReviewIT] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ReviewIT] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ReviewIT] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ReviewIT] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ReviewIT] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ReviewIT] SET  MULTI_USER 
GO
ALTER DATABASE [ReviewIT] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ReviewIT] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ReviewIT] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ReviewIT] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ReviewIT] SET DELAYED_DURABILITY = DISABLED 
GO
USE [ReviewIT]
GO
/****** Object:  Table [dbo].[Article]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article](
	[Id] [int] NOT NULL,
	[Study_Id] [int] NULL,
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Criteria]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Criteria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Study_Id] [int] NOT NULL,
	[Field_Id] [int] NOT NULL,
	[Value] [text] NOT NULL,
 CONSTRAINT [PK_Criteria] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Data]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Data](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [text] NULL,
	[Task_Id] [int] NOT NULL,
	[Field_Id] [int] NOT NULL,
	[Article_Id] [int] NOT NULL,
 CONSTRAINT [PK_Data] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DataType]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DataType](
	[Id] [int] NOT NULL,
	[Value] [varchar](256) NOT NULL,
 CONSTRAINT [PK_DataType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Field]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Field](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](256) NULL,
	[Description] [text] NULL,
	[DataType_Id] [int] NOT NULL,
 CONSTRAINT [PK_Field] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FieldDescription]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FieldDescription](
	[Stage_Id] [int] IDENTITY(1,1) NOT NULL,
	[Field_Id] [int] NOT NULL,
 CONSTRAINT [PK_Strategy_Field_Relation] PRIMARY KEY CLUSTERED 
(
	[Stage_Id] ASC,
	[Field_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FieldType]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FieldType](
	[Id] [int] NOT NULL,
	[Value] [varchar](256) NULL,
 CONSTRAINT [PK_FieldType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Stage]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Stage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](256) NULL,
	[Description] [text] NULL,
	[Study_Id] [int] NULL,
 CONSTRAINT [PK_Stage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StageDescription]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StageDescription](
	[Stage_Id] [int] NOT NULL,
	[Field_Id] [int] NOT NULL,
	[FieldType_Id] [int] NOT NULL,
 CONSTRAINT [PK_StageDescription] PRIMARY KEY CLUSTERED 
(
	[Stage_Id] ASC,
	[Field_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StageRole]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StageRole](
	[Id] [int] NOT NULL,
	[Value] [varchar](256) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Strategy]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Strategy](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Stage_Id] [int] NOT NULL,
	[StrategyType_Id] [int] NOT NULL,
	[Value] [text] NULL,
 CONSTRAINT [PK_Strategy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StrategyType]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StrategyType](
	[Id] [int] NOT NULL,
	[Value] [varchar](80) NOT NULL,
 CONSTRAINT [PK_StrategyType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Study]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Study](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](256) NULL,
	[Description] [text] NULL,
 CONSTRAINT [PK_Study] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Task]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Stage_Id] [int] NULL,
	[Article_Id] [int] NOT NULL,
	[User_Id] [int] NULL,
	[TaskType_Id] [int] NOT NULL,
	[Parent_Id] [int] NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaskType]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaskType](
	[Id] [int] NOT NULL,
	[Value] [varchar](80) NULL,
 CONSTRAINT [PK_TaskType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](80) NOT NULL,
	[Password_Salt] [varchar](50) NOT NULL,
	[First_Name] [varchar](50) NULL,
	[Last_Name] [nchar](10) NULL,
	[eMail] [varchar](80) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User_Stage_Relation]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Stage_Relation](
	[User_Id] [int] NOT NULL,
	[Stage_Id] [int] NOT NULL,
	[StageRole_Id] [int] NOT NULL,
 CONSTRAINT [PK_User_Stage_Relation] PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC,
	[Stage_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User_Study_Relation]    Script Date: 05-07-2016 16:57:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Study_Relation](
	[User_Id] [int] NOT NULL,
	[Study_Id] [int] NOT NULL,
	[isAdmin] [bit] NULL,
 CONSTRAINT [PK_User_Study_Relation] PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC,
	[Study_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK_Article_Study] FOREIGN KEY([Study_Id])
REFERENCES [dbo].[Study] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK_Article_Study]
GO
ALTER TABLE [dbo].[Criteria]  WITH CHECK ADD  CONSTRAINT [FK_Criteria_Field] FOREIGN KEY([Field_Id])
REFERENCES [dbo].[Field] ([Id])
GO
ALTER TABLE [dbo].[Criteria] CHECK CONSTRAINT [FK_Criteria_Field]
GO
ALTER TABLE [dbo].[Criteria]  WITH CHECK ADD  CONSTRAINT [FK_Criteria_Study] FOREIGN KEY([Study_Id])
REFERENCES [dbo].[Study] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Criteria] CHECK CONSTRAINT [FK_Criteria_Study]
GO
ALTER TABLE [dbo].[Data]  WITH CHECK ADD  CONSTRAINT [FK_Data_Article] FOREIGN KEY([Article_Id])
REFERENCES [dbo].[Article] ([Id])
GO
ALTER TABLE [dbo].[Data] CHECK CONSTRAINT [FK_Data_Article]
GO
ALTER TABLE [dbo].[Data]  WITH CHECK ADD  CONSTRAINT [FK_Data_Field] FOREIGN KEY([Field_Id])
REFERENCES [dbo].[Field] ([Id])
GO
ALTER TABLE [dbo].[Data] CHECK CONSTRAINT [FK_Data_Field]
GO
ALTER TABLE [dbo].[Data]  WITH CHECK ADD  CONSTRAINT [FK_Data_Task] FOREIGN KEY([Task_Id])
REFERENCES [dbo].[Task] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Data] CHECK CONSTRAINT [FK_Data_Task]
GO
ALTER TABLE [dbo].[Field]  WITH CHECK ADD  CONSTRAINT [FK_Field_DataType] FOREIGN KEY([DataType_Id])
REFERENCES [dbo].[DataType] ([Id])
GO
ALTER TABLE [dbo].[Field] CHECK CONSTRAINT [FK_Field_DataType]
GO
ALTER TABLE [dbo].[Stage]  WITH CHECK ADD  CONSTRAINT [FK_Stage_Study] FOREIGN KEY([Study_Id])
REFERENCES [dbo].[Study] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Stage] CHECK CONSTRAINT [FK_Stage_Study]
GO
ALTER TABLE [dbo].[StageDescription]  WITH CHECK ADD  CONSTRAINT [FK_StageDescription_Field] FOREIGN KEY([Field_Id])
REFERENCES [dbo].[Field] ([Id])
GO
ALTER TABLE [dbo].[StageDescription] CHECK CONSTRAINT [FK_StageDescription_Field]
GO
ALTER TABLE [dbo].[StageDescription]  WITH CHECK ADD  CONSTRAINT [FK_StageDescription_FieldType] FOREIGN KEY([FieldType_Id])
REFERENCES [dbo].[FieldType] ([Id])
GO
ALTER TABLE [dbo].[StageDescription] CHECK CONSTRAINT [FK_StageDescription_FieldType]
GO
ALTER TABLE [dbo].[StageDescription]  WITH CHECK ADD  CONSTRAINT [FK_StageDescription_Stage] FOREIGN KEY([Stage_Id])
REFERENCES [dbo].[Stage] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StageDescription] CHECK CONSTRAINT [FK_StageDescription_Stage]
GO
ALTER TABLE [dbo].[Strategy]  WITH CHECK ADD  CONSTRAINT [FK_Strategy_Stage] FOREIGN KEY([Stage_Id])
REFERENCES [dbo].[Stage] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Strategy] CHECK CONSTRAINT [FK_Strategy_Stage]
GO
ALTER TABLE [dbo].[Strategy]  WITH CHECK ADD  CONSTRAINT [FK_Strategy_StrategyType] FOREIGN KEY([StrategyType_Id])
REFERENCES [dbo].[StrategyType] ([Id])
GO
ALTER TABLE [dbo].[Strategy] CHECK CONSTRAINT [FK_Strategy_StrategyType]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Article] FOREIGN KEY([Article_Id])
REFERENCES [dbo].[Article] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Article]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Stage] FOREIGN KEY([Stage_Id])
REFERENCES [dbo].[Stage] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Stage]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Task] FOREIGN KEY([Parent_Id])
REFERENCES [dbo].[Task] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Task]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_TaskType] FOREIGN KEY([TaskType_Id])
REFERENCES [dbo].[TaskType] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_TaskType]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_User] FOREIGN KEY([User_Id])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_User]
GO
ALTER TABLE [dbo].[User_Stage_Relation]  WITH CHECK ADD  CONSTRAINT [FK_User_Stage_Relation_Role] FOREIGN KEY([StageRole_Id])
REFERENCES [dbo].[StageRole] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[User_Stage_Relation] CHECK CONSTRAINT [FK_User_Stage_Relation_Role]
GO
ALTER TABLE [dbo].[User_Stage_Relation]  WITH CHECK ADD  CONSTRAINT [FK_User_Stage_Relation_Stage] FOREIGN KEY([Stage_Id])
REFERENCES [dbo].[Stage] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[User_Stage_Relation] CHECK CONSTRAINT [FK_User_Stage_Relation_Stage]
GO
ALTER TABLE [dbo].[User_Stage_Relation]  WITH CHECK ADD  CONSTRAINT [FK_User_Stage_Relation_User] FOREIGN KEY([User_Id])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[User_Stage_Relation] CHECK CONSTRAINT [FK_User_Stage_Relation_User]
GO
ALTER TABLE [dbo].[User_Study_Relation]  WITH CHECK ADD  CONSTRAINT [FK_User_Study_Relation_Study] FOREIGN KEY([Study_Id])
REFERENCES [dbo].[Study] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[User_Study_Relation] CHECK CONSTRAINT [FK_User_Study_Relation_Study]
GO
ALTER TABLE [dbo].[User_Study_Relation]  WITH CHECK ADD  CONSTRAINT [FK_User_Study_Relation_User] FOREIGN KEY([User_Id])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[User_Study_Relation] CHECK CONSTRAINT [FK_User_Study_Relation_User]
GO
USE [master]
GO
ALTER DATABASE [ReviewIT] SET  READ_WRITE 
GO
/** fill types and roles  */
USE [ReviewIT]
GO
INSERT INTO [dbo].[StageRole]
           ([Id],[Value])
     VALUES
           (1,'reviewer'),(2,'validator')
GO
INSERT INTO [dbo].[TaskType]
           ([Id],[Value])
     VALUES
           (1,'review'),(2,'validation')
GO
INSERT INTO [dbo].[DataType]
           ([Id],[Value])
     VALUES
           (1,'string'),(2,'boolean'),(3,'enumeration'),(4,'flags'),(5,'resource')
GO
INSERT INTO [dbo].[StrategyType]
			([Id],[Value])
		VALUES
			(1,'reviewStrategy'),(2,'validationStrategy')
GO