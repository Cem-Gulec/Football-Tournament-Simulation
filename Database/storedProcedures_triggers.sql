
---- update player info, in case there is a typo happened during storage
create proc sp_UpdatePlayerInfo
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

exec sp_UpdatePlayerInfo 1, 'Faruk', 'Çakýr', 'Ugandan', '1997-07-20', 9


create proc sp_UpdatePitchInfo
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

exec sp_UpdatePitchInfo 1, 'MALTEPECLUB', 'ESENYURT', 'EMRE', '5535557741'


create proc sp_UpdateRefereeInfo
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

exec sp_UpdateRefereeInfo 1, 'Yaman', 'Þaner', 5


---- with a given date, list the matches played between date and current date (it includes invalid date error)
create proc sp_ListMatches
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

exec sp_ListMatches '2020-12-10'


---- top x players having most goals scored
create proc sp_TopGoalScorers
     @limit int
as
begin
     set nocount on;

	 Select rank() over(Order By p.NumberOfGoals desc) rankNum, *
     from (Select top(@limit) * 
	      From Player) p
end
	
exec sp_TopGoalScorers 5

---- for a given team maximum goals reached and teamsCoach
create proc sp_MostValuablesForTeam
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

exec sp_MostValuablesForTeam 'Köyiçi FK'

-- how many matches for which stages 
create proc sp_RefereeStages
	@RefereeFN nvarchar(20), @RefereeLN nvarchar(20)
as
begin
	Select m.MatchStage, Count(*) NumberOfMatches 
	From Referee r inner join Match m on m.RefereeID=r.RefereeID
	Where r.FirstName=@RefereeFN and r.LastName=@RefereeLN
	Group By m.MatchStage
end

exec sp_RefereeStages 'Emin', 'Mertol'



create proc sp_TeamSeasonStats
	@TeamName nvarchar(20)
as
begin
	set nocount on;

	Select *
	From TOURNAMENT_TEAM tt inner join Team t on tt.TeamID=t.TeamID
	Where t.Name = @TeamName
end

exec sp_TeamSeasonStats 'Olimpique Limon'


create proc sp_InsertManagerInfo
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

exec sp_InsertManagerInfo 31, 'Mehmet', 'Kelek', 'Fransa', '1980-10-10', 15


create proc sp_InsertRefereeInfo
	@RefereeID tinyint, @FirstName nvarchar(20),
	@LastName nvarchar(20), @Experience int
as
begin
	set nocount on;
	
	insert into Referee(RefereeID, FirstName, LastName, YearsOfExperience)
	values(@RefereeID,@FirstName,@LastName,@Experience)
end

exec sp_InsertRefereeInfo 31, 'Kadir', 'Kulak', 6


-- triggers
Create Trigger GoalOccuredorCorrected
	on GOAL
	after insert, delete
as
begin 

	Update p
	Set NumberOfGoals = NumberOfGoals + 1
	From Player p inner join inserted i on i.PlayerID=p.PlayerID

	Update p
	Set NumberOfGoals = NumberOfGoals - 1
	From Player p inner join deleted d on d.PlayerID=p.PlayerID

end
