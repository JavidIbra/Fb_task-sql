Create database P411Facebook
use P411Facebook

create table Users (

Id int identity primary key,
Name nvarchar(25),
Surname  nvarchar(25),
ProfilePhoto nvarchar(25),
Biography nvarchar(250),
PostCount int
)

create table Posts(

Id int identity primary key,
Image nvarchar(25),
Text  nvarchar(250),
)

create table Comments(

Id int identity primary key,
Text nvarchar(25),

)

alter table Posts add UserId int references Users(Id)
alter table Comments add PostId int references Posts(Id)

select p.Text,us.Name, us.Surname from Posts as p
join Users as us 
on p.UserId=us.Id


CREATE VIEW PostsWithUser
AS
select p.Text 'PostTtext',us.Name 'PostOwnerName', us.Surname 'PostOwnerSurname' from Posts as p
join Users as us 
on p.UserId=us.Id



CREATE PROCEDURE GetUsersPostComment @UserId int=1 as
select Count(Comments.Text) 'CommentCount' from Comments 
join Posts 
on Comments.PostId=Posts.Id
where Posts.UserId=(Select Id from Users where Id=@UserId)


exec GetUsersPostComment 3

create trigger IncreasePostCount
on Posts
after insert
as
begin

update Users set PostCount=PostCount+1	where Id =(Select UserId from inserted Posts )

end