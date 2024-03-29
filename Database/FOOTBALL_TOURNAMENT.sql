USE [master]
GO
/****** Object:  Database [FOOTBALL_TOURNAMENT]    Script Date: 7.01.2021 20:28:48 ******/
CREATE DATABASE [FOOTBALL_TOURNAMENT]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FOOTBALL_TOURNAMENT', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\FOOTBALL_TOURNAMENT.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FOOTBALL_TOURNAMENT_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\FOOTBALL_TOURNAMENT_0.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FOOTBALL_TOURNAMENT].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET ARITHABORT OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET RECOVERY FULL 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET  MULTI_USER 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FOOTBALL_TOURNAMENT', N'ON'
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET QUERY_STORE = OFF
GO
USE [FOOTBALL_TOURNAMENT]
GO
/****** Object:  User [admina]    Script Date: 7.01.2021 20:28:48 ******/
CREATE USER [admina] FOR LOGIN [admina] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Admin1]    Script Date: 7.01.2021 20:28:48 ******/
CREATE USER [Admin1] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [admina]
GO
ALTER ROLE [db_datareader] ADD MEMBER [admina]
GO
ALTER ROLE [db_owner] ADD MEMBER [Admin1]
GO
/****** Object:  Table [dbo].[PLAYER]    Script Date: 7.01.2021 20:28:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLAYER](
	[PlayerID] [tinyint] NOT NULL,
	[FirstName] [nvarchar](20) NULL,
	[LastName] [nvarchar](20) NULL,
	[TeamID] [tinyint] NOT NULL,
	[Nationality] [varchar](25) NULL,
	[Birthdate] [date] NULL,
	[Age]  AS (datediff(year,[Birthdate],getdate())),
	[NumberOfGoals] [tinyint] NULL,
 CONSTRAINT [PK_PLAYER] PRIMARY KEY CLUSTERED 
(
	[PlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Foreign_Players]    Script Date: 7.01.2021 20:28:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Foreign_Players]
AS
SELECT COUNT(*) as ForeignPlyrCount,p.Nationality
FROM PLAYER p 
WHERE p.Nationality not like 'Turkish'
GROUP BY p.Nationality
GO
/****** Object:  Table [dbo].[GOAL]    Script Date: 7.01.2021 20:28:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GOAL](
	[HomeTeamID] [tinyint] NOT NULL,
	[AwayTeamID] [tinyint] NOT NULL,
	[PlayerID] [tinyint] NOT NULL,
	[Minute] [tinyint] NOT NULL,
	[Week] [char](2) NOT NULL,
 CONSTRAINT [PK_GOAL] PRIMARY KEY CLUSTERED 
(
	[HomeTeamID] ASC,
	[AwayTeamID] ASC,
	[PlayerID] ASC,
	[Minute] ASC,
	[Week] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SecondHalf_TopScorers]    Script Date: 7.01.2021 20:28:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SecondHalf_TopScorers]
AS
SELECT TOP 5 COUNT(*) LateGoal,p.FirstName + ' ' + p.LastName as FullName
FROM GOAL g inner join PLAYER p on g.PlayerID=p.PlayerID
Where g.Minute between 30 and 60
GROUP BY p.FirstName + ' ' + p.LastName 
ORDER BY LateGoal DESC
GO
/****** Object:  Table [dbo].[REFEREE]    Script Date: 7.01.2021 20:28:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REFEREE](
	[RefereeID] [tinyint] NOT NULL,
	[FirstName] [nvarchar](20) NULL,
	[LastName] [nvarchar](20) NULL,
	[YearsOfExperience] [tinyint] NULL,
 CONSTRAINT [PK_REFEREE] PRIMARY KEY CLUSTERED 
(
	[RefereeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MATCH]    Script Date: 7.01.2021 20:28:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MATCH](
	[HomeTeamID] [tinyint] NOT NULL,
	[AwayTeamID] [tinyint] NOT NULL,
	[Week] [char](2) NOT NULL,
	[RefereeID] [tinyint] NOT NULL,
	[Date] [date] NULL,
	[FinalResult] [varchar](5) NULL,
	[MatchStage] [varchar](15) NULL,
 CONSTRAINT [PK_MATCH_1] PRIMARY KEY CLUSTERED 
(
	[HomeTeamID] ASC,
	[AwayTeamID] ASC,
	[Week] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Referee_Matches]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Referee_Matches]
AS
SELECT TOP 14 COUNT(*) NmbrOfMatch,r.FirstName + ' ' + r.LastName as FullName
FROM MATCH m inner join REFEREE r on m.RefereeID=r.RefereeID
GROUP BY r.FirstName + ' ' + r.LastName
ORDER BY NmbrOfMatch DESC
GO
/****** Object:  Table [dbo].[TEAM]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TEAM](
	[TeamID] [tinyint] NOT NULL,
	[Name] [nvarchar](20) NULL,
	[Location] [nvarchar](20) NULL,
	[ManagerID] [tinyint] NOT NULL,
 CONSTRAINT [PK_TEAM] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[YoungPlayer_PerTeam]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[YoungPlayer_PerTeam]
AS
SELECT TOP 13 COUNT(*)YoungPlayers,t.Name as TeamName
FROM TEAM t inner join PLAYER p on t.TeamID=p.TeamID
WHERE p.Age<(SELECT AVG(Age)
			FROM PLAYER)
GROUP BY t.Name
ORDER BY YoungPlayers DESC
GO
/****** Object:  Table [dbo].[MANAGER]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MANAGER](
	[ManagerID] [tinyint] NOT NULL,
	[FirstName] [nvarchar](20) NULL,
	[LastName] [nvarchar](20) NULL,
	[Nationality] [char](7) NULL,
	[Birthdate] [date] NULL,
	[Age]  AS (datediff(year,[Birthdate],getdate())),
	[YearsOfExperience] [tinyint] NULL,
 CONSTRAINT [PK_MANAGER] PRIMARY KEY CLUSTERED 
(
	[ManagerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Young_Managers]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Young_Managers]
AS
SELECT  m.FirstName + ' ' + m.LastName as FullName
FROM MANAGER m
WHERE m.Age<(SELECT AVG(AGE)
			 FROM MANAGER)
GO
/****** Object:  Table [dbo].[AWARDS]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AWARDS](
	[SeasonAwardsID] [tinyint] NOT NULL,
	[ChampionTeamID] [tinyint] NOT NULL,
	[MostValuablePlayerID] [tinyint] NOT NULL,
	[MostValuableCoachID] [tinyint] NOT NULL,
	[TournamentID] [tinyint] NOT NULL,
 CONSTRAINT [PK_AWARDS] PRIMARY KEY CLUSTERED 
(
	[SeasonAwardsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PITCH]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PITCH](
	[PitchID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Location] [nvarchar](20) NULL,
	[OwnerName] [nvarchar](25) NULL,
	[BusinessNumber] [char](10) NOT NULL,
 CONSTRAINT [PK_PITCH] PRIMARY KEY CLUSTERED 
(
	[PitchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PLAYER_POSITION]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLAYER_POSITION](
	[PlayerID] [tinyint] NOT NULL,
	[Position] [varchar](15) NOT NULL,
 CONSTRAINT [PK_PLAYER_POSITION] PRIMARY KEY CLUSTERED 
(
	[PlayerID] ASC,
	[Position] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TOURNAMENT]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TOURNAMENT](
	[TournametID] [tinyint] NOT NULL,
	[TournamentName] [nvarchar](75) NULL,
	[PitchID] [tinyint] NOT NULL,
 CONSTRAINT [PK_TOURNAMENT] PRIMARY KEY CLUSTERED 
(
	[TournametID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TOURNAMENT_TEAM]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TOURNAMENT_TEAM](
	[TournamentID] [tinyint] NOT NULL,
	[TeamID] [tinyint] NOT NULL,
	[GroupName] [char](1) NULL,
	[NumberOfMatchPlayed] [tinyint] NULL,
	[Won] [tinyint] NULL,
	[Draw] [tinyint] NULL,
	[Loss] [tinyint] NULL,
	[GroupPoint]  AS ([Won]*(3)+[Draw]*(1)),
	[GoalScored] [smallint] NULL,
	[GoalConceded] [smallint] NULL,
	[Average]  AS ([GoalScored]-[GoalConceded]),
	[GroupPosition] [char](1) NULL,
	[Stage] [varchar](15) NULL,
 CONSTRAINT [PK_TOURNAMENT_TEAM] PRIMARY KEY CLUSTERED 
(
	[TournamentID] ASC,
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[AWARDS] ([SeasonAwardsID], [ChampionTeamID], [MostValuablePlayerID], [MostValuableCoachID], [TournamentID]) VALUES (1, 10, 55, 3, 1)
GO
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 2, 1, 52, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 2, 1, 54, N'5 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 2, 2, 10, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 2, 2, 15, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 2, 2, 25, N'5 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 2, 10, 28, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 2, 10, 35, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 2, 10, 44, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 2, 10, 48, N'5 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 3, 1, 14, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 3, 1, 24, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 3, 1, 38, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 3, 14, 8, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 4, 1, 4, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 4, 1, 48, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 4, 2, 14, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 4, 6, 28, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 4, 21, 41, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 4, 21, 53, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 5, 1, 37, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 5, 2, 32, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 5, 2, 52, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 5, 26, 23, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 5, 30, 11, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 6, 1, 24, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 10, 2, 26, N'6 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 10, 55, 16, N'6 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 10, 55, 43, N'6 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (1, 10, 58, 38, N'6 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (2, 3, 10, 36, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (2, 3, 10, 58, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (2, 3, 14, 15, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (2, 3, 14, 45, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (2, 3, 17, 27, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (2, 4, 10, 21, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (2, 4, 10, 28, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (2, 4, 21, 39, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (2, 7, 10, 25, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (2, 7, 10, 36, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (2, 7, 10, 58, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (2, 7, 42, 45, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (3, 4, 14, 31, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (3, 4, 17, 16, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (3, 4, 19, 42, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (3, 4, 21, 35, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (3, 4, 21, 40, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 6, 28, 19, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 6, 29, 31, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 6, 32, 37, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 6, 32, 48, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 7, 30, 35, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 7, 30, 54, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 7, 41, 42, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 7, 42, 3, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 7, 42, 18, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 7, 42, 29, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 8, 28, 45, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 8, 29, 19, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 8, 30, 5, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 8, 30, 11, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 8, 30, 28, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 8, 30, 52, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 8, 47, 35, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (5, 8, 47, 41, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (6, 7, 32, 9, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (6, 7, 32, 41, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (6, 7, 32, 48, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (6, 7, 33, 55, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (6, 7, 41, 44, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (6, 7, 42, 11, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (6, 7, 42, 27, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (6, 7, 42, 35, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (6, 8, 32, 27, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (6, 8, 45, 39, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (6, 8, 45, 52, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (6, 8, 47, 35, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (7, 8, 40, 39, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (7, 8, 41, 25, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (7, 8, 45, 9, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (7, 8, 45, 34, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (9, 10, 53, 55, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (9, 10, 55, 37, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (9, 10, 58, 17, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (9, 11, 52, 38, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (9, 11, 62, 7, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (9, 11, 62, 18, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (9, 11, 62, 29, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (9, 12, 53, 3, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (9, 12, 67, 55, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (9, 12, 68, 41, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (9, 12, 72, 48, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 11, 55, 29, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 11, 55, 32, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 11, 55, 40, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 11, 55, 44, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 11, 62, 25, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 12, 55, 34, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 12, 58, 44, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 12, 60, 21, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 14, 55, 20, N'5 ')
GO
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 14, 55, 35, N'5 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 14, 55, 46, N'5 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 14, 79, 51, N'5 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 16, 55, 19, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 16, 55, 25, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 16, 55, 34, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 16, 59, 56, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 16, 60, 48, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (10, 16, 95, 4, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (11, 12, 61, 28, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (11, 12, 61, 49, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (11, 12, 68, 55, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (11, 12, 72, 59, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (11, 14, 62, 50, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (11, 14, 80, 59, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (11, 14, 84, 18, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (11, 14, 84, 24, N'4 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 14, 73, 11, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 14, 84, 32, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 14, 84, 38, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 15, 74, 18, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 15, 74, 52, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 15, 76, 13, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 15, 85, 28, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 15, 85, 35, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 15, 85, 41, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 16, 76, 23, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 16, 93, 41, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 16, 96, 14, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 16, 96, 18, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (13, 16, 96, 49, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (14, 15, 79, 25, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (14, 15, 79, 32, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (14, 15, 79, 49, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (14, 15, 86, 56, N'1 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (14, 16, 79, 26, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (14, 16, 79, 37, N'3 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (15, 16, 86, 35, N'2 ')
INSERT [dbo].[GOAL] ([HomeTeamID], [AwayTeamID], [PlayerID], [Minute], [Week]) VALUES (15, 16, 93, 28, N'2 ')
GO
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (1, N'Adem', N'Tepe', N'Turkish', CAST(N'1991-09-22' AS Date), 2)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (2, N'Yusuf', N'Hacıoğlu', N'Turkish', CAST(N'1986-02-05' AS Date), 6)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (3, N'Celalettin', N'Doğruyol', N'Turkish', CAST(N'1988-10-21' AS Date), 2)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (4, N'Oktay', N'Camcı', N'Turkish', CAST(N'1987-06-11' AS Date), 5)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (5, N'Hamit', N'Akarsu', N'Turkish', CAST(N'1989-03-26' AS Date), 5)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (6, N'Ekrem', N'Yerebakan', N'Turkish', CAST(N'1982-05-29' AS Date), 10)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (7, N'Mustafa ', N'Sevimli', N'Turkish', CAST(N'1991-11-13' AS Date), 1)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (8, N'Mehmet', N'Aydın', N'Turkish', CAST(N'1989-07-19' AS Date), 2)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (9, N'Mehmet', N'Beşiroğlu', N'Turkish', CAST(N'1986-10-24' AS Date), 2)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (10, N'Yasin', N'Topçu', N'Turkish', CAST(N'1988-05-03' AS Date), 4)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (11, N'Serdar', N'Demirel', N'Turkish', CAST(N'1989-08-17' AS Date), 3)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (12, N'Ali', N'Yıldırım', N'Turkish', CAST(N'1981-12-06' AS Date), 8)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (13, N'Barış', N'Haskaya', N'Turkish', CAST(N'1985-07-12' AS Date), 6)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (14, N'Muhammed Ali', N'Kaldırım', N'Turkish', CAST(N'1986-11-19' AS Date), 2)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (15, N'Habil', N'Sucuoğlu', N'Turkish', CAST(N'1988-10-09' AS Date), 1)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (16, N'Fatih', N'Ay', N'Turkish', CAST(N'1982-06-16' AS Date), 6)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (17, N'Murat', N'Ok', N'Turkish', CAST(N'1978-03-27' AS Date), 10)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (18, N'Kamil', N'Sönmez', N'Turkish', CAST(N'1990-07-18' AS Date), 2)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (19, N'Mustafa', N'Karagöz', N'Turkish', CAST(N'1989-11-16' AS Date), 1)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (20, N'Attila', N'Ünlü', N'Turkish', CAST(N'1990-03-14' AS Date), 2)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (21, N'Kazım', N'Karabasan', N'Turkish', CAST(N'1992-05-15' AS Date), 4)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (22, N'Berk', N'Sevdalı', N'Turkish', CAST(N'1991-06-16' AS Date), 4)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (23, N'Ahmet', N'Gül', N'Turkish', CAST(N'1988-09-09' AS Date), 6)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (24, N'Kadir', N'Uhut', N'Turkish', CAST(N'1985-08-11' AS Date), 8)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (25, N'Hüseyin', N'Nohutçu', N'Turkish', CAST(N'1988-10-11' AS Date), 6)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (26, N'Mustafa', N'Bahçebaşı', N'Turkish', CAST(N'1978-05-06' AS Date), 15)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (27, N'Burak', N'Yurtsever', N'Turkish', CAST(N'1980-12-11' AS Date), 14)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (28, N'Mehmet', N'Soyaslan', N'Turkish', CAST(N'1993-08-17' AS Date), 3)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (29, N'Mevlüt', N'Mendeş', N'Turkish', CAST(N'1992-11-25' AS Date), 2)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (30, N'Muhsin', N'Görek', N'Turkish', CAST(N'1987-01-30' AS Date), 7)
INSERT [dbo].[MANAGER] ([ManagerID], [FirstName], [LastName], [Nationality], [Birthdate], [YearsOfExperience]) VALUES (31, N'Mehmet', N'Kelek', N'Fransa ', CAST(N'1980-10-10' AS Date), 15)
GO
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (1, 2, N'2 ', 9, CAST(N'2020-12-05' AS Date), N'3-3', N'GROUP A')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (1, 2, N'5 ', 5, CAST(N'2020-12-15' AS Date), N'2-1', N'SEMI FINALS')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (1, 3, N'3 ', 2, CAST(N'2020-12-09' AS Date), N'3-1', N'GROUP A')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (1, 4, N'1 ', 10, CAST(N'2020-12-01' AS Date), N'4-2', N'GROUP A')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (1, 5, N'4 ', 14, CAST(N'2020-12-13' AS Date), N'3-2', N'QUARTER FINALS')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (1, 10, N'6 ', 9, CAST(N'2020-12-16' AS Date), N'1-3', N'FINALS')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (2, 3, N'1 ', 9, CAST(N'2020-12-01' AS Date), N'2-3', N'GROUP A')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (2, 4, N'3 ', 6, CAST(N'2020-12-09' AS Date), N'2-1', N'GROUP A')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (2, 7, N'4 ', 3, CAST(N'2020-12-13' AS Date), N'3-1', N'QUARTER FINALS')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (3, 4, N'2 ', 10, CAST(N'2020-12-05' AS Date), N'2-3', N'GROUP A')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (5, 6, N'2 ', 14, CAST(N'2020-12-06' AS Date), N'2-2', N'GROUP B')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (5, 7, N'3 ', 7, CAST(N'2020-12-10' AS Date), N'2-4', N'GROUP B')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (5, 8, N'1 ', 5, CAST(N'2020-12-02' AS Date), N'6-2', N'GROUP B')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (6, 7, N'1 ', 14, CAST(N'2020-12-02' AS Date), N'4-4', N'GROUP B')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (6, 8, N'3 ', 8, CAST(N'2020-12-10' AS Date), N'1-3', N'GROUP B')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (7, 8, N'2 ', 5, CAST(N'2020-12-06' AS Date), N'2-2', N'GROUP B')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (9, 10, N'2 ', 1, CAST(N'2020-12-07' AS Date), N'1-2', N'GROUP C')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (9, 11, N'3 ', 11, CAST(N'2020-12-11' AS Date), N'1-3', N'GROUP C')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (9, 12, N'1 ', 13, CAST(N'2020-12-03' AS Date), N'1-3', N'GROUP C')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (10, 11, N'1 ', 1, CAST(N'2020-12-03' AS Date), N'4-1', N'GROUP C')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (10, 12, N'3 ', 12, CAST(N'2020-12-11' AS Date), N'3-0', N'GROUP C')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (10, 14, N'5 ', 10, CAST(N'2020-12-15' AS Date), N'3-1', N'SEMI FINALS')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (10, 16, N'4 ', 4, CAST(N'2020-12-14' AS Date), N'5-1', N'QUARTER FINALS')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (11, 12, N'2 ', 13, CAST(N'2020-12-07' AS Date), N'2-2', N'GROUP C')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (11, 14, N'4 ', 1, CAST(N'2020-12-14' AS Date), N'1-3', N'QUARTER FINALS')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (13, 14, N'2 ', 4, CAST(N'2020-12-08' AS Date), N'1-2', N'GROUP D')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (13, 15, N'3 ', 2, CAST(N'2020-12-12' AS Date), N'3-3', N'GROUP D')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (13, 16, N'1 ', 3, CAST(N'2020-12-04' AS Date), N'1-4', N'GROUP D')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (14, 15, N'1 ', 4, CAST(N'2020-12-04' AS Date), N'3-1', N'GROUP D')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (14, 16, N'3 ', 2, CAST(N'2020-12-12' AS Date), N'2-0', N'GROUP D')
INSERT [dbo].[MATCH] ([HomeTeamID], [AwayTeamID], [Week], [RefereeID], [Date], [FinalResult], [MatchStage]) VALUES (15, 16, N'2 ', 3, CAST(N'2020-12-08' AS Date), N'1-1', N'GROUP D')
GO
SET IDENTITY_INSERT [dbo].[PITCH] ON 

INSERT [dbo].[PITCH] ([PitchID], [Name], [Location], [OwnerName], [BusinessNumber]) VALUES (1, N'AYDINOĞLU', N'MALTEPE', N'ÖZGÜR', N'5531981741')
SET IDENTITY_INSERT [dbo].[PITCH] OFF
GO
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (1, N'Faruk', N'Çakır', 1, N'Ugandan', CAST(N'1997-07-20' AS Date), 10)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (2, N'Ömer', N'Kaçmaz', 1, N'Turkish', CAST(N'1996-09-11' AS Date), 7)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (3, N'Kerem', N'Saçaklı', 1, N'Turkish', CAST(N'1998-02-26' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (4, N'Metin', N'Emin', 1, N'Turkish', CAST(N'1995-12-25' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (5, N'Kerem', N'Sakın', 1, N'Turkish', CAST(N'1998-07-08' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (6, N'Şah ', N'Muradov', 1, N'Azerbaijani', CAST(N'1994-10-29' AS Date), 1)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (7, N'Zihni', N'Elagöz', 2, N'Turkish', CAST(N'1995-03-12' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (8, N'Ali', N'Yıldırım', 2, N'Turkish', CAST(N'1997-05-03' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (9, N'Vedat', N'Artış', 2, N'Turkish', CAST(N'1998-08-20' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (10, N'Burak', N'Kurt', 2, N'Turkish', CAST(N'1996-11-16' AS Date), 11)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (11, N'Osman', N'Kalafat', 2, N'Turkish', CAST(N'1997-06-09' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (12, N'Süleyman', N'Bulut', 2, N'Turkish', CAST(N'1997-07-28' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (13, N'Ömer', N'Paftalı', 3, N'Turkish', CAST(N'1998-04-25' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (14, N'Erdem', N'Şen', 3, N'Turkish', CAST(N'1997-02-15' AS Date), 4)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (15, N'Yunus', N'Turhan', 3, N'Turkish', CAST(N'1998-02-19' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (16, N'Esad', N'Büyük', 3, N'Turkish', CAST(N'1995-03-08' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (17, N'Hüseyin', N'Durmuş', 3, N'Caucasian', CAST(N'1996-08-17' AS Date), 2)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (18, N'Hamit', N'Şimşek', 3, N'Turkish', CAST(N'1998-07-29' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (19, N'Semih', N'Doğuş', 4, N'Turkish', CAST(N'1999-02-14' AS Date), 1)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (20, N'Hasan', N'Şahinkoç', 4, N'Turkish', CAST(N'1998-12-25' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (21, N'Hong', N'Lee', 4, N'Chinesee', CAST(N'1998-07-06' AS Date), 5)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (22, N'Yusuf', N'Polatlı', 4, N'Turkish', CAST(N'1998-04-13' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (23, N'Şinasi', N'Öztürk', 4, N'Turkish', CAST(N'1998-11-09' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (24, N'Kerem', N'Sarı', 4, N'Turkish', CAST(N'1998-02-01' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (25, N'Veysel', N'Karagöz', 5, N'Turkish', CAST(N'1998-09-21' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (26, N'Kemal', N'Perdeci', 5, N'Turkish', CAST(N'1998-05-26' AS Date), 1)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (27, N'Alperen', N'Kapı', 5, N'Turkish', CAST(N'1998-10-15' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (28, N'Can', N'Başgan', 5, N'Turkish', CAST(N'1998-10-21' AS Date), 2)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (29, N'Mustafa', N'Güzel', 5, N'Turkish', CAST(N'1998-08-14' AS Date), 2)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (30, N'Bilal', N'Beşikçi', 5, N'Turkish', CAST(N'1999-11-07' AS Date), 7)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (31, N'Selim', N'Demirci', 6, N'Turkish', CAST(N'1998-04-19' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (32, N'Muhammed', N'Yılmaz', 6, N'Turkish', CAST(N'1997-12-08' AS Date), 6)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (33, N'Oğuz', N'Sarıoğlu', 6, N'Turkish', CAST(N'1998-06-29' AS Date), 1)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (34, N'Ali', N'Yılmaz', 6, N'Turkish', CAST(N'1998-01-18' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (35, N'Mesut', N'Gündüz', 6, N'Turkish', CAST(N'1998-07-13' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (36, N'Reza', N'Mirzazade', 6, N'Persian', CAST(N'1997-03-25' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (37, N'Sezer', N'Mutlu', 7, N'Turkish', CAST(N'1998-10-18' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (38, N'Batuhan', N'Atsız', 7, N'Turkish', CAST(N'1996-08-07' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (39, N'Hakan', N'Karaman', 7, N'Turkish', CAST(N'1997-12-28' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (40, N'Oktay', N'Durmaz', 7, N'Turkish', CAST(N'1998-05-16' AS Date), 1)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (41, N'Cengiz', N'Şimşek', 7, N'Turkish', CAST(N'1997-04-23' AS Date), 3)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (42, N'Abdülhamit', N'Özcan', 7, N'Turkish', CAST(N'1998-11-21' AS Date), 7)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (43, N'Servet', N'Muhasebeci', 8, N'Turkish', CAST(N'1996-02-19' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (44, N'Necmi', N'Köfte', 8, N'Turkish', CAST(N'1995-05-12' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (45, N'Hikmet', N'Demirci', 8, N'Turkish', CAST(N'1993-02-01' AS Date), 4)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (46, N'Gökhan', N'Uzun', 8, N'Turkish', CAST(N'1993-09-14' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (47, N'Makuone', N'Kuboni', 8, N'Senagalese', CAST(N'1996-03-07' AS Date), 3)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (48, N'Hüseyin', N'Yardımcı', 8, N'Turkish', CAST(N'1992-12-09' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (49, N'Muratcan', N'Gedik', 9, N'Turkish', CAST(N'1995-09-24' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (50, N'Furkan', N'Karaca', 9, N'Turkish', CAST(N'1997-01-18' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (51, N'Serhan', N'Karaca', 9, N'Turkish', CAST(N'1998-02-14' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (52, N'Ayodele', N'Kanou', 9, N'Ginean', CAST(N'1997-11-05' AS Date), 1)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (53, N'Serhat', N'Akıcı', 9, N'Turkish', CAST(N'1998-05-20' AS Date), 2)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (54, N'Emre', N'Sözcü', 9, N'Turkish', CAST(N'1997-03-26' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (55, N'Tolga', N'Çelik', 10, N'Turkish', CAST(N'1999-02-15' AS Date), 14)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (56, N'Furkan', N'Selvi', 10, N'Turkish', CAST(N'1998-08-11' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (57, N'Mustafa', N'Hamzaoğlu', 10, N'Turkish', CAST(N'1998-03-04' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (58, N'Ömer', N'Karagülleoğlu', 10, N'Turkish', CAST(N'1998-09-23' AS Date), 3)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (59, N'Recep', N'Atalay', 10, N'Turkish', CAST(N'1998-10-30' AS Date), 1)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (60, N'Burak', N'Telli', 10, N'Turkish', CAST(N'1998-04-19' AS Date), 2)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (61, N'İsmet', N'Çapkın', 11, N'Turkish', CAST(N'1996-06-30' AS Date), 2)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (62, N'Eser', N'Adatepe', 11, N'Turkish', CAST(N'1998-07-22' AS Date), 5)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (63, N'Furkancan', N'Uzunyol', 11, N'Turkish', CAST(N'1998-01-26' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (64, N'Mehmet', N'Hasic', 11, N'Bosnian', CAST(N'1996-04-30' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (65, N'Enes', N'Kocaduvar', 11, N'Turkish', CAST(N'1995-05-28' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (66, N'Deniz', N'Zeybek', 11, N'Turkish', CAST(N'1997-01-03' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (67, N'Yusuf', N'Özyurt', 12, N'Turkish', CAST(N'1997-05-13' AS Date), 1)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (68, N'Niyazi', N'Özyurt', 12, N'Turkish', CAST(N'1998-06-30' AS Date), 2)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (69, N'Oğuz', N'Tepsici', 12, N'Turkish', CAST(N'1998-08-31' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (70, N'Yunus', N'Şentepe', 12, N'Turkish', CAST(N'1998-11-25' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (71, N'Tolga', N'Tokgöz', 12, N'Turkish', CAST(N'1998-03-09' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (72, N'Recep ', N'Yürekli', 12, N'Turkish', CAST(N'1998-12-21' AS Date), 2)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (73, N'Cengizhan', N'Dereli', 13, N'Turkish', CAST(N'1996-05-16' AS Date), 1)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (74, N'Enes', N'Süzer', 13, N'Turkish', CAST(N'1997-08-12' AS Date), 2)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (75, N'Ali', N'Şanlı', 13, N'Turkish', CAST(N'1996-11-10' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (76, N'İsmail', N'Türkmen', 13, N'Turkish', CAST(N'1996-10-03' AS Date), 2)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (77, N'Ümit', N'Üsküplü', 13, N'Turkish', CAST(N'1996-05-19' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (78, N'Kadir', N'Öztürk', 13, N'Turkish', CAST(N'1994-02-25' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (79, N'Adil', N'Özgüdenli', 14, N'Turkish', CAST(N'1996-08-17' AS Date), 6)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (80, N'Berk', N'Tepecik', 14, N'Turkish', CAST(N'1995-10-26' AS Date), 1)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (81, N'Mirza', N'Şahzade', 14, N'Persian', CAST(N'1995-03-11' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (82, N'Kemal', N'Tatlıcı', 14, N'Turkish', CAST(N'1995-09-29' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (83, N'Çağrı', N'Göçebe', 14, N'Turkish', CAST(N'1995-08-31' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (84, N'Akif', N'Muradov', 14, N'Azerbaijani', CAST(N'1995-07-30' AS Date), 4)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (85, N'Celal', N'Yüksektepe', 15, N'Turkish', CAST(N'1997-03-28' AS Date), 3)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (86, N'Enes', N'Akhisarlı', 15, N'Turkish', CAST(N'1997-08-26' AS Date), 2)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (87, N'Furkan', N'Kepelek', 15, N'Turkish', CAST(N'1997-04-09' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (88, N'Oğuzhan', N'Bahçıvan', 15, N'Turkish', CAST(N'1997-07-12' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (89, N'Abdülkadir', N'Djiboji', 15, N'Ginean', CAST(N'1997-11-23' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (90, N'Murat', N'Tektaş', 15, N'Turkish', CAST(N'1998-02-14' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (91, N'Mahmut', N'Kutalmış', 16, N'Turkish', CAST(N'1999-01-16' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (92, N'Recep', N'Çetin', 16, N'Turkish', CAST(N'1999-07-30' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (93, N'Kerem', N'Çalışkan', 16, N'Turkish', CAST(N'1999-03-21' AS Date), 2)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (94, N'Emre', N'Kamışlık', 16, N'Turkish', CAST(N'1998-11-16' AS Date), 0)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (95, N'Ahmet', N'Kızılkuş', 16, N'Turkish', CAST(N'1998-10-20' AS Date), 1)
INSERT [dbo].[PLAYER] ([PlayerID], [FirstName], [LastName], [TeamID], [Nationality], [Birthdate], [NumberOfGoals]) VALUES (96, N'Arda', N'Çakıl', 16, N'Turkish', CAST(N'1999-03-16' AS Date), 3)
GO
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (1, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (2, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (2, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (3, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (4, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (5, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (6, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (7, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (8, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (9, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (10, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (10, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (11, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (12, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (13, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (14, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (15, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (16, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (17, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (18, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (19, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (19, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (20, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (21, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (22, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (23, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (24, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (25, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (26, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (27, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (28, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (29, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (30, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (31, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (32, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (33, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (33, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (34, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (35, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (35, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (36, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (37, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (38, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (39, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (40, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (41, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (42, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (43, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (44, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (45, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (46, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (47, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (47, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (48, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (49, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (50, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (51, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (52, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (53, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (53, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (54, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (55, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (56, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (57, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (58, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (58, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (59, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (60, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (61, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (62, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (63, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (64, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (65, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (66, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (67, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (68, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (69, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (70, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (71, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (72, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (73, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (74, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (75, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (76, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (77, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (78, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (79, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (80, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (80, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (81, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (82, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (83, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (84, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (85, N'Forward')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (86, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (87, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (88, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (89, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (90, N'Defense')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (91, N'Defense')
GO
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (92, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (93, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (94, N'Goalkeeper')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (95, N'Midfield')
INSERT [dbo].[PLAYER_POSITION] ([PlayerID], [Position]) VALUES (96, N'Forward')
GO
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (1, N'Yaman', N'Şaner', 5)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (2, N'Hasan', N'Salihoğlu', 2)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (3, N'Hüseyin', N'Halsiz', 3)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (4, N'Mahmut', N'Aslantaş', 3)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (5, N'Ali', N'Dinke', 4)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (6, N'Oğuzhan', N'Tepe', 2)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (7, N'Yıldırım ', N'Türkoğlu', 1)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (8, N'Hakan', N'Marangoz', 2)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (9, N'Mehmet Ali', N'Kocatepe', 6)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (10, N'Mustafa', N'Kuzey', 4)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (11, N'Hasan', N'Akbaba', 2)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (12, N'İbrahim', N'Tezcan', 2)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (13, N'Tuna', N'Sezer', 3)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (14, N'Kerim', N'Yıldırım', 3)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (15, N'İlyas', N'Bozbaş', 5)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (16, N'Emre', N'Kuserli', 6)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (17, N'Narin', N'Kasapoğlu', 8)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (18, N'Hasan', N'Rışvanlı', 6)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (19, N'Serdar', N'Bora', 7)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (20, N'Sezgin', N'Ülker', 5)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (21, N'Muhammed', N'Temel', 7)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (22, N'Kıvanç', N'Samsa', 3)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (23, N'Abdurrahman', N'Fuat', 4)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (24, N'Tekin', N'Kasar', 2)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (25, N'Ulaş', N'Elçi', 8)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (26, N'Mehmet', N'Şentürk', 6)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (27, N'Evren', N'Özalp', 5)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (28, N'Özden', N'Akdur', 3)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (29, N'Nezih', N'Uyluk', 10)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (30, N'Erem', N'Çalış', 5)
INSERT [dbo].[REFEREE] ([RefereeID], [FirstName], [LastName], [YearsOfExperience]) VALUES (31, N'Kadir', N'Kulak', 6)
GO
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (1, N'Olimpique Limon', N'Kadıköy', 10)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (2, N'Bacakspor', N'Ataköy', 15)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (3, N'İmangücü İdman Yurdu', N'Eyüp', 19)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (4, N'Moda Kozmoz', N'Kadıköy', 4)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (5, N'Lokomotif Haydarpaşa', N'Üsküdar', 13)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (6, N'Crusader FK', N'Maltepe', 17)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (7, N'Dedeler FK', N'Gaziosmanpaşa', 6)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (8, N'Dereboyu', N'Kadıköy', 1)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (9, N'Haddini Bilbao', N'Bayrampaşa', 14)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (10, N'Şehremini FK', N'Fatih', 3)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (11, N'Baklavasına FK', N'Mediciyeköy', 8)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (12, N'Köyiçi FK', N'Güngören', 20)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (13, N'Red Bull Sarıyer', N'Sarıyer', 7)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (14, N'Cerrahpaşa FK', N'Fatih', 2)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (15, N'Hakiki Gol FK', N'Bahçelievler', 5)
INSERT [dbo].[TEAM] ([TeamID], [Name], [Location], [ManagerID]) VALUES (16, N'Hamsispor', N'Gaziosmanpaşa', 9)
GO
INSERT [dbo].[TOURNAMENT] ([TournametID], [TournamentName], [PitchID]) VALUES (1, N'MALTEPE AYDINOĞLU 2020 WINTER FOOTBALL TOURNAMENT ', 1)
INSERT [dbo].[TOURNAMENT] ([TournametID], [TournamentName], [PitchID]) VALUES (2, N'MALTEPE AYDINOĞLU 2021 SPRING FOOTBALL TOURNAMENT', 1)
INSERT [dbo].[TOURNAMENT] ([TournametID], [TournamentName], [PitchID]) VALUES (3, N'MALTEPE AYDINOPLU 2021 SUMMER FOOTBALL TOURNAMENT', 1)
INSERT [dbo].[TOURNAMENT] ([TournametID], [TournamentName], [PitchID]) VALUES (4, N'MALTEPE AYDINOĞLU 2021 FALL FOOTBALL TOURNAMENT', 1)
GO
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 1, N'A', 6, 2, 1, 0, 10, 6, N'1', N'Finals')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 2, N'A', 5, 1, 1, 1, 5, 6, N'2', N'Semi Finals')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 3, N'A', 3, 1, 0, 2, 6, 8, N'4', N'Groups')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 4, N'A', 3, 1, 0, 2, 6, 8, N'3', N'Groups')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 5, N'B', 4, 1, 1, 1, 10, 8, N'2', N'Quarter Finals')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 6, N'B', 3, 0, 2, 1, 7, 9, N'4', N'Groups')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 7, N'B', 4, 1, 2, 0, 10, 8, N'1', N'Quarter Finals')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 8, N'B', 3, 1, 1, 1, 6, 9, N'3', N'Groups')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 9, N'C', 3, 0, 0, 3, 3, 8, N'4', N'Groups')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 10, N'C', 6, 3, 0, 0, 9, 2, N'1', N'Champion')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 11, N'C', 4, 1, 1, 1, 6, 7, N'2', N'Quarter Finals')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 12, N'C', 3, 1, 1, 1, 5, 6, N'3', N'Groups')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 13, N'D', 3, 0, 1, 2, 5, 9, N'4', N'Groups')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 14, N'D', 5, 3, 0, 0, 7, 2, N'1', N'Semi Finals')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 15, N'D', 3, 0, 2, 1, 5, 7, N'3', N'Groups')
INSERT [dbo].[TOURNAMENT_TEAM] ([TournamentID], [TeamID], [GroupName], [NumberOfMatchPlayed], [Won], [Draw], [Loss], [GoalScored], [GoalConceded], [GroupPosition], [Stage]) VALUES (1, 16, N'D', 4, 1, 1, 1, 5, 4, N'2', N'Quarter Finals')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [goal_information]    Script Date: 7.01.2021 20:28:49 ******/
CREATE NONCLUSTERED INDEX [goal_information] ON [dbo].[GOAL]
(
	[HomeTeamID] ASC,
	[AwayTeamID] ASC,
	[PlayerID] ASC,
	[Minute] ASC,
	[Week] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UC_PITCH]    Script Date: 7.01.2021 20:28:49 ******/
ALTER TABLE [dbo].[PITCH] ADD  CONSTRAINT [UC_PITCH] UNIQUE NONCLUSTERED 
(
	[BusinessNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [player_firstname_lastname]    Script Date: 7.01.2021 20:28:49 ******/
CREATE NONCLUSTERED INDEX [player_firstname_lastname] ON [dbo].[PLAYER]
(
	[FirstName] ASC,
	[LastName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MANAGER] ADD  CONSTRAINT [DF_MANAGER_Nationality]  DEFAULT ('Turkish') FOR [Nationality]
GO
ALTER TABLE [dbo].[AWARDS]  WITH CHECK ADD  CONSTRAINT [FK_AWARDS_MANAGER] FOREIGN KEY([MostValuableCoachID])
REFERENCES [dbo].[MANAGER] ([ManagerID])
GO
ALTER TABLE [dbo].[AWARDS] CHECK CONSTRAINT [FK_AWARDS_MANAGER]
GO
ALTER TABLE [dbo].[AWARDS]  WITH CHECK ADD  CONSTRAINT [FK_AWARDS_PLAYER] FOREIGN KEY([MostValuablePlayerID])
REFERENCES [dbo].[PLAYER] ([PlayerID])
GO
ALTER TABLE [dbo].[AWARDS] CHECK CONSTRAINT [FK_AWARDS_PLAYER]
GO
ALTER TABLE [dbo].[AWARDS]  WITH CHECK ADD  CONSTRAINT [FK_AWARDS_TEAM] FOREIGN KEY([ChampionTeamID])
REFERENCES [dbo].[TEAM] ([TeamID])
GO
ALTER TABLE [dbo].[AWARDS] CHECK CONSTRAINT [FK_AWARDS_TEAM]
GO
ALTER TABLE [dbo].[AWARDS]  WITH CHECK ADD  CONSTRAINT [FK_AWARDS_TOURNAMENT] FOREIGN KEY([TournamentID])
REFERENCES [dbo].[TOURNAMENT] ([TournametID])
GO
ALTER TABLE [dbo].[AWARDS] CHECK CONSTRAINT [FK_AWARDS_TOURNAMENT]
GO
ALTER TABLE [dbo].[GOAL]  WITH CHECK ADD  CONSTRAINT [FK_GOAL_PLAYER] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PLAYER] ([PlayerID])
GO
ALTER TABLE [dbo].[GOAL] CHECK CONSTRAINT [FK_GOAL_PLAYER]
GO
ALTER TABLE [dbo].[GOAL]  WITH CHECK ADD  CONSTRAINT [FK_GOAL_TEAMAWAY] FOREIGN KEY([AwayTeamID])
REFERENCES [dbo].[TEAM] ([TeamID])
GO
ALTER TABLE [dbo].[GOAL] CHECK CONSTRAINT [FK_GOAL_TEAMAWAY]
GO
ALTER TABLE [dbo].[GOAL]  WITH CHECK ADD  CONSTRAINT [FK_GOAL_TEAMHOME] FOREIGN KEY([HomeTeamID])
REFERENCES [dbo].[TEAM] ([TeamID])
GO
ALTER TABLE [dbo].[GOAL] CHECK CONSTRAINT [FK_GOAL_TEAMHOME]
GO
ALTER TABLE [dbo].[MATCH]  WITH CHECK ADD  CONSTRAINT [FK_MATCH_REFEREE] FOREIGN KEY([RefereeID])
REFERENCES [dbo].[REFEREE] ([RefereeID])
GO
ALTER TABLE [dbo].[MATCH] CHECK CONSTRAINT [FK_MATCH_REFEREE]
GO
ALTER TABLE [dbo].[MATCH]  WITH CHECK ADD  CONSTRAINT [FK_MATCH_TEAMAWAY] FOREIGN KEY([AwayTeamID])
REFERENCES [dbo].[TEAM] ([TeamID])
GO
ALTER TABLE [dbo].[MATCH] CHECK CONSTRAINT [FK_MATCH_TEAMAWAY]
GO
ALTER TABLE [dbo].[MATCH]  WITH CHECK ADD  CONSTRAINT [FK_MATCH_TEAMHOME] FOREIGN KEY([HomeTeamID])
REFERENCES [dbo].[TEAM] ([TeamID])
GO
ALTER TABLE [dbo].[MATCH] CHECK CONSTRAINT [FK_MATCH_TEAMHOME]
GO
ALTER TABLE [dbo].[PLAYER]  WITH CHECK ADD  CONSTRAINT [FK_PLAYER_TEAM] FOREIGN KEY([TeamID])
REFERENCES [dbo].[TEAM] ([TeamID])
GO
ALTER TABLE [dbo].[PLAYER] CHECK CONSTRAINT [FK_PLAYER_TEAM]
GO
ALTER TABLE [dbo].[PLAYER_POSITION]  WITH CHECK ADD  CONSTRAINT [FK_PLAYER_POSITION_PLAYER] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PLAYER] ([PlayerID])
GO
ALTER TABLE [dbo].[PLAYER_POSITION] CHECK CONSTRAINT [FK_PLAYER_POSITION_PLAYER]
GO
ALTER TABLE [dbo].[TEAM]  WITH CHECK ADD  CONSTRAINT [FK_TEAM_MANAGER] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[MANAGER] ([ManagerID])
GO
ALTER TABLE [dbo].[TEAM] CHECK CONSTRAINT [FK_TEAM_MANAGER]
GO
ALTER TABLE [dbo].[TOURNAMENT]  WITH CHECK ADD  CONSTRAINT [FK_TOURNAMENT_PITCH] FOREIGN KEY([PitchID])
REFERENCES [dbo].[PITCH] ([PitchID])
GO
ALTER TABLE [dbo].[TOURNAMENT] CHECK CONSTRAINT [FK_TOURNAMENT_PITCH]
GO
ALTER TABLE [dbo].[TOURNAMENT_TEAM]  WITH CHECK ADD  CONSTRAINT [FK_TOURNAMENT_TEAM_TEAM] FOREIGN KEY([TeamID])
REFERENCES [dbo].[TEAM] ([TeamID])
GO
ALTER TABLE [dbo].[TOURNAMENT_TEAM] CHECK CONSTRAINT [FK_TOURNAMENT_TEAM_TEAM]
GO
ALTER TABLE [dbo].[TOURNAMENT_TEAM]  WITH CHECK ADD  CONSTRAINT [FK_TOURNAMENT_TEAM_TOURNAMENT] FOREIGN KEY([TournamentID])
REFERENCES [dbo].[TOURNAMENT] ([TournametID])
GO
ALTER TABLE [dbo].[TOURNAMENT_TEAM] CHECK CONSTRAINT [FK_TOURNAMENT_TEAM_TOURNAMENT]
GO
ALTER TABLE [dbo].[REFEREE]  WITH CHECK ADD  CONSTRAINT [Chk_REFEREE_YearsOfExperience] CHECK  (([YearsOfExperience]>(0)))
GO
ALTER TABLE [dbo].[REFEREE] CHECK CONSTRAINT [Chk_REFEREE_YearsOfExperience]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertManagerInfo]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_InsertManagerInfo]
	@ManagerID tinyint, 
	@FirstName nvarchar(20), @LastName nvarchar(20),
	@Nationality char(7), @Birthdate date,
	@Experience tinyint
as
begin
	set nocount on;
	
	insert into Manager(ManagerID, FirstName, LastName, Nationality,Birthdate,YearsOfExperience)
	values(@ManagerID,@FirstName,@LastName,@Nationality,@Birthdate,@Experience)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertRefereeInfo]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_InsertRefereeInfo]
	@RefereeID tinyint, @FirstName nvarchar(20),
	@LastName nvarchar(20), @Experience int
as
begin
	set nocount on;
	
	insert into Referee(RefereeID, FirstName, LastName, YearsOfExperience)
	values(@RefereeID,@FirstName,@LastName,@Experience)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ListMatches]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_ListMatches]
      @Date date
as
begin
      set nocount on;
	  if (@Date<'2020-12-01')
	  begin
	     Raiserror('Not a date involving in season time!', 0, 1)
		 return 0
      end
	  Select th.Name HomeTeam, ta.Name AwayTeam, m.Week WeekNumber, r.FirstName + ' ' + r.LastName RefereeFullname,
	               m.Date WhichDate, m.FinalResult Result, m.MatchStage Stage
      From Match m inner join Team ta on m.AwayTeamID=ta.TeamID
	             inner join Team th on m.HomeTeamID=th.TeamID
				 inner join REFEREE r on m.RefereeID=r.RefereeID
      Where m.Date > @Date
end
GO
/****** Object:  StoredProcedure [dbo].[sp_MostValuablesForTeam]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_MostValuablesForTeam]
     @TeamName nvarchar(20)
as
begin
     set nocount on;

	 Select MAX(p.NumberOfGoals) PlayerWithMaxGoal, mg.FirstName + ' ' + mg.LastName TeamsCoach
	 From TOURNAMENT_TEAM tt inner join TEAM t on tt.TeamID=t.TeamID
	      inner join Player p on p.TeamID=t.TeamID 
		  inner join Manager mg on t.ManagerID=mg.ManagerID
	 Where t.Name=@TeamName
	 Group By t.TeamID, mg.FirstName + ' ' + mg.LastName


end
GO
/****** Object:  StoredProcedure [dbo].[sp_RefereeStages]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_RefereeStages]
	@RefereeFN nvarchar(20), @RefereeLN nvarchar(20)
as
begin
	Select m.MatchStage, Count(*) NumberOfMatches 
	From Referee r inner join Match m on m.RefereeID=r.RefereeID
	Where r.FirstName=@RefereeFN and r.LastName=@RefereeLN
	Group By m.MatchStage
end
GO
/****** Object:  StoredProcedure [dbo].[sp_TeamSeasonStats]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_TeamSeasonStats]
	@TeamName nvarchar(20)
as
begin
	set nocount on;

	Select *
	From TOURNAMENT_TEAM tt inner join Team t on tt.TeamID=t.TeamID
	Where t.Name = @TeamName
end
GO
/****** Object:  StoredProcedure [dbo].[sp_TopGoalScorers]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_TopGoalScorers]
     @limit int
as
begin
     set nocount on;

	 Select rank() over(Order By p.NumberOfGoals desc) rankNum, *
     from (Select top(@limit) * 
	      From Player) p
end
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePitchInfo]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_UpdatePitchInfo]
     @PitchID tinyint, @Name nvarchar(20),
	 @Location nvarchar(20), @OwnerName nvarchar(25), @BusinessNumber char(10)
as
begin
     set nocount on;

	 Update PITCH
	 Set Name=@Name, Location=@Location,
		OwnerName=@OwnerName, BusinessNumber=@BusinessNumber
     Where PitchID=@PitchID
end
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePlayerInfo]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_UpdatePlayerInfo]
     @PlayerID tinyint, @FirstName nvarchar(20), @LastName nvarchar(20),
	 @Nationality varchar(25), @Birthdate date, @NumberOfGoals tinyint
as
begin
     set nocount on;

	 Update Player
	 Set FirstName=@FirstName, LastName=@LastName, Nationality=@Nationality,
	     Birthdate=convert(date, @Birthdate), NumberOfGoals=@NumberOfGoals
	 Where PlayerID=@PlayerID
end
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateRefereeInfo]    Script Date: 7.01.2021 20:28:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_UpdateRefereeInfo]
	@RefereeID tinyint, @FirstName nvarchar(20),
	@LastName nvarchar(20), @Experience int
as
begin
	set nocount on;
	
	Update REFEREE
	Set RefereeID=@RefereeID, FirstName=@FirstName,
		LastName=@LastName, YearsOfExperience=@Experience
	Where RefereeID=@RefereeID
end
GO
USE [master]
GO
ALTER DATABASE [FOOTBALL_TOURNAMENT] SET  READ_WRITE 
GO
