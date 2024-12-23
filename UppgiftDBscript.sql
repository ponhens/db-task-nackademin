USE [master]
GO
/****** Object:  Database [UppgiftDB]    Script Date: 2024-12-10 13:15:35 ******/
CREATE DATABASE [UppgiftDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UppgiftDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\UppgiftDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'UppgiftDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\UppgiftDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [UppgiftDB] ADD FILEGROUP [Partitionings]
GO
ALTER DATABASE [UppgiftDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UppgiftDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UppgiftDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UppgiftDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UppgiftDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UppgiftDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UppgiftDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [UppgiftDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UppgiftDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UppgiftDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UppgiftDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UppgiftDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UppgiftDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UppgiftDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UppgiftDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UppgiftDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UppgiftDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [UppgiftDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UppgiftDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UppgiftDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UppgiftDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UppgiftDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UppgiftDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UppgiftDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UppgiftDB] SET RECOVERY FULL 
GO
ALTER DATABASE [UppgiftDB] SET  MULTI_USER 
GO
ALTER DATABASE [UppgiftDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UppgiftDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UppgiftDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UppgiftDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [UppgiftDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [UppgiftDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'UppgiftDB', N'ON'
GO
ALTER DATABASE [UppgiftDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [UppgiftDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [UppgiftDB]
GO
/****** Object:  PartitionFunction [AgePartitionFunction]    Script Date: 2024-12-10 13:15:35 ******/
CREATE PARTITION FUNCTION [AgePartitionFunction](int) AS RANGE LEFT FOR VALUES (30, 60)
GO
/****** Object:  PartitionScheme [AgePartitionScheme]    Script Date: 2024-12-10 13:15:35 ******/
CREATE PARTITION SCHEME [AgePartitionScheme] AS PARTITION [AgePartitionFunction] TO ([PRIMARY], [PRIMARY], [PRIMARY])
GO
/****** Object:  Table [dbo].[cars]    Script Date: 2024-12-10 13:15:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cars](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[model] [nvarchar](50) NOT NULL,
	[make] [nvarchar](50) NOT NULL,
	[year] [int] NOT NULL,
	[owner] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[persons]    Script Date: 2024-12-10 13:15:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[persons](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[age] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[persons_partitioned]    Script Date: 2024-12-10 13:15:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[persons_partitioned](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[age] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[age] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [AgePartitionScheme]([age])
) ON [AgePartitionScheme]([age])
GO
SET IDENTITY_INSERT [dbo].[cars] ON 

INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (1, N'Accord', N'Honda', 2020, 1)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (2, N'Camry', N'Toyota', 2018, 2)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (3, N'F-150', N'Ford', 2022, 3)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (4, N'Civic', N'Honda', 2019, 4)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (5, N'Model S', N'Tesla', 2021, 5)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (6, N'Outback', N'Subaru', 2017, 6)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (7, N'Mustang', N'Ford', 2020, 7)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (8, N'3 Series', N'BMW', 2018, 8)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (9, N'A4', N'Audi', 2019, 9)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (10, N'Altima', N'Nissan', 2021, 10)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (11, N'Accord', N'Honda', 2020, 11)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (12, N'Camry', N'Toyota', 2018, 12)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (13, N'F-150', N'Ford', 2022, 13)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (14, N'Civic', N'Honda', 2019, 14)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (15, N'Model S', N'Tesla', 2021, 15)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (16, N'Outback', N'Subaru', 2017, 16)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (17, N'Mustang', N'Ford', 2020, 17)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (18, N'3 Series', N'BMW', 2018, 18)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (19, N'A4', N'Audi', 2019, 19)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (20, N'Altima', N'Nissan', 2021, 20)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (21, N'Corolla', N'Toyota', 2020, 21)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (22, N'Tiguan', N'Volkswagen', 2018, 22)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (23, N'Cherokee', N'Jeep', 2022, 23)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (24, N'Pilot', N'Honda', 2019, 24)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (25, N'CX-5', N'Mazda', 2021, 25)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (26, N'RAV4', N'Toyota', 2020, 26)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (27, N'Tacoma', N'Toyota', 2018, 27)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (28, N'Bronco', N'Ford', 2022, 28)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (29, N'Malibu', N'Chevrolet', 2019, 29)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (30, N'Silverado', N'Chevrolet', 2021, 30)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (31, N'Impala', N'Chevrolet', 2020, 31)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (32, N'Golf', N'Volkswagen', 2018, 32)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (33, N'Santa Fe', N'Hyundai', 2022, 33)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (34, N'Tucson', N'Hyundai', 2019, 34)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (35, N'Elantra', N'Hyundai', 2021, 35)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (36, N'Sonata', N'Hyundai', 2020, 36)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (37, N'Wrangler', N'Jeep', 2018, 37)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (38, N'Compass', N'Jeep', 2022, 38)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (39, N'Charger', N'Dodge', 2019, 39)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (40, N'Durango', N'Dodge', 2021, 40)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (41, N'Ram 1500', N'Dodge', 2020, 41)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (42, N'E-Class', N'Mercedes-Benz', 2018, 42)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (43, N'C-Class', N'Mercedes-Benz', 2022, 43)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (44, N'GLC', N'Mercedes-Benz', 2019, 44)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (45, N'Sportage', N'Kia', 2021, 45)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (46, N'Sorento', N'Kia', 2020, 46)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (47, N'Optima', N'Kia', 2018, 47)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (48, N'Stinger', N'Kia', 2022, 48)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (49, N'Rio', N'Kia', 2019, 49)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (50, N'Soul', N'Kia', 2021, 50)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (51, N'Trailblazer', N'Chevrolet', 2020, 51)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (52, N'Avalon', N'Toyota', 2018, 52)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (53, N'Tundra', N'Toyota', 2022, 53)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (54, N'Yaris', N'Toyota', 2019, 54)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (55, N'Model 3', N'Tesla', 2021, 55)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (56, N'Model X', N'Tesla', 2020, 56)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (57, N'Model Y', N'Tesla', 2018, 57)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (58, N'Sentra', N'Nissan', 2022, 58)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (59, N'Pathfinder', N'Nissan', 2019, 59)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (60, N'Titan', N'Nissan', 2021, 60)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (61, N'Leaf', N'Nissan', 2020, 61)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (62, N'Armada', N'Nissan', 2018, 62)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (63, N'Q5', N'Audi', 2022, 63)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (64, N'Q7', N'Audi', 2019, 64)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (65, N'R8', N'Audi', 2021, 65)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (66, N'S7', N'Audi', 2020, 66)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (67, N'X5', N'BMW', 2018, 67)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (68, N'X3', N'BMW', 2022, 68)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (69, N'Z4', N'BMW', 2019, 69)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (70, N'Corvette', N'Chevrolet', 2021, 70)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (71, N'Equinox', N'Chevrolet', 2020, 71)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (72, N'Bolt', N'Chevrolet', 2018, 72)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (73, N'Sierra', N'GMC', 2022, 73)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (74, N'Canyon', N'GMC', 2019, 74)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (75, N'Acadia', N'GMC', 2021, 75)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (76, N'Terrain', N'GMC', 2020, 76)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (77, N'Escalade', N'Cadillac', 2018, 77)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (78, N'XT5', N'Cadillac', 2022, 78)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (79, N'CT5', N'Cadillac', 2019, 79)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (80, N'CT4', N'Cadillac', 2021, 80)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (81, N'Panamera', N'Porsche', 2020, 81)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (82, N'911', N'Porsche', 2018, 82)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (83, N'Cayenne', N'Porsche', 2022, 83)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (84, N'Macan', N'Porsche', 2019, 84)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (85, N'Boxster', N'Porsche', 2021, 85)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (86, N'Supra', N'Toyota', 2020, 86)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (87, N'S4', N'Audi', 2018, 87)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (88, N'RX', N'Lexus', 2022, 88)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (89, N'NX', N'Lexus', 2019, 89)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (90, N'GX', N'Lexus', 2021, 90)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (91, N'IS', N'Lexus', 2020, 91)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (92, N'LX', N'Lexus', 2018, 92)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (93, N'S-Class', N'Mercedes-Benz', 2022, 93)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (94, N'CLS', N'Mercedes-Benz', 2019, 94)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (95, N'GLA', N'Mercedes-Benz', 2021, 95)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (96, N'XC90', N'Volvo', 2020, 96)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (97, N'XC60', N'Volvo', 2018, 97)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (98, N'XC40', N'Volvo', 2022, 98)
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (99, N'V60', N'Volvo', 2019, 99)
GO
INSERT [dbo].[cars] ([id], [model], [make], [year], [owner]) VALUES (100, N'S90', N'Volvo', 2021, 100)
SET IDENTITY_INSERT [dbo].[cars] OFF
GO
SET IDENTITY_INSERT [dbo].[persons] ON 

INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (1, N'Anna', N'Svensson', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (2, N'Björn', N'Andersson', 45)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (3, N'Carina', N'Johansson', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (4, N'David', N'Karlsson', 35)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (5, N'Emma', N'Nilsson', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (6, N'Fredrik', N'Larsson', 40)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (7, N'Gabriella', N'Persson', 22)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (8, N'Henrik', N'Olsson', 50)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (9, N'Isabella', N'Eriksson', 33)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (10, N'Johan', N'Bergström', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (11, N'Emma', N'Johansson', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (12, N'Oscar', N'Eriksson', 32)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (13, N'Alice', N'Karlsson', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (14, N'Lucas', N'Andersson', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (15, N'Ella', N'Nilsson', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (16, N'Liam', N'Svensson', 35)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (17, N'Astrid', N'Larsson', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (18, N'Noah', N'Persson', 22)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (19, N'Freja', N'Lindberg', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (20, N'Hugo', N'Gustafsson', 34)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (21, N'Wilma', N'Berg', 26)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (22, N'Axel', N'Håkansson', 31)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (23, N'Maja', N'Holm', 23)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (24, N'Oliver', N'Sandberg', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (25, N'Ines', N'Sjöberg', 21)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (26, N'Elliot', N'Fransson', 33)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (27, N'Clara', N'Isaksson', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (28, N'Vincent', N'Nyström', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (29, N'Saga', N'Eklund', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (30, N'Theo', N'Hedlund', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (31, N'Alma', N'Ekström', 22)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (32, N'Leo', N'Jonsson', 34)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (33, N'Signe', N'Ström', 23)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (34, N'Adrian', N'Björk', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (35, N'Tilde', N'Olofsson', 31)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (36, N'William', N'Lund', 33)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (37, N'Selma', N'Hellström', 26)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (38, N'Melvin', N'Magnusson', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (39, N'Elin', N'Falk', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (40, N'Isak', N'Axelsson', 32)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (41, N'Agnes', N'Forsberg', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (42, N'Viktor', N'Dahl', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (43, N'Ebba', N'Norén', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (44, N'Alfred', N'Petersson', 21)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (45, N'Nora', N'Engström', 22)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (46, N'Sebastian', N'Sundberg', 34)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (47, N'Stella', N'Hansson', 23)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (48, N'Filip', N'Åkesson', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (49, N'Molly', N'Westman', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (50, N'Alexander', N'Fors', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (51, N'Ida', N'Blom', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (52, N'Charlie', N'Norberg', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (53, N'Julia', N'Åström', 31)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (54, N'Ludvig', N'Ljung', 33)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (55, N'Liv', N'Viklund', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (56, N'Victor', N'Rosén', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (57, N'Hanna', N'Bergman', 26)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (58, N'Anton', N'Sjögren', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (59, N'Meja', N'Ek', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (60, N'Emil', N'Löf', 32)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (61, N'Tuva', N'Borg', 22)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (62, N'Wilhelm', N'Lindahl', 34)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (63, N'Svea', N'Nyberg', 23)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (64, N'David', N'Hellman', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (65, N'Leia', N'Anderberg', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (66, N'Arvid', N'Sten', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (67, N'Lova', N'Sund', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (68, N'Simon', N'Holmgren', 21)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (69, N'Nellie', N'Emanuelsson', 22)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (70, N'Hampus', N'Olsson', 34)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (71, N'Sofia', N'Evertsson', 31)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (72, N'Edvin', N'Törnqvist', 33)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (73, N'Elsa', N'Backman', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (74, N'Jonathan', N'Rudström', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (75, N'Elvira', N'Thorsson', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (76, N'Samuel', N'Wallin', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (77, N'Tova', N'Hellqvist', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (78, N'Gabriel', N'Rask', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (79, N'Ester', N'Lind', 22)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (80, N'Rasmus', N'Carlsson', 34)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (81, N'Tyra', N'Palm', 23)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (82, N'Jakob', N'Torell', 26)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (83, N'Märta', N'Tegen', 31)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (84, N'Mattias', N'Heden', 33)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (85, N'Isabella', N'Holst', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (86, N'Love', N'Brorsson', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (87, N'Joline', N'Friberg', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (88, N'Daniel', N'Zetterberg', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (89, N'Emilia', N'Jansson', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (90, N'Tobias', N'Lilja', 32)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (91, N'Victoria', N'Foss', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (92, N'Erik', N'Öberg', 33)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (93, N'Caroline', N'Högman', 26)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (94, N'Fredrik', N'Pålsson', 34)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (95, N'Ellinor', N'Bertilsson', 23)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (96, N'Joakim', N'Torneus', 31)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (97, N'Therese', N'Grön', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (98, N'Simon', N'Bladh', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (99, N'Emma', N'Lundberg', 25)
GO
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (100, N'Emma', N'Sjöholm', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (101, N'Emma', N'Nilsson', 22)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (102, N'Emma', N'Persson', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (103, N'Emma', N'Jonsson', 35)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (104, N'Emma', N'Karlsson', 21)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (105, N'Emma', N'Andersson', 34)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (106, N'Emma', N'Bergström', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (107, N'Emma', N'Eklund', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (108, N'Emma', N'Falk', 23)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (109, N'Emma', N'Lindberg', 26)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (110, N'Emma', N'Hedman', 32)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (111, N'Emma', N'Eriksson', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (112, N'Emma', N'Sandberg', 33)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (113, N'Emma', N'Viklund', 31)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (114, N'Emma', N'Åkesson', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (115, N'Emma', N'Forsman', 20)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (116, N'Emma', N'Larsson', 35)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (117, N'Emma', N'Håkansson', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (118, N'Emma', N'Sundström', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (119, N'Emma', N'Hellström', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (120, N'Emma', N'Backlund', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (121, N'Emma', N'Nordberg', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (122, N'Emma', N'Olsson', 32)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (123, N'Emma', N'Ljungberg', 26)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (124, N'Emma', N'Nyström', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (125, N'Emma', N'Fransson', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (126, N'Emma', N'Dahl', 34)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (127, N'Emma', N'Magnusson', 33)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (128, N'Emma', N'Ström', 22)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (129, N'Adam', N'Johansson', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (130, N'Moa', N'Eriksson', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (131, N'Hugo', N'Karlsson', 23)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (132, N'Alva', N'Andersson', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (133, N'Elliot', N'Nilsson', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (134, N'Vera', N'Svensson', 21)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (135, N'Theodor', N'Larsson', 34)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (136, N'Ingrid', N'Persson', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (137, N'Aron', N'Lindberg', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (138, N'Linnea', N'Hedman', 26)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (139, N'Felix', N'Gustafsson', 33)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (140, N'Elise', N'Bergström', 20)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (141, N'Noel', N'Löfberg', 32)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (142, N'Tilde', N'Friberg', 22)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (143, N'Wilmer', N'Nyström', 31)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (144, N'Lovisa', N'Sandberg', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (145, N'Melker', N'Isaksson', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (146, N'Sigrid', N'Ekström', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (147, N'Lukas', N'Ek', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (148, N'Jasmine', N'Blom', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (149, N'Benjamin', N'Hellqvist', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (150, N'Molly', N'Åkesson', 23)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (151, N'Oliver', N'Rosén', 34)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (152, N'Alice', N'Holmgren', 26)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (153, N'Axel', N'Wallin', 31)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (154, N'Nelly', N'Falk', 22)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (155, N'Elvin', N'Jonsson', 35)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (156, N'Edith', N'Björk', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (157, N'Alfred', N'Norberg', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (158, N'Liv', N'Zetterström', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (159, N'Emil', N'Holm', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (160, N'Stella', N'Fors', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (161, N'Leo', N'Anderberg', 26)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (162, N'Freja', N'Thorsson', 23)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (163, N'Wilhelm', N'Rudström', 31)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (164, N'Clara', N'Evertsson', 21)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (165, N'Gabriel', N'Forsman', 32)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (166, N'Hanna', N'Sten', 33)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (167, N'Samuel', N'Nygren', 20)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (168, N'Elvira', N'Högberg', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (169, N'Jonathan', N'Lund', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (170, N'Linnea', N'Olofsson', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (171, N'Rasmus', N'Petersson', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (172, N'Agnes', N'Sjöberg', 26)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (173, N'Thea', N'Ström', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (174, N'Adrian', N'Fors', 22)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (175, N'Selma', N'Dahl', 34)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (176, N'Viktor', N'Ljung', 23)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (177, N'Saga', N'Sund', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (178, N'Ella', N'Palm', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (179, N'Malte', N'Fransson', 31)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (180, N'Nora', N'Backman', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (181, N'Oskar', N'Andersson', 30)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (182, N'Maja', N'Bladh', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (183, N'William', N'Eriksson', 33)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (184, N'Meja', N'Larsson', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (185, N'Vincent', N'Magnusson', 21)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (186, N'Isabelle', N'Emanuelsson', 28)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (187, N'Sebastian', N'Westman', 26)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (188, N'Alma', N'Holst', 27)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (189, N'Simon', N'Jonasson', 34)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (190, N'Victoria', N'Björklund', 24)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (191, N'David', N'Carlsson', 32)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (192, N'Sofia', N'Åström', 25)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (193, N'Hampus', N'Lind', 29)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (194, N'Tobias', N'Forsberg', 31)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (195, N'Anders', N'Johansson', 36)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (196, N'Birgitta', N'Eriksson', 45)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (197, N'Carl', N'Karlsson', 50)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (198, N'Dagny', N'Andersson', 55)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (199, N'Eva', N'Nilsson', 37)
GO
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (200, N'Fredrik', N'Svensson', 60)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (201, N'Greta', N'Larsson', 44)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (202, N'Henrik', N'Persson', 41)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (203, N'Ingrid', N'Lindberg', 58)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (204, N'Johan', N'Hedman', 48)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (205, N'Kristina', N'Gustafsson', 36)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (206, N'Lars', N'Bergström', 52)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (207, N'Maria', N'Löfberg', 46)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (208, N'Nils', N'Friberg', 49)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (209, N'Olof', N'Nyström', 57)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (210, N'Pia', N'Sandberg', 38)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (211, N'Quintus', N'Isaksson', 54)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (212, N'Rut', N'Ekström', 39)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (213, N'Sven', N'Ek', 53)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (214, N'Tora', N'Blom', 42)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (215, N'Urban', N'Hellqvist', 47)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (216, N'Vera', N'Åkesson', 40)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (217, N'William', N'Rosén', 36)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (218, N'Xenia', N'Holmgren', 51)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (219, N'Yngve', N'Wallin', 60)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (220, N'Åsa', N'Falk', 39)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (221, N'Anna', N'Jonsson', 41)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (222, N'Bengt', N'Björk', 45)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (223, N'Cecilia', N'Norberg', 56)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (224, N'David', N'Zetterström', 43)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (225, N'Elisabeth', N'Holm', 49)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (226, N'Frank', N'Fors', 58)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (227, N'Gun', N'Anderberg', 50)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (228, N'Helena', N'Thorsson', 37)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (229, N'Ivan', N'Rudström', 46)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (230, N'Jenny', N'Evertsson', 59)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (231, N'Karl', N'Forsman', 38)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (232, N'Lisa', N'Sten', 44)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (233, N'Magnus', N'Nygren', 55)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (234, N'Nina', N'Högberg', 53)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (235, N'Oscar', N'Lund', 40)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (236, N'Petra', N'Olofsson', 47)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (237, N'Robert', N'Petersson', 48)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (238, N'Sara', N'Sjöberg', 42)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (239, N'Thomas', N'Ström', 54)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (240, N'Ulla', N'Dahl', 41)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (241, N'Viktor', N'Ljung', 58)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (242, N'Wendy', N'Sund', 43)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (243, N'Xavier', N'Palm', 59)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (244, N'Yvonne', N'Fransson', 50)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (245, N'Åke', N'Backman', 39)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (246, N'Agneta', N'Andersson', 45)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (247, N'Bo', N'Bladh', 56)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (248, N'Camilla', N'Eriksson', 46)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (249, N'Dennis', N'Larsson', 40)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (250, N'Ellen', N'Sundström', 53)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (251, N'Frans', N'Hellström', 39)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (252, N'Gunilla', N'Backlund', 51)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (253, N'Hans', N'Nordberg', 55)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (254, N'Iris', N'Olsson', 38)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (255, N'Jan', N'Ljungberg', 44)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (256, N'Karin', N'Nyström', 60)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (257, N'Lennart', N'Fransson', 43)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (258, N'Malin', N'Dahl', 42)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (259, N'Niklas', N'Magnusson', 41)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (260, N'Oskar', N'Ström', 49)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (261, N'Pelle', N'Högberg', 57)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (262, N'Rolf', N'Carlsson', 58)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (263, N'Sandra', N'Åström', 40)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (264, N'Tomas', N'Lind', 48)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (265, N'Ulf', N'Forsberg', 47)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (266, N'Viktoria', N'Bladh', 45)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (267, N'Wilhelm', N'Hellqvist', 36)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (268, N'Xander', N'Holst', 59)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (269, N'Ylva', N'Jonasson', 54)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (270, N'Åsa', N'Björklund', 50)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (271, N'Alex', N'Carlsson', 46)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (272, N'Beatrice', N'Emanuelsson', 38)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (273, N'Christer', N'Westman', 41)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (274, N'Daniel', N'Holst', 53)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (275, N'Elsa', N'Foss', 39)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (276, N'Fredrik', N'Öberg', 55)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (277, N'Gabriel', N'Bertilsson', 49)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (278, N'Helena', N'Torneus', 60)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (279, N'Isabelle', N'Grön', 48)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (280, N'Jens', N'Bladh', 47)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (281, N'Kerstin', N'Bergström', 43)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (282, N'Leif', N'Axelsson', 57)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (283, N'Monica', N'Forsberg', 51)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (284, N'Nina', N'Jonsson', 52)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (285, N'Ove', N'Blom', 40)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (286, N'Patrik', N'Hedlund', 44)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (287, N'Roger', N'Nyberg', 59)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (288, N'Susanne', N'Pålsson', 50)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (289, N'Torbjörn', N'Viklund', 58)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (290, N'Alice', N'Johansson', 15)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (291, N'Oscar', N'Eriksson', 18)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (292, N'Maja', N'Karlsson', 17)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (293, N'Lucas', N'Andersson', 20)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (294, N'Ella', N'Nilsson', 16)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (295, N'Hugo', N'Svensson', 14)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (296, N'Alma', N'Larsson', 13)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (297, N'Noah', N'Persson', 19)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (298, N'Freja', N'Lindberg', 20)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (299, N'William', N'Gustafsson', 17)
GO
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (300, N'Wilma', N'Berg', 12)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (301, N'Axel', N'Håkansson', 18)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (302, N'Elin', N'Holm', 15)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (303, N'Theo', N'Sandberg', 16)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (304, N'Nellie', N'Sjöberg', 14)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (305, N'Isak', N'Fransson', 19)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (306, N'Elsa', N'Isaksson', 13)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (307, N'Viktor', N'Nyström', 20)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (308, N'Ines', N'Eklund', 18)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (309, N'Melvin', N'Hedlund', 12)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (310, N'Liv', N'Ekström', 17)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (311, N'Sebastian', N'Jonsson', 14)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (312, N'Tilde', N'Ström', 15)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (313, N'Adrian', N'Björk', 16)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (314, N'Clara', N'Olofsson', 10)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (315, N'Leo', N'Lund', 11)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (316, N'Alfred', N'Hellström', 19)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (317, N'Agnes', N'Magnusson', 12)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (318, N'Liam', N'Falk', 14)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (319, N'Ebba', N'Axelsson', 15)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (320, N'Oliver', N'Forsberg', 18)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (321, N'Molly', N'Dahl', 13)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (322, N'Alexander', N'Norén', 16)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (323, N'Tuva', N'Engström', 17)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (324, N'Lova', N'Sundberg', 20)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (325, N'Samuel', N'Björklund', 12)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (326, N'Stella', N'Emanuelsson', 19)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (327, N'Edvin', N'Olsson', 13)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (328, N'Saga', N'Åkesson', 15)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (329, N'Charlie', N'Holmgren', 18)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (330, N'Elliot', N'Wallin', 11)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (331, N'Julia', N'Blom', 14)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (332, N'Filip', N'Norberg', 10)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (333, N'Nora', N'Hellqvist', 20)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (334, N'Ester', N'Hedman', 19)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (335, N'Arvid', N'Fors', 17)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (336, N'Meja', N'Rudström', 12)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (337, N'Wilhelm', N'Evertsson', 16)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (338, N'Signe', N'Högman', 11)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (339, N'Jonathan', N'Carlsson', 18)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (340, N'Leia', N'Friberg', 10)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (341, N'Hampus', N'Jonasson', 14)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (342, N'Svea', N'Tornberg', 13)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (343, N'Gabriel', N'Zetterström', 19)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (344, N'Tova', N'Nygren', 20)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (345, N'Simon', N'Lind', 16)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (346, N'Victoria', N'Högberg', 18)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (347, N'Rasmus', N'Bladh', 17)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (348, N'Malte', N'Viklund', 12)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (349, N'Elvira', N'Palm', 14)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (350, N'Love', N'Magnusson', 15)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (351, N'Märta', N'Sund', 13)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (352, N'Daniel', N'Backman', 11)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (353, N'Tyra', N'Holst', 19)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (354, N'Jakob', N'Forsman', 20)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (355, N'Isabelle', N'Thorsson', 17)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (356, N'Fredrik', N'Larsson', 16)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (357, N'Therese', N'Westman', 18)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (358, N'Josef', N'Löf', 12)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (359, N'Hanna', N'Ström', 14)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (360, N'Emanuel', N'Rosén', 11)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (361, N'Sofia', N'Bergström', 15)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (362, N'Mattias', N'Bertilsson', 18)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (363, N'Ellinor', N'Grön', 16)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (364, N'Erik', N'Jonsson', 19)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (365, N'Tobias', N'Lilja', 10)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (366, N'Lovisa', N'Sundström', 13)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (367, N'David', N'Nyberg', 20)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (368, N'Alva', N'Viklund', 12)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (369, N'Joline', N'Blomqvist', 15)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (370, N'Gabriella', N'Petersson', 18)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (371, N'Alexander', N'Forslund', 17)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (372, N'Helena', N'Hansson', 14)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (373, N'Christoffer', N'Torell', 16)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (374, N'Ida', N'Foss', 11)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (375, N'Ludvig', N'Pålsson', 19)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (376, N'Victoria', N'Zetterberg', 20)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (377, N'Oscar', N'Bergman', 13)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (378, N'Josefin', N'Ekman', 15)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (379, N'Tobias', N'Lundberg', 10)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (380, N'Filippa', N'Ljung', 17)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (381, N'Anton', N'Holmqvist', 19)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (382, N'Caroline', N'Sjögren', 12)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (383, N'Emil', N'Sundqvist', 16)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (384, N'Alice', N'Lindahl', 18)
INSERT [dbo].[persons] ([id], [first_name], [last_name], [age]) VALUES (385, N'Ester', N'Hedström', 14)
SET IDENTITY_INSERT [dbo].[persons] OFF
GO
SET IDENTITY_INSERT [dbo].[persons_partitioned] ON 

INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (1, N'John', N'Doe', 25)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (4, N'Emily', N'Brown', 23)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (7, N'David', N'Miller', 28)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (8, N'Sarah', N'Davis', 19)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (10, N'Sophia', N'Martínez', 30)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (12, N'Olivia', N'Hernández', 22)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (14, N'Isabella', N'González', 29)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (15, N'Ethan', N'Wilson', 27)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (18, N'Mia', N'Taylor', 21)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (22, N'Amelia', N'Harris', 24)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (27, N'Samuel', N'Roberts', 26)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (34, N'Ella', N'Green', 18)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (39, N'Gabriel', N'Mitchell', 29)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (40, N'Aria', N'Perez', 25)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (43, N'Jackson', N'Evans', 28)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (46, N'Ruby', N'Gray', 26)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (49, N'Lila', N'Stewart', 23)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (51, N'Zoe', N'Rodriguez', 28)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (54, N'Ryan', N'Reed', 27)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (55, N'Aiden', N'Cook', 19)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (59, N'Avery', N'James', 24)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (61, N'Caroline', N'Cole', 29)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (63, N'Isla', N'Lopez', 26)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (70, N'Penelope', N'Wright', 23)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (71, N'Joseph', N'Bennett', 22)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (73, N'Madison', N'Chavez', 30)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (77, N'Hannah', N'Hughes', 27)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (79, N'Ella', N'Evans', 21)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (87, N'Adeline', N'King', 19)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (90, N'Sophie', N'Lee', 25)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (91, N'Mason', N'Baker', 28)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (94, N'Isaac', N'Alexander', 24)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (95, N'Grace', N'Morris', 20)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (104, N'Natalie', N'Campbell', 27)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (106, N'Anna', N'Green', 29)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (2, N'Jane', N'Smith', 34)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (3, N'Michael', N'Johnson', 45)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (5, N'Daniel', N'Williams', 36)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (6, N'Laura', N'Jones', 50)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (9, N'Matthew', N'García', 40)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (11, N'James', N'Rodriguez', 33)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (13, N'William', N'Lopez', 52)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (16, N'Ava', N'Anderson', 39)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (17, N'Alexander', N'Thomas', 31)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (19, N'Sebastian', N'Moore', 48)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (20, N'Charlotte', N'Jackson', 37)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (21, N'Benjamin', N'White', 56)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (23, N'Jack', N'Martin', 41)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (24, N'Chloe', N'Thompson', 32)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (25, N'Elijah', N'Garcia', 46)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (26, N'Lily', N'Martinez', 35)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (28, N'Harper', N'Lee', 50)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (29, N'Lucas', N'Walker', 60)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (30, N'Madison', N'Young', 38)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (31, N'Henry', N'Allen', 44)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (32, N'Zoe', N'King', 49)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (33, N'Jacob', N'Scott', 42)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (35, N'Nathan', N'Adams', 53)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (36, N'Grace', N'Baker', 31)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (37, N'Logan', N'Nelson', 55)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (38, N'Sophie', N'Carter', 59)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (41, N'Julian', N'Roberts', 40)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (42, N'Megan', N'González', 34)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (44, N'Scarlett', N'Cameron', 32)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (45, N'David', N'Jordan', 47)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (47, N'Leo', N'Ramirez', 36)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (48, N'Landon', N'Graham', 60)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (50, N'Isaac', N'Morris', 45)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (52, N'Max', N'Wood', 50)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (53, N'Anna', N'Martín', 38)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (56, N'Claire', N'Bailey', 41)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (57, N'Nolan', N'Rivera', 33)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (58, N'Evan', N'González', 52)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (60, N'Hunter', N'Parker', 51)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (62, N'Samuel', N'Howard', 53)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (64, N'Jack', N'Morris', 34)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (65, N'Madeline', N'Scott', 44)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (66, N'Aiden', N'Collins', 32)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (67, N'Mason', N'Torres', 48)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (68, N'Natalie', N'Brooks', 55)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (69, N'Carter', N'Sanders', 41)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (72, N'Amos', N'Fox', 45)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (74, N'Sophia', N'Roberts', 42)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (75, N'Elliot', N'Gonzalez', 50)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (76, N'Lucas', N'Mitchell', 39)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (78, N'Wyatt', N'Ford', 47)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (80, N'Christian', N'Hall', 38)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (81, N'Zoe', N'Nelson', 33)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (82, N'Jackson', N'Long', 60)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (83, N'Grace', N'Ward', 37)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (84, N'Liam', N'Wright', 32)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (85, N'Harley', N'Carter', 31)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (86, N'Brianna', N'Richards', 50)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (88, N'Oliver', N'Rogers', 45)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (89, N'Penelope', N'Walker', 49)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (92, N'Madison', N'Walker', 31)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (93, N'Amos', N'Shaw', 55)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (96, N'Ella', N'Barnes', 46)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (97, N'Ethan', N'Harrison', 43)
GO
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (98, N'Ruby', N'Scott', 37)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (99, N'Sebastian', N'Jenkins', 50)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (100, N'Ivy', N'Rodriguez', 34)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (101, N'Nathan', N'Hughes', 41)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (102, N'Addison', N'Black', 53)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (103, N'Mason', N'Foster', 32)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (105, N'Oliver', N'Hayes', 42)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (107, N'Jack', N'Wood', 48)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (108, N'Charlotte', N'Perry', 31)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (122, N'Betty', N'King', 60)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (149, N'Alice', N'Davis', 60)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (109, N'James', N'Jackson', 61)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (110, N'Mary', N'Moore', 62)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (111, N'Robert', N'Taylor', 65)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (112, N'Linda', N'Anderson', 67)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (113, N'David', N'Thomas', 70)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (114, N'Helen', N'Martinez', 72)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (115, N'Charles', N'Hernández', 75)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (116, N'Patricia', N'Lopez', 63)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (117, N'Michael', N'Clark', 64)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (118, N'Barbara', N'Lewis', 68)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (119, N'Joseph', N'Walker', 66)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (120, N'Nancy', N'Scott', 69)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (121, N'Thomas', N'Young', 74)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (123, N'William', N'Wright', 76)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (124, N'Betty', N'Adams', 77)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (125, N'Gary', N'Baker', 80)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (126, N'Samantha', N'Green', 78)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (127, N'Jack', N'Harris', 81)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (128, N'Barbara', N'Carter', 82)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (129, N'George', N'Hill', 63)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (130, N'Margaret', N'Nelson', 65)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (131, N'Susan', N'Mitchell', 79)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (132, N'Christopher', N'Perez', 84)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (133, N'Dorothy', N'Roberts', 85)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (134, N'Richard', N'Collins', 87)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (135, N'Dorothy', N'Murphy', 62)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (136, N'Edward', N'Cook', 66)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (137, N'James', N'Bailey', 80)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (138, N'Evelyn', N'González', 71)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (139, N'Ruth', N'Barnes', 83)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (140, N'Michael', N'Fisher', 76)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (141, N'Lillian', N'Simmons', 68)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (142, N'William', N'Morris', 77)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (143, N'Grace', N'Flores', 72)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (144, N'Martha', N'Garcia', 65)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (145, N'John', N'Scott', 66)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (146, N'Clara', N'Morris', 81)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (147, N'Frank', N'Miller', 70)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (148, N'Helen', N'Roberts', 69)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (150, N'Arthur', N'Wilson', 63)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (151, N'Lois', N'Hall', 74)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (152, N'Betty', N'Allen', 66)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (153, N'Frank', N'Green', 85)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (154, N'Margaret', N'King', 88)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (155, N'Raymond', N'Wright', 82)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (156, N'Beatrice', N'Parker', 73)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (157, N'Louis', N'Evans', 89)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (158, N'Shirley', N'Rodriguez', 64)
INSERT [dbo].[persons_partitioned] ([id], [first_name], [last_name], [age]) VALUES (159, N'Harry', N'Graham', 90)
SET IDENTITY_INSERT [dbo].[persons_partitioned] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_name_age]    Script Date: 2024-12-10 13:15:35 ******/
CREATE NONCLUSTERED INDEX [idx_name_age] ON [dbo].[persons]
(
	[first_name] ASC,
	[age] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cars]  WITH CHECK ADD FOREIGN KEY([owner])
REFERENCES [dbo].[persons] ([id])
GO
USE [master]
GO
ALTER DATABASE [UppgiftDB] SET  READ_WRITE 
GO
