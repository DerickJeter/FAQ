USE [Tabi]
GO
/****** Object:  StoredProcedure [dbo].[FAQs_Update]    Script Date: 4/2/2024 2:51:44 PM ******/
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

CREATE proc [dbo].[FAQs_Update]
				@Question nvarchar(255),
				@Answer nvarchar(2000),
				@CategoryId int,
				@SortOrder int,
				@CreatedBy int,
				@ModifiedBy int,
				@Id int

as
/*----Test Code----

Select *
From dbo.FAQs


Declare @Id int =

Declare @Question nvarchar(255) =
		,@Answer nvarchar(2000) =
		,@CategoryId int =
		,@SortOrder int =
		,@CreatedBy int =
		,@ModifiedBy int =

Execute dbo.FAQs_Update
				@Question,
				@Answer,
				@CategoryId,
				@SortOrder
				@CreatedBy,
				@ModifiedBy,
				@Id


Select *
From dbo.FAQs

*/

Begin

Declare @DateModified datetime2(7) = getutcdate()

UPDATE [dbo].[FAQs]
   SET [Question] = @Question
      ,[Answer] = @Answer
      ,[CategoryId] = @CategoryId
      ,[SortOrder] = @SortOrder
      ,[DateModified] = @DateModified
      ,[CreatedBy] = @CreatedBy
      ,[ModifiedBy] = @ModifiedBy

 WHERE @Id = Id

 End


GO
