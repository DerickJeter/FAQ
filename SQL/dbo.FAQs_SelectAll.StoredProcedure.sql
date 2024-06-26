USE [Tabi]
GO
/****** Object:  StoredProcedure [dbo].[FAQs_SelectAll]    Script Date: 4/2/2024 2:51:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author: Derick Jeter
-- Create date: 04/02/2024
-- Description: SelectAll procedure for FAQs
-- Code Reviewer: Keysis Gonzales

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note:

CREATE proc [dbo].[FAQs_SelectAll]


as
/*----Test Code----

Execute dbo.FAQs_SelectAll

*/


Begin

SELECT f.[Id]
      ,[Question]
      ,[Answer]
      ,fc.Id as CategoryId
	  ,fc.Name as CategoryName
      ,[SortOrder]
      ,[DateCreated]
      ,[DateModified]
      ,dbo.fn_GetUserJSON(CreatedBy) as CreatedBy
      ,dbo.fn_GetUserJSON(ModifiedBy) as ModifiedBy
  FROM [dbo].[FAQs] as f inner join dbo.FAQCategories as fc
						on f.CategoryId = fc.Id

End
GO
