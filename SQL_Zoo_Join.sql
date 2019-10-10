--Modify it to show the matchid and player name for all 
--goals scored by Germany. To identify German players, 
--check for: teamid = 'GER'

SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

  --Show id, stadium, team1, team2 for just game 1012

  SELECT id,stadium,team1,team2
  FROM game where id = '1012'

  --Modify it to show the player, teamid, stadium and mdate for every German goal.
  select g.player, g.teamid, g2.stadium, g2.mdate
from goal g join game g2 on g.matchid = g2.id
where g.teamid = 'GER'  

select g2.team1, g2.team2, g.player
from goal g join game g2 on g.matchid = g2.id
where g.player like 'Mario%' 

--Show player, teamid, coach, gtime for 
--all goals scored in the first 10 minutes gtime<=10

SELECT g.player, g.teamid, e.coach, g.gtime
  FROM goal g join eteam e on g.teamid = e.id
 WHERE g.gtime<=10

 --List the the dates of the matches and the name of the team 
 --in which 'Fernando Santos' was the team1 coach.

 select g.mdate, e.teamname
from game g join eteam e
on g.team1 = e.id
where coach = 'Fernando Santos'

--List the player for every goal scored in
--a game where the stadium was 'National Stadium, Warsaw'

select player from goal g
join game g2 on g.matchid = g2.id
where g2.stadium = 'National Stadium, Warsaw'

--Instead show the name of all players who scored a goal against Germany

SELECT distinct(player)
FROM game g JOIN 
(select * from goal where teamid <> 'GER') as tmp
 ON tmp.matchid = g.id 
WHERE (team1='GER' or team2='GER')

--Show teamname and the total number of goals scored.

select e.teamname, tmp.cnt from eteam e
join
(select teamid, Count(*) as cnt from
goal group by teamid) as tmp
on
e.id = tmp.teamid

--Show the stadium and the number of goals scored in each stadium.

select g.stadium, Count(*) as goals
from game g join goal g2
on g.id = g2.matchid
group by g.stadium

--For every match involving 'POL', show the matchid,
--date and the number of goals scored.

select g2.matchid, g.mdate, Count(*) as goals
from goal g2 join (select id, mdate from game where team1='POL' or team2 = 'POL') as g
on g.id = g2.matchid
group by matchid, mdate

--For every match where 'GER' scored,
--show matchid, match date and the number of goals scored by 'GER'

select g.matchid,  tmp2.mdate, Count(*)
from goal g
join
(select id, mdate from game) tmp2
on g.matchid = tmp2.id
where g.teamid = 'GER'
group by matchid, mdate

--List every match with the goals scored by each team as shown.

select g.mdate,
g.team1,
SUM(CASE WHEN g.team1 = g2.teamid then 1 else 0 end) score1,
g.team2,
SUM(CASE WHEN g.team2 = g2.teamid then 1 else 0 end) score2
from game g 
left join goal g2 
on g.id =g2.matchid
group by g.mdate, g2.matchid, g.team1, g.team2