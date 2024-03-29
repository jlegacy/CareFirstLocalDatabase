USE [master]
GO
/****** Object:  Database [CareFirstLocalDatabase]    Script Date: 4/29/2014 12:54:11 PM ******/
CREATE DATABASE [CareFirstLocalDatabase] ON  PRIMARY 
( NAME = N'CareFirstLocalDatabase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\CareFirstLocalDatabase.mdf' , SIZE = 6144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CareFirstLocalDatabase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\CareFirstLocalDatabase_log.ldf' , SIZE = 2816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CareFirstLocalDatabase] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CareFirstLocalDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CareFirstLocalDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [CareFirstLocalDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CareFirstLocalDatabase] SET DB_CHAINING OFF 
GO
USE [CareFirstLocalDatabase]
GO
/****** Object:  StoredProcedure [dbo].[spDeleteAllCallData]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[spDeleteAllCallData]
	 
AS
BEGIN
	 
	SET NOCOUNT ON;

     DELETE FROM CALLS
	 DELETE FROM GLASCOW_COMA_SCALE
	 DELETE FROM CALL_PATIENT_VITAL_SIGNS
	 DELETE FROM PCS_Q1_Q2
	 DELETE FROM PCS_Q3 
	 DELETE FROM PCS_SIGNATURES
	 DELETE FROM  CALL_PATIENT_SIGNATURES

END

GO
/****** Object:  StoredProcedure [dbo].[spDeleteCallPatientVitalSigns]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[spDeleteCallPatientVitalSigns]
	@CALL_ID int
AS
BEGIN
	 
	SET NOCOUNT ON;
	DELETE FROM CALL_PATIENT_VITAL_SIGNS WHERE CALL_ID = @CALL_ID
     
END

GO
/****** Object:  StoredProcedure [dbo].[spDeletePCSQ3ByCallId]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		 
-- Create date:  
-- Description:	 
-- =============================================
CREATE PROCEDURE [dbo].[spDeletePCSQ3ByCallId]
			@CALL_ID int
AS
BEGIN

	SET NOCOUNT ON;

	DELETE FROM PCS_Q3 WHERE CALL_ID = @CALL_ID
    
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertCall]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thomas	
-- Create date: 2014-03-28
-- Description:	Inserts into Calls table
-- =============================================
CREATE PROCEDURE [dbo].[spInsertCall]
		   @CALL_ID int,
		   @SSN int, 
           @DATE nvarchar (50), 
           @VEHICLE_NUMBER  nvarchar (50),  
		   @CREWMEMBER  nvarchar (50),   
           @CALL_LOCATION   nvarchar (100), 
           @DESTINATION_LOCATION  nvarchar (100), 
           @EMERGENCY nvarchar (50),  
           @TRANSPORT_TO  nvarchar (50),
           @CALL_OUTCOME  nvarchar (50),
           @CAUSE_OF_INCIDENT  nvarchar (50),
           @FACILITY_NAME  nvarchar (200),
           @FACILITY_ADDRESS  nvarchar (200),
		   @FACILITY_CITY  nvarchar (200),
		   @FACILITY_STATE  nvarchar (200),
		   @FACILITY_ZIP  nvarchar (200),
           @TIME_AT_PATIENT  nvarchar(50),
           @DEPARTURE  nvarchar(50),
           @ARRIVAL  nvarchar(50),
           @CALL_COMPLETE  nvarchar(50),
           @BEGIN_MILAGE   nvarchar (50),
           @ENDING_MILAGE  nvarchar (50),
           @TOTAL_MILAGE   nvarchar (50),
           @REASON_FOR_TRANSPORT  nvarchar (200),
           @TRANSPORT_SUMMARY  nvarchar (200),
		   @AUTHORIZED_SIGNATURE varbinary (MAX)

	 
AS
BEGIN
	 
	SET NOCOUNT ON;
INSERT INTO [dbo].[CALLS]
           ( [CALL_ID] ,[SSN]
           ,[DATE]
           ,[VEHICLE_NUMBER]
		   ,[CREWMEMBER]
           ,[CALL_LOCATION]
           ,[DESTINATION_LOCATION]
           ,[EMERGENCY]
           ,[TRANSPORT_TO]
           ,[CALL_OUTCOME]
           ,[CAUSE_OF_INCIDENT]
           ,[FACILITY_NAME]
           ,[FACILITY_ADDRESS]
		   ,FACILITY_CITY  
		   ,FACILITY_STATE  
		   ,FACILITY_ZIP   
           ,[TIME_AT_PATIENT]
           ,[DEPARTURE]
           ,[ARRIVAL]
           ,[CALL_COMPLETE]
           ,[BEGIN_MILAGE]
           ,[ENDING_MILAGE]
           ,[TOTAL_MILAGE]
           ,[REASON_FOR_TRANSPORT]
           ,[TRANSPORT_SUMMARY]
		   ,[AUTHORIZED_SIGNATURE]
		   )
           
     VALUES

		  (@CALL_ID  ,
		   @SSN  , 
           @DATE  , 
           @VEHICLE_NUMBER  , 
		    @CREWMEMBER  ,     
           @CALL_LOCATION  , 
           @DESTINATION_LOCATION  , 
           @EMERGENCY  ,  
           @TRANSPORT_TO   ,
           @CALL_OUTCOME  ,
           @CAUSE_OF_INCIDENT  ,
           @FACILITY_NAME  ,
           @FACILITY_ADDRESS ,
		     @FACILITY_CITY  ,
		   @FACILITY_STATE   ,
		   @FACILITY_ZIP  ,
           @TIME_AT_PATIENT  ,
           @DEPARTURE  ,
           @ARRIVAL ,
           @CALL_COMPLETE   ,
           @BEGIN_MILAGE  ,
           @ENDING_MILAGE  ,
           @TOTAL_MILAGE  ,
           @REASON_FOR_TRANSPORT ,
           @TRANSPORT_SUMMARY ,
		   @AUTHORIZED_SIGNATURE
            )
    
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertCallPatientSignatures]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thomas	
-- Create date: 2014-04-29
-- Description:	 inserts into call patient signatures
-- =============================================
CREATE PROCEDURE [dbo].[spInsertCallPatientSignatures]
		    @CALL_ID int
           ,@SIGNATURE_DATE datetime
           ,@PATIENT_SIGNATURE varbinary(max)
           ,@WITNESS_SIGNATURE varbinary(max)
           ,@WITNESS_PRINTED_NAME varchar(max)
           ,@REASON_PATIENT_UNABLE_TO_SIGN varchar(max)
           ,@AUTHORIZED_REPRESENTITIVE varchar(max)
           ,@REPRESENTITIVE_SIGNATURE varbinary(max)
           ,@REPRESENTITIVE_PRINTED_NAME varchar(max)
           ,@REPRESENTITIVE_ADDRESS varchar(max)
           ,@CREW_REASON_PATIENT_INCAPABLE varchar(max)
           ,@CREW_SIGNATURE varbinary(max)
           ,@CREW_PRINTED_NAME varchar(max)
           ,@REC_FAC_REP_SIGNATURE varbinary(max)
           ,@REC_FAC_REP_PRINTED_NAME varchar(max)
AS
BEGIN

	SET NOCOUNT ON;
INSERT INTO [dbo].[CALL_PATIENT_SIGNATURES]
           ([CALL_ID]
           ,[SIGNATURE_DATE]
           ,[PATIENT_SIGNATURE]
           ,[WITNESS_SIGNATURE]
           ,[WITNESS_PRINTED_NAME]
           ,[REASON_PATIENT_UNABLE_TO_SIGN]
           ,[AUTHORIZED_REPRESENTITIVE]
           ,[REPRESENTITIVE_SIGNATURE]
           ,[REPRESENTITIVE_PRINTED_NAME]
           ,[REPRESENTITIVE_ADDRESS]
           ,[CREW_REASON_PATIENT_INCAPABLE]
           ,[CREW_SIGNATURE]
           ,[CREW_PRINTED_NAME]
           ,[REC_FAC_REP_SIGNATURE]
           ,[REC_FAC_REP_PRINTED_NAME])
     VALUES
           (@CALL_ID 
           ,@SIGNATURE_DATE 
           ,@PATIENT_SIGNATURE 
           ,@WITNESS_SIGNATURE 
           ,@WITNESS_PRINTED_NAME 
           ,@REASON_PATIENT_UNABLE_TO_SIGN 
           ,@AUTHORIZED_REPRESENTITIVE 
           ,@REPRESENTITIVE_SIGNATURE 
           ,@REPRESENTITIVE_PRINTED_NAME 
           ,@REPRESENTITIVE_ADDRESS 
           ,@CREW_REASON_PATIENT_INCAPABLE 
           ,@CREW_SIGNATURE 
           ,@CREW_PRINTED_NAME 
           ,@REC_FAC_REP_SIGNATURE 
           ,@REC_FAC_REP_PRINTED_NAME )
  
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertCallPatientVitalSigns]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thomas	
-- Create date: 2014-03-28
-- Description:	Insert into 
-- =============================================
CREATE PROCEDURE  [dbo].[spInsertCallPatientVitalSigns]

	        @CALL_ID int,
            @TIME nvarchar(50),
            @BP_SYSTOLIC int,
            @BP_DIASTOLIC int,
            @PULSE int, 
            @RESPIRATION int,
            @O2_SATURATION int 
           
AS
 BEGIN
	 
	SET NOCOUNT ON;
	INSERT INTO [dbo].[CALL_PATIENT_VITAL_SIGNS]
           ([CALL_ID]
           ,[TIME]
           ,[BP_SYSTOLIC]
           ,[BP_DIASTOLIC]
           ,[PULSE]
           ,[RESPIRATION]
           ,[O2_SATURATION]
           ,[LAST_CHANGE_DATE]
           )
     VALUES
	 (
	       @CALL_ID,
            @TIME,
            @BP_SYSTOLIC,
            @BP_DIASTOLIC,
            @PULSE,
            @RESPIRATION,
            @O2_SATURATION,
           getdate())
         
         
  
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertGlascowComaScale]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thomas	
-- Create date: 2014-03-28
-- Description:	Insert into glascow coma scale
-- =============================================
CREATE PROCEDURE [dbo].[spInsertGlascowComaScale]

	       @CALL_ID int,  
           @EYES nvarchar(50), 
           @VERBAL nvarchar(50), 
           @MOTOR nvarchar(50) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO [dbo].[GLASCOW_COMA_SCALE]
           ([CALL_ID]
           ,[EYES]
           ,[VERBAL]
           ,[MOTOR]
           ,[LAST_CHANGE_DATE])
          
     VALUES
	 (
           @CALL_ID,  
           @EYES, 
           @VERBAL, 
           @MOTOR ,
            getdate() )
    
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertPatient]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thomas	
-- Create date: 2014-03-31
-- Description:	insert into patients
-- =============================================
CREATE PROCEDURE [dbo].[spInsertPatient]
	        @SSN int, 
            @LAST_NAME nvarchar(max),  
            @FIRST_NAME nvarchar(max),  
            @MIDDLE_NAME nvarchar(max), 
            @PHONE nvarchar(max),  
            @ADDRESS_1 nvarchar(max),  
            @ADDRESS_2 nvarchar(max), 
            @CITY nvarchar(max), 
            @STATE nvarchar(max), 
            @ZIP  nvarchar(max), 
			@CONTACT_PERSON nvarchar(max),  
            @CONTACT_PHONE nvarchar (max), 
            @CONTACT_RELATION nvarchar(max), 
            @DOB date,  
            @AGE int,  
            @RACE nvarchar(max), 
            @SEX nvarchar(max), 
            @MEDICARE nvarchar(max), 
            @MEDICAID nvarchar(max), 
            @OTHER nvarchar(max),  
            @NUMBER nvarchar(max), 
            @HISTORY nvarchar(max)  
         
AS
BEGIN
	 
	SET NOCOUNT ON;
	INSERT INTO [dbo].[PATIENTS]
           ([SSN]
           ,[LAST_NAME]
           ,[FIRST_NAME]
           ,[MIDDLE_NAME]
           ,[PHONE]
           ,[ADDRESS_1]
           ,[ADDRESS_2]
           ,[CITY]
           ,[STATE]
           ,[ZIP]
           ,[CONTACT_PERSON]
           ,[CONTACT_PHONE]
           ,[CONTACT_RELATION]
           ,[DOB]
           ,[AGE]
           ,[RACE]
           ,[SEX]
           ,[MEDICARE]
           ,[MEDICAID]
           ,[OTHER]
           ,[NUMBER]
           ,[HISTORY]
           ,[LAST_CHANGE_DATE])
        
     VALUES
           (@SSN, 
            @LAST_NAME,  
            @FIRST_NAME, 
            @MIDDLE_NAME, 
            @PHONE,  
            @ADDRESS_1,  
            @ADDRESS_2, 
            @CITY, 
            @STATE, 
            @ZIP,  
            @CONTACT_PERSON,  
            @CONTACT_PHONE,  
            @CONTACT_RELATION, 
            @DOB,  
            @AGE,  
            @RACE, 
            @SEX, 
            @MEDICARE, 
            @MEDICAID, 
            @OTHER,  
            @NUMBER, 
            @HISTORY,  
            getdate() 
             )
    
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertPCSQ1Q2]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thomas	
-- Create date: 2012=04=03
-- Description:	insert pcs_q1_q2
-- =============================================
CREATE PROCEDURE [dbo].[spInsertPCSQ1Q2]
	    @CALL_ID INT,
		@PCS_Q1 NVARCHAR,
		@PCS_Q2 NVARCHAR
AS
BEGIN
	 INSERT INTO [dbo].[PCS_Q1_Q2]
           ([CALL_ID] 
           ,[Q1]
           ,[Q2]
           ,[LAST_CHANGE_DATE])
           
     VALUES
        
	 (  @CALL_ID ,
		@PCS_Q1 ,
		@PCS_Q2, getdate())

    
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertPCSQ3]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thomas
-- Create date: 2014-03-28
-- Description:  inset into pcs_q3
-- =============================================
CREATE PROCEDURE [dbo].[spInsertPCSQ3]
	         @CALL_ID  int, 
			 @Q3_NUMBER int,
             @Q3_DESC  nvarchar(200) 
             
AS
BEGIN
 
	SET NOCOUNT ON;
	INSERT INTO [dbo].[PCS_Q3]
           ([CALL_ID]
		   ,[Q3_NUMBER]
           ,[Q3_DESC]
           ,[LAST_CHANGE_DATE]
                )
     VALUES
           ( @CALL_ID 
		   ,@Q3_NUMBER 
           , @Q3_DESC 
           , getdate()
            )
    
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertPCSSignatures]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thomas
-- Create date: 2014-04-03
-- Description:	insert into pcs_signatures
-- =============================================
CREATE PROCEDURE [dbo].[spInsertPCSSignatures]
	        @CALL_ID  int, 
            @PHYSICIAN_SIGNATURE  varbinary(max), 
			@PHYSICIAN_PRINTED_NAME NVARCHAR(MAX),
            @MEDICAL_STAFF_SIGNATURE varbinary(max),
			@MEDICAL_STAFF_PRINTED_NAME NVARCHAR(MAX), 
			@MEDICAL_STAFF_CREDENTIAL NVARCHAR (50)
AS
BEGIN
	 
	SET NOCOUNT ON;

     INSERT INTO [dbo].[PCS_SIGNATURES]
           ([CALL_ID]
           ,[PHYSICIAN_SIGNATURE]
		   ,PHYSICIAN_PRINTED_NAME
           ,[MEDICAL_STAFF_SIGNATURE]
		   ,MEDICAL_STAFF_PRINTED_NAME
		   ,[MEDICAL_STAFF_CREDENTIAL]
           ,[LAST_CHANGE_DATE] )
           
     VALUES
	        (@CALL_ID   , 
            @PHYSICIAN_SIGNATURE ,
			@PHYSICIAN_PRINTED_NAME, 
            @MEDICAL_STAFF_SIGNATURE  ,
			@MEDICAL_STAFF_PRINTED_NAME,
			@MEDICAL_STAFF_CREDENTIAL ,
			getdate())
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertTestSignature]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George
-- Create date: 2014-04-07
-- Description:	test store signature
-- =============================================
CREATE PROCEDURE [dbo].[spInsertTestSignature]
			@testSignature varbinary(max)
AS
BEGIN
	 
	SET NOCOUNT ON;
	INSERT INTO [dbo].[TESTSIGNATURE]
           ([SIGNATURE])
     VALUES
           (@testSignature)
   
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateCall]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thoms	
-- Create date: 2014-04-03
-- Description:	update Calls
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateCall]
		   @CALL_ID int,
		   @SSN int, 
           @DATE nvarchar (50), 
           @VEHICLE_NUMBER  nvarchar (50), 
	       @CREWMEMBER  nvarchar (50), 
	       @CALL_LOCATION   nvarchar (100), 
           @DESTINATION_LOCATION  nvarchar (100), 
           @EMERGENCY nvarchar (50),  
           @TRANSPORT_TO  nvarchar (50),
           @CALL_OUTCOME  nvarchar (50),
           @CAUSE_OF_INCIDENT  nvarchar (50),
           @FACILITY_NAME  nvarchar (200),
           @FACILITY_ADDRESS  nvarchar (200),
		   @FACILITY_CITY  nvarchar (200),
		   @FACILITY_STATE  nvarchar (200),
		   @FACILITY_ZIP  nvarchar (200),
           @TIME_AT_PATIENT  nvarchar(50),
           @DEPARTURE  nvarchar(50),
           @ARRIVAL  nvarchar(50),
           @CALL_COMPLETE  nvarchar(50),
           @BEGIN_MILAGE  nvarchar(50),
           @ENDING_MILAGE  nvarchar(50),
           @TOTAL_MILAGE  nvarchar(50),
           @REASON_FOR_TRANSPORT  nvarchar (200),
           @TRANSPORT_SUMMARY  nvarchar (200) ,
		   @AUTHORIZED_SIGNATURE varbinary(max)
        
AS
BEGIN
	SET NOCOUNT ON;
UPDATE [dbo].[CALLS]
     SET 
       [SSN] = @SSN 
      ,[DATE] = @DATE 
      ,[VEHICLE_NUMBER] = @VEHICLE_NUMBER 
      ,[CREWMEMBER] = @CREWMEMBER 
      ,[CALL_LOCATION] = @CALL_LOCATION 
      ,[DESTINATION_LOCATION] = @DESTINATION_LOCATION 
      ,[EMERGENCY] = @EMERGENCY 
      ,[TRANSPORT_TO] = @TRANSPORT_TO 
      ,[CALL_OUTCOME] = @CALL_OUTCOME 
      ,[CAUSE_OF_INCIDENT] = @CAUSE_OF_INCIDENT 
      ,[FACILITY_NAME] = @FACILITY_NAME 
      ,[FACILITY_ADDRESS] = @FACILITY_ADDRESS 
	  ,		  FACILITY_CITY  = @FACILITY_CITY
		  ,FACILITY_STATE  = @FACILITY_STATE
		  ,FACILITY_ZIP  = @FACILITY_ZIP
      ,[TIME_AT_PATIENT] = @TIME_AT_PATIENT 
      ,[DEPARTURE] = @DEPARTURE 
      ,[ARRIVAL] = @ARRIVAL 
      ,[CALL_COMPLETE] = @CALL_COMPLETE 
      ,[BEGIN_MILAGE] = @BEGIN_MILAGE 
      ,[ENDING_MILAGE] = @ENDING_MILAGE 
      ,[TOTAL_MILAGE] = @TOTAL_MILAGE 
      ,[REASON_FOR_TRANSPORT] = @REASON_FOR_TRANSPORT 
      ,[TRANSPORT_SUMMARY] = @TRANSPORT_SUMMARY 
	  ,AUTHORIZED_SIGNATURE = @AUTHORIZED_SIGNATURE
      ,[LAST_CHANGE_DATE] = getdate()

      WHERE CALL_ID = @CALL_ID 
    
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateCallPatientSignatures]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thomas	
-- Create date: 2014-04-29
-- Description:	 updates call patient signatures
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateCallPatientSignatures]
			 @CALL_ID int
           ,@SIGNATURE_DATE datetime
           ,@PATIENT_SIGNATURE varbinary(max)
           ,@WITNESS_SIGNATURE varbinary(max)
           ,@WITNESS_PRINTED_NAME varchar(max)
           ,@REASON_PATIENT_UNABLE_TO_SIGN varchar(max)
           ,@AUTHORIZED_REPRESENTITIVE varchar(max)
           ,@REPRESENTITIVE_SIGNATURE varbinary(max)
           ,@REPRESENTITIVE_PRINTED_NAME varchar(max)
           ,@REPRESENTITIVE_ADDRESS varchar(max)
           ,@CREW_REASON_PATIENT_INCAPABLE varchar(max)
           ,@CREW_SIGNATURE varbinary(max)
           ,@CREW_PRINTED_NAME varchar(max)
           ,@REC_FAC_REP_SIGNATURE varbinary(max)
           ,@REC_FAC_REP_PRINTED_NAME varchar(max)
AS
 
BEGIN
	
	SET NOCOUNT ON;
	UPDATE [dbo].[CALL_PATIENT_SIGNATURES]
   SET 
      [SIGNATURE_DATE] = @SIGNATURE_DATE 
      ,[PATIENT_SIGNATURE] = @PATIENT_SIGNATURE 
      ,[WITNESS_SIGNATURE] = @WITNESS_SIGNATURE 
      ,[WITNESS_PRINTED_NAME] = @WITNESS_PRINTED_NAME 
      ,[REASON_PATIENT_UNABLE_TO_SIGN] = @REASON_PATIENT_UNABLE_TO_SIGN 
      ,[AUTHORIZED_REPRESENTITIVE] = @AUTHORIZED_REPRESENTITIVE 
      ,[REPRESENTITIVE_SIGNATURE] = @REPRESENTITIVE_SIGNATURE 
      ,[REPRESENTITIVE_PRINTED_NAME] = @REPRESENTITIVE_PRINTED_NAME 
      ,[REPRESENTITIVE_ADDRESS] = @REPRESENTITIVE_ADDRESS 
      ,[CREW_REASON_PATIENT_INCAPABLE] = @CREW_REASON_PATIENT_INCAPABLE 
      ,[CREW_SIGNATURE] = @CREW_SIGNATURE 
      ,[CREW_PRINTED_NAME] = @CREW_PRINTED_NAME 
      ,[REC_FAC_REP_SIGNATURE] = @REC_FAC_REP_SIGNATURE 
      ,[REC_FAC_REP_PRINTED_NAME] = @REC_FAC_REP_PRINTED_NAME 
 WHERE CALL_ID = @CALL_ID
    
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateCallPatientVitalSigns]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thomas
-- Create date: 2014-04-04
-- Description:	update call patient vital signs
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateCallPatientVitalSigns]
	     @CALL_ID int,
            @TIME nvarchar(50),
            @BP_SYSTOLIC int,
            @BP_DIASTOLIC int,
            @PULSE int, 
            @RESPIRATION int,
            @O2_SATURATION int  
AS
BEGIN
	 
	SET NOCOUNT ON;
	UPDATE [dbo].[CALL_PATIENT_VITAL_SIGNS]
   SET  
       [TIME] = @TIME 
      ,[BP_SYSTOLIC] = @BP_SYSTOLIC 
      ,[BP_DIASTOLIC] = @BP_DIASTOLIC 
      ,[PULSE] = @PULSE
      ,[RESPIRATION] = @RESPIRATION 
      ,[O2_SATURATION] = @O2_SATURATION 
      ,[LAST_CHANGE_DATE] = getdate()
      
 WHERE CALL_ID = @CALL_ID AND TIME = @TIME
     
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateGlascowComaScale]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thomas
-- Create date: 2014-04-04
-- Description:	update glascow coma scale
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateGlascowComaScale]

	       @CALL_ID int,  
           @EYES nvarchar(50), 
           @VERBAL nvarchar(50), 
           @MOTOR nvarchar(50) 
AS
BEGIN
 
	SET NOCOUNT ON;
	UPDATE [dbo].[GLASCOW_COMA_SCALE]
   SET 
       [EYES] = @EYES 
      ,[VERBAL] = @VERBAL 
      ,[MOTOR] = @MOTOR 
      ,LAST_CHANGE_DATE = getdate()
    WHERE CALL_ID = @CALL_ID
   
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdatePatient]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thomas	
-- Create date: 2014-04-09
-- Description:	update patient
-- =============================================
CREATE PROCEDURE [dbo].[spUpdatePatient]
		    @SSN int, 
            @LAST_NAME nvarchar(max),  
            @FIRST_NAME nvarchar(max),  
            @MIDDLE_NAME nvarchar(max), 
            @PHONE nvarchar(max),  
            @ADDRESS_1 nvarchar(max),  
            @ADDRESS_2 nvarchar(max), 
            @CITY nvarchar(max), 
            @STATE nvarchar(max), 
            @ZIP  nvarchar(max), 
			@CONTACT_PERSON nvarchar(max),  
            @CONTACT_PHONE nvarchar (max), 
            @CONTACT_RELATION nvarchar(max), 
            @DOB date,  
            @AGE int,  
            @RACE nvarchar(max), 
            @SEX nvarchar(max), 
            @MEDICARE nvarchar(max), 
            @MEDICAID nvarchar(max), 
            @OTHER nvarchar(max),  
            @NUMBER nvarchar(max), 
            @HISTORY nvarchar(max)  
AS
BEGIN
	 
	SET NOCOUNT ON;
	UPDATE [dbo].[PATIENTS]
   SET 
       [LAST_NAME] = @LAST_NAME 
      ,[FIRST_NAME] = @FIRST_NAME 
      ,[MIDDLE_NAME] = @MIDDLE_NAME 
      ,[PHONE] = @PHONE 
      ,[ADDRESS_1] = @ADDRESS_1 
      ,[ADDRESS_2] = @ADDRESS_2 
      ,[CITY] = @CITY 
      ,[STATE] = @STATE 
      ,[ZIP] = @ZIP 
      ,[CONTACT_PERSON] = @CONTACT_PERSON 
      ,[CONTACT_PHONE] = @CONTACT_PHONE 
      ,[CONTACT_RELATION] = @CONTACT_RELATION 
      ,[DOB] = @DOB 
      ,[AGE] = @AGE 
      ,[RACE] = @RACE 
      ,[SEX] = @SEX 
      ,[MEDICARE] = @MEDICARE 
      ,[MEDICAID] = @MEDICAID 
      ,[OTHER] = @OTHER 
      ,[NUMBER] = @NUMBER 
      ,[HISTORY] = @HISTORY 
       , LAST_CHANGE_DATE = getdate()
   WHERE SSN = @SSN
    
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdatePCSQ1Q2]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George H. Thomas		
-- Create date: 2014=04-04
-- Description:	update pcs q1 q2
-- =============================================
CREATE PROCEDURE [dbo].[spUpdatePCSQ1Q2]
	    @CALL_ID INT,
		@PCS_Q1 NVARCHAR,
		@PCS_Q2 NVARCHAR
AS
BEGIN
	
	SET NOCOUNT ON;
	UPDATE [dbo].[PCS_Q1_Q2]
   SET  
      [Q1] = @PCS_Q1 
      ,[Q2] = @PCS_Q2 
      ,[LAST_CHANGE_DATE] =  getdate()
       
 WHERE CALL_ID = @CALL_ID

END

GO
/****** Object:  StoredProcedure [dbo].[spUpdatePCSSignatures]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		GHT
-- Create date: 2014-04-21
-- Description:	update pcs signatures
-- =============================================
CREATE PROCEDURE [dbo].[spUpdatePCSSignatures]
	        @CALL_ID  int, 
            @PHYSICIAN_SIGNATURE  varbinary(max), 
			@PHYSICIAN_PRINTED_NAME NVARCHAR(MAX),
            @MEDICAL_STAFF_SIGNATURE varbinary(max),  
			@MEDICAL_STAFF_PRINTED_NAME NVARCHAR(MAX),
			@MEDICAL_STAFF_CREDENTIAL NVARCHAR (50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [dbo].[PCS_SIGNATURES]
   SET  
      [PHYSICIAN_SIGNATURE] = @PHYSICIAN_SIGNATURE
	  ,PHYSICIAN_PRINTED_NAME = @PHYSICIAN_PRINTED_NAME
      ,[MEDICAL_STAFF_SIGNATURE] = @MEDICAL_STAFF_SIGNATURE
	  ,[MEDICAL_STAFF_PRINTED_NAME] = @MEDICAL_STAFF_PRINTED_NAME
	  ,[MEDICAL_STAFF_CREDENTIAL] = @MEDICAL_STAFF_CREDENTIAL
      ,[LAST_CHANGE_DATE] = getdate()
      
 WHERE CALL_ID = @CALL_ID
	 
END

GO
/****** Object:  Table [dbo].[CALL_PATIENT_SIGNATURES]    Script Date: 4/29/2014 12:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CALL_PATIENT_SIGNATURES](
	[CALL_ID] [int] NOT NULL,
	[SIGNATURE_DATE] [datetime] NULL,
	[PATIENT_SIGNATURE] [varbinary](max) NULL,
	[WITNESS_SIGNATURE] [varbinary](max) NULL,
	[WITNESS_PRINTED_NAME] [nvarchar](max) NULL,
	[REASON_PATIENT_UNABLE_TO_SIGN] [nvarchar](max) NULL,
	[AUTHORIZED_REPRESENTITIVE] [nvarchar](max) NULL,
	[REPRESENTITIVE_SIGNATURE] [varbinary](max) NULL,
	[REPRESENTITIVE_PRINTED_NAME] [nvarchar](max) NULL,
	[REPRESENTITIVE_ADDRESS] [nvarchar](max) NULL,
	[CREW_REASON_PATIENT_INCAPABLE] [nvarchar](max) NULL,
	[CREW_SIGNATURE] [varbinary](max) NULL,
	[CREW_PRINTED_NAME] [nvarchar](max) NULL,
	[REC_FAC_REP_SIGNATURE] [varbinary](max) NULL,
	[REC_FAC_REP_PRINTED_NAME] [nvarchar](max) NULL,
 CONSTRAINT [PK_CALL_PATIENT_SIGNATURES] PRIMARY KEY CLUSTERED 
(
	[CALL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CALL_PATIENT_VITAL_SIGNS]    Script Date: 4/29/2014 12:54:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CALL_PATIENT_VITAL_SIGNS](
	[CALL_ID] [int] NOT NULL,
	[TIME] [nvarchar](50) NOT NULL,
	[BP_SYSTOLIC] [int] NULL,
	[BP_DIASTOLIC] [int] NULL,
	[PULSE] [int] NULL,
	[RESPIRATION] [int] NULL,
	[O2_SATURATION] [int] NULL,
	[LAST_CHANGE_DATE] [datetime] NULL,
	[LAST_CHANGE_WHO] [nvarchar](max) NULL,
 CONSTRAINT [PK_CALL_PATIENT_VITAL_SIGNS] PRIMARY KEY CLUSTERED 
(
	[CALL_ID] ASC,
	[TIME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CALLS]    Script Date: 4/29/2014 12:54:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CALLS](
	[CALL_ID] [int] NOT NULL,
	[SSN] [int] NULL,
	[DATE] [date] NULL,
	[VEHICLE_NUMBER] [nvarchar](max) NULL,
	[CREWMEMBER] [nvarchar](max) NULL,
	[CALL_LOCATION] [nvarchar](max) NULL,
	[DESTINATION_LOCATION] [nvarchar](max) NULL,
	[EMERGENCY] [nvarchar](max) NULL,
	[TRANSPORT_TO] [nvarchar](max) NULL,
	[CALL_OUTCOME] [nvarchar](max) NULL,
	[CAUSE_OF_INCIDENT] [nvarchar](max) NULL,
	[FACILITY_NAME] [nvarchar](max) NULL,
	[FACILITY_ADDRESS] [nvarchar](max) NULL,
	[FACILITY_CITY] [nvarchar](max) NULL,
	[FACILITY_STATE] [nvarchar](max) NULL,
	[FACILITY_ZIP] [nvarchar](max) NULL,
	[TIME_AT_PATIENT] [nvarchar](max) NULL,
	[DEPARTURE] [nvarchar](max) NULL,
	[ARRIVAL] [nvarchar](max) NULL,
	[CALL_COMPLETE] [nvarchar](max) NULL,
	[BEGIN_MILAGE] [nvarchar](max) NULL,
	[ENDING_MILAGE] [nvarchar](max) NULL,
	[TOTAL_MILAGE] [nvarchar](max) NULL,
	[REASON_FOR_TRANSPORT] [nvarchar](max) NULL,
	[TRANSPORT_SUMMARY] [nvarchar](max) NULL,
	[LAST_CHANGE_DATE] [datetime] NULL,
	[LAST_CHANGE_WHO] [nvarchar](max) NULL,
	[AUTHORIZED_SIGNATURE] [varbinary](max) NULL,
 CONSTRAINT [PK_CALLS] PRIMARY KEY CLUSTERED 
(
	[CALL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GLASCOW_COMA_SCALE]    Script Date: 4/29/2014 12:54:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GLASCOW_COMA_SCALE](
	[CALL_ID] [int] NOT NULL,
	[EYES] [nvarchar](max) NULL,
	[VERBAL] [nvarchar](max) NULL,
	[MOTOR] [nvarchar](max) NULL,
	[LAST_CHANGE_DATE] [datetime] NULL,
	[LAST_CHANGE_WHO] [nvarchar](max) NULL,
 CONSTRAINT [PK_GLASCOW_COMA_SCALE] PRIMARY KEY CLUSTERED 
(
	[CALL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PATIENT_SIGNATURES]    Script Date: 4/29/2014 12:54:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PATIENT_SIGNATURES](
	[SSN] [int] NOT NULL,
	[SIGNATURE_DATE] [datetime] NULL,
	[PATIENT_SIGNATURE] [varbinary](max) NULL,
	[WITNESS_SIGNATURE] [varbinary](max) NULL,
	[WITNESS_PRINTED_NAME] [nvarchar](max) NULL,
	[REASON_PATIENT_UNABLE_TO_SIGN] [nvarchar](max) NULL,
	[AUTHORIZED_REPRESENTITIVE] [nvarchar](max) NULL,
	[REPRESENTITIVE_SIGNATURE] [varbinary](max) NULL,
	[REPRESENTITIVE_PRINTED_NAME] [nvarchar](max) NULL,
	[REPRESENTITIVE_ADDRESS] [nvarchar](max) NULL,
	[CREW_REASON_PATIENT_INCAPABLE] [nvarchar](max) NULL,
	[CREW_SIGNATURE] [varbinary](max) NULL,
	[CREW_PRINTED_NAME] [nvarchar](max) NULL,
	[REC_FAC_REP_SIGNATURE] [varbinary](max) NULL,
	[REC_FAC_REP_PRINTED_NAME] [nvarchar](max) NULL,
 CONSTRAINT [PK_PATIENT_SIGNATURES] PRIMARY KEY CLUSTERED 
(
	[SSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PATIENTS]    Script Date: 4/29/2014 12:54:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PATIENTS](
	[SSN] [int] NOT NULL,
	[LAST_NAME] [nvarchar](max) NULL,
	[FIRST_NAME] [nvarchar](max) NULL,
	[MIDDLE_NAME] [nvarchar](max) NULL,
	[PHONE] [nvarchar](max) NULL,
	[ADDRESS_1] [nvarchar](max) NULL,
	[ADDRESS_2] [nvarchar](max) NULL,
	[CITY] [nvarchar](max) NULL,
	[STATE] [nvarchar](max) NULL,
	[ZIP] [nvarchar](max) NULL,
	[CONTACT_PERSON] [nvarchar](max) NULL,
	[CONTACT_PHONE] [nvarchar](max) NULL,
	[CONTACT_RELATION] [nvarchar](max) NULL,
	[DOB] [date] NULL,
	[AGE] [int] NULL,
	[RACE] [nvarchar](max) NULL,
	[SEX] [nvarchar](max) NULL,
	[MEDICARE] [nvarchar](max) NULL,
	[MEDICAID] [nvarchar](max) NULL,
	[OTHER] [nvarchar](max) NULL,
	[NUMBER] [nvarchar](max) NULL,
	[HISTORY] [nvarchar](max) NULL,
	[LAST_CHANGE_DATE] [datetime] NULL,
	[LAST_CHANGE_WHO] [nvarchar](max) NULL,
 CONSTRAINT [PK_PATIENTS] PRIMARY KEY CLUSTERED 
(
	[SSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PCS_Q1_Q2]    Script Date: 4/29/2014 12:54:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCS_Q1_Q2](
	[CALL_ID] [int] NOT NULL,
	[PCS_FORM_REQUIRED] [nvarchar](1) NULL,
	[Q1] [nvarchar](1) NULL,
	[Q2] [nvarchar](1) NULL,
	[LAST_CHANGE_DATE] [datetime] NULL,
	[LAST_CHANGE_WHO] [nvarchar](max) NULL,
 CONSTRAINT [PK_PCS_Q1_Q2] PRIMARY KEY CLUSTERED 
(
	[CALL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PCS_Q3]    Script Date: 4/29/2014 12:54:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCS_Q3](
	[CALL_ID] [int] NOT NULL,
	[Q3_NUMBER] [int] NOT NULL,
	[Q3_DESC] [nvarchar](max) NOT NULL,
	[LAST_CHANGE_DATE] [datetime] NULL,
	[LAST_CHANGE_WHO] [nvarchar](max) NULL,
 CONSTRAINT [PK_PCS_Q3] PRIMARY KEY CLUSTERED 
(
	[CALL_ID] ASC,
	[Q3_NUMBER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PCS_SIGNATURES]    Script Date: 4/29/2014 12:54:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PCS_SIGNATURES](
	[CALL_ID] [int] NOT NULL,
	[PHYSICIAN_PRINTED_NAME] [nvarchar](max) NULL,
	[MEDICAL_STAFF_SIGNATURE] [varbinary](max) NULL,
	[MEDICAL_STAFF_PRINTED_NAME] [nvarchar](max) NULL,
	[MEDICAL_STAFF_CREDENTIAL] [nvarchar](50) NULL,
	[LAST_CHANGE_DATE] [datetime] NULL,
	[LAST_CHANGE_WHO] [nvarchar](max) NULL,
	[PHYSICIAN_SIGNATURE] [varbinary](max) NULL,
 CONSTRAINT [PK_PCS_SIGNATURES] PRIMARY KEY CLUSTERED 
(
	[CALL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TESTSIGNATURE]    Script Date: 4/29/2014 12:54:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TESTSIGNATURE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SIGNATURE] [varbinary](max) NULL,
 CONSTRAINT [PK_TESTSIGNATURE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[CALL_PATIENT_VITAL_SIGNS] ADD  CONSTRAINT [DF_CALL_PATIENT_VITAL_SIGNS_LAST_CHANGE_DATE]  DEFAULT (getdate()) FOR [LAST_CHANGE_DATE]
GO
ALTER TABLE [dbo].[CALLS] ADD  CONSTRAINT [DF_CALLS_LAST_CHANGE_DATE]  DEFAULT (getdate()) FOR [LAST_CHANGE_DATE]
GO
ALTER TABLE [dbo].[GLASCOW_COMA_SCALE] ADD  CONSTRAINT [DF_GLASCOW_COMA_SCALE_LAST_CHANGE_DATE]  DEFAULT (getdate()) FOR [LAST_CHANGE_DATE]
GO
ALTER TABLE [dbo].[PATIENTS] ADD  CONSTRAINT [DF_PATIENTS_LAST_CHANGE_DATE]  DEFAULT (getdate()) FOR [LAST_CHANGE_DATE]
GO
ALTER TABLE [dbo].[PCS_Q1_Q2] ADD  CONSTRAINT [DF_PCS_Q1_Q2_Q1]  DEFAULT ('N') FOR [Q1]
GO
ALTER TABLE [dbo].[PCS_Q1_Q2] ADD  CONSTRAINT [DF_PCS_Q1_Q2_Q2]  DEFAULT ('N') FOR [Q2]
GO
ALTER TABLE [dbo].[PCS_SIGNATURES] ADD  CONSTRAINT [DF_PCS_SIGNATURES_LAST_CHANGE_DATE]  DEFAULT (getdate()) FOR [LAST_CHANGE_DATE]
GO
USE [master]
GO
ALTER DATABASE [CareFirstLocalDatabase] SET  READ_WRITE 
GO
