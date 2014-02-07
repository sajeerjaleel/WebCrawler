require 'open-uri'

task :import => :environment do

	Epldata.delete_all
	Fixtures.delete_all
	Result.delete_all

	page= Nokogiri::HTML(open("http://www.bbc.com/sport/football/tables")) 
	page.search('//tr').each do |line|
	 	position = line.search('td.position/span.position-number/text()').to_s
	  team = line.search('td.team-name/a/text()').to_s
	  played = line.search('td.played/text()').to_s
	  won = line.search('td.won/span/text()').to_s
	  drawn = line.search('td.drawn/text()').to_s
	  lost = line.search('td.lost/text()').to_s
	  goalfor = line.search('td.for/text()').to_s
	  goalagainst = line.search('td.against/text()').to_s
	  goaldifference = line.search('td.goal-difference/text()').to_s
	  points = line.search('td.points/text()').to_s

	  p = Epldata.new 
	 		p.position = position
	 	  p.team = team
	 	  p.played = played
	 	  p.won = won
	    p.drawn = drawn
	    p.lost = lost
	 	  p.goalfor = goalfor
	 	  p.goalagainst = goalagainst
	 	  p.goaldifference = goaldifference
	 	  p.points = points	  
	  p.save
	end

	a = Epldata.first
	a.delete
	b = Epldata.first
	b.delete



	page= Nokogiri::HTML(open("http://www.premierleague.com/en-gb/matchday/matches.html?paramClubId=ALL&paramComp_100=true&view=.dateSeason"))  
	page.search('//tr').each do |line|
	  	
	  date = line.search('th/text()').to_s
	 	time = line.search('td.time/text()').to_s
	 	teams = line.search('td.clubs/a/text()').to_s
	 	location = line.search('td.location/a/text()').to_s.strip.gsub("'","")

	  f = Fixtures.new
	 	  f.date = date 
	 	  f.time = time
	 	  f.teams = teams
	 	  f.location = location
	 	f.save
	end

	f = Fixtures.where(:date => "",:time => "", :teams => "", :location => "")
	f.delete_all
	f = Fixtures.where(:date => "ClubPldPts")
	f.delete_all


	page= Nokogiri::HTML(open("http://www.premierleague.com/en-gb/matchday/results.html?paramComp_100=true&view=.dateSeason"))  
	page.search('//tr').each do |line|
	  
		date = line.search('th/text()').to_s
		hometeam = line.search('td.rHome/a/text()').to_s
		score = line.search('td.score/a/text()').to_s
		awayteam = line.search('td.rAway/a/text()').to_s
		location = line.search('td.location/a/text()').to_s.strip.gsub("'","")

	  f = Result.new
		  f.date = date 
		  f.hometeam = hometeam
		  f.score = score
		  f.awayteam = awayteam
		  f.location = location
		f.save
	end

	f = Result.where(:date => "ClubPldPts")
	f.delete_all

end
