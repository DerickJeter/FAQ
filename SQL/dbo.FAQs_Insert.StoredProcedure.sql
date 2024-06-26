USE [Tabi]
GO
/****** Object:  StoredProcedure [dbo].[FAQs_Insert]    Script Date: 4/2/2024 2:51:44 PM ******/
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

CREATE proc [dbo].[FAQs_Insert]
			@Question nvarchar(255),
           @Answer nvarchar(2000),
           @CategoryId int,
           @SortOrder int,
           @CreatedBy int,
           @ModifiedBy int,
		   @Id int OUTPUT



as
/*----Test Code----
Select *
From dbo.FAQs

Declare @Id int = 1

Declare		@Question nvarchar(255) = 'TestQuestion1'
           ,@Answer nvarchar(2000) = 'TestAnswer1'
           ,@CategoryId int = 1
           ,@SortOrder int = 1
           ,@CreatedBy int = 1
           ,@ModifiedBy int = 1

Execute dbo.FAQs_Insert
			@Question
			,@Answer
			,@CategoryId
			,@SortOrder
			,@CreatedBy
			,@ModifiedBy
			,@Id OUTPUT

Select *
From dbo.FAQs



*/


Begin


INSERT INTO [dbo].[FAQs]
           ([Question]
           ,[Answer]
           ,[CategoryId]
           ,[SortOrder]  
           ,[CreatedBy]
           ,[ModifiedBy])
     VALUES
           (@Question,
           @Answer,
           @CategoryId,
           @SortOrder,  
           @CreatedBy,
           @ModifiedBy)

	Set @Id = SCOPE_IDENTITY()


End


GO
