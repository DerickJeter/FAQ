USE [Tabi]
GO
/****** Object:  StoredProcedure [dbo].[FAQs_Delete_ById]    Script Date: 4/2/2024 2:51:44 PM ******/
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

CREATE proc [dbo].[FAQs_Delete_ById]
			@Id int


as
/*---- Test Code----
Select *
From dbo.FAQs

Execute dbo.FAQs_Delete_ById 
				@Id = 

Select *
From dbo.FAQs

*/

Begin

DELETE FROM [dbo].[FAQs]
      WHERE Id = @Id

End


GO
