USE [Tabi]
GO
/****** Object:  StoredProcedure [dbo].[FAQCategories_SelectAll]    Script Date: 4/2/2024 2:51:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[FAQCategories_SelectAll]

as
/*----Test Code----

Execute dbo.FAQCategories_SelectAll

*/

Begin

SELECT [Id]
      ,[Name]
  FROM [dbo].[FAQCategories]


End
GO
