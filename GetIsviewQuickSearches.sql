/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [QS_ID]
      ,[QSName]
      ,[Name]
      ,[ServerName]
      ,[SavedSimpleSearch]
  FROM [VCRReports].[dbo].[COLD_MyISView_QuickSearches]