require './team'
require './player'
require './web_scrape'
require 'csv'

@teams = []
@players = []
@player_id = 1

import_file = 'players.csv'
updated_player_file = 'players_updated_new.csv'

def write_csv(csv_file, data)
  CSV.open(csv_file, 'a+') do |csv|
    csv << data
  end
end

saints = Team.new(0, 1, 6, 'New Orleans', 'Saints', "NO", 1.2, 'http://i.imgur.com/P7fTi0C.png')
@teams.push(saints)
texans = Team.new(1, 0, 2, 'Houston', 'Texans', 'HOU', 4.3, 'http://i.imgur.com/w23F0wJ.png')
@teams.push(texans)
bills = Team.new(2, 0, 0, 'Buffalo', 'Bills', 'BUF', 1.2, 'http://i.imgur.com/rRTKTk9.png')
@teams.push(bills)
ravens = Team.new(3, 0, 1, 'Baltimore', 'Ravens', 'BAL', 2.2, 'http://i.imgur.com/Q0x8yKD.png')
@teams.push(ravens)
panthers = Team.new(4, 1, 6, 'Carolina', 'Panthers', 'CAR', 1.8, 'http://i.imgur.com/hIUdLFG.png')
@teams.push(panthers)
bengals = Team.new(5, 0, 1, 'Cincinnati', 'Bengals', 'CIN', 1.6, 'http://i.imgur.com/VOGS13w.png')
@teams.push(bengals)
broncos = Team.new(6, 0, 3, 'Denver', 'Broncos', 'DEN', 2.2, 'http://i.imgur.com/Fj9siZb.png')
@teams.push(broncos)
bears = Team.new(7, 1, 5, 'Chicago', 'Bears', 'CHI', 8.8, 'http://i.imgur.com/Lyfa452.png')
@teams.push(bears)
browns = Team.new(8, 0, 1, 'Cleveland', 'Browns', 'CLE', 1.9, 'http://i.imgur.com/5xBTnD3.png')
@teams.push(browns)
chiefs = Team.new(9, 0, 3, 'Kansas City', 'Chiefs', 'KC', 1.4, 'http://i.imgur.com/0OlNGwc.png')
@teams.push(chiefs)
cards = Team.new(10, 1, 7, 'Arizona', 'Cardinals', 'ARI', 3.4, 'http://i.imgur.com/z17OLiP.png')
@teams.push(cards)
niners = Team.new(11, 1, 7, 'San Francisco', '49ers', 'SF', 3.4, 'http://i.imgur.com/T30YQiE.png')
@teams.push(niners)
raiders = Team.new(12, 0, 3, 'Oakland', 'Raiders', 'OAK', 1.6, 'http://i.imgur.com/iT0ELls.png')
@teams.push(raiders)
colts = Team.new(13, 0, 2, 'Indianapolis', 'Colts', 'IND', 1.7, 'http://i.imgur.com/GXZfoaI.png')
@teams.push(colts)
cowboys = Team.new(14, 1, 4, 'Dallas', 'Cowboys', 'DAL', 4.7, 'http://i.imgur.com/R07htwi.png')
@teams.push(cowboys)
dolphins = Team.new(15, 0, 0, 'Miami', 'Dolphins', 'MIA', 5.4, 'http://i.imgur.com/9GQb2KE.png')
@teams.push(dolphins)
pats = Team.new(16, 0, 0, 'New England', 'Patriots', 'NE', 4.4, 'http://i.imgur.com/8aGKfgn.png')
@teams.push(pats)
lions = Team.new(17, 1, 5, 'Detroit', 'Lions', 'DET', 4.0, 'http://i.imgur.com/A9tGOwU.png')
@teams.push(lions)
falcons = Team.new(18, 1, 6, 'Atlanta', 'Falcons', 'ATL', 4.3, 'http://i.imgur.com/LaGxOjX.png')
@teams.push(falcons)
steelers = Team.new(19, 0, 1, 'Pittsburgh', 'Steelers', 'PIT', 1.8, 'http://i.imgur.com/J83Hddm.png')
@teams.push(steelers)
eagles = Team.new(20, 1, 4, 'Philadephia', 'Eagles', 'PHI', 5.4, 'http://i.imgur.com/jBj1pS1.png')
@teams.push(eagles)
packers = Team.new(21, 1, 5, 'Green Bay', 'Packers', 'GB', 1.6, 'http://i.imgur.com/Nvc7G6g.png')
@teams.push(packers)
seahawks = Team.new(22, 1, 7, 'Seattle', 'Seahawks', 'SEA', 3.0, 'http://i.imgur.com/IvMyq5c.png')
@teams.push(seahawks)
vikings = Team.new(23, 1, 5, 'Minnesota', 'Vikings', 'MIN', 2.6, 'http://i.imgur.com/BQsTOeK.png')
@teams.push(vikings)
giants = Team.new(24, 1, 4, 'New York (N)', 'Giants', 'NYG', 18.7, 'http://i.imgur.com/HugEtCZ.png')
@teams.push(giants)
chargers = Team.new(25, 0, 3, 'San Diego', 'Chargers', 'SD', 2.9, 'http://i.imgur.com/5l9QLhb.png')
@teams.push(chargers)
jags = Team.new(26, 0, 2, 'Jacksonville', 'Jaguars', 'JAC', 2.1, 'http://i.imgur.com/RWkymqZ.png')
@teams.push(jags)
jets = Team.new(27, 0, 0, 'New York (A)', 'Jets', 'NYJ', 18.7, 'http://i.imgur.com/fbC2OFr.png')
@teams.push(jets)
redskins = Team.new(28, 1, 4, 'Washington', 'Redskins', 'WAS', 4.2, 'http://i.imgur.com/r1CJokx.png')
@teams.push(redskins)
titans = Team.new(29, 0, 2, 'Tennessee', 'Titans', 'TEN', 1.3, 'http://i.imgur.com/M5ItolY.png')
@teams.push(titans)
bucs = Team.new(30, 1, 6, 'Tampa Bay', 'Buccaneers', 'TB', 2.2, 'http://i.imgur.com/jPv6Aq2.png')
@teams.push(bucs)
rams = Team.new(31, 1, 7, 'St. Louis', 'Rams', 'STL', 2.2, 'http://i.imgur.com/RPUO4Kz.png')
@teams.push(rams)

@ws = WebScraper.new

@teams.each do |t|
  t.salary_data = @ws.team_contract_info(t.team_name_slug)
end

@num = 1
csv_data = File.read(import_file)
csv = CSV.parse(csv_data, :headers => true)

@row_count = csv.count

header_names = csv.to_a.first
header_names += ['Team ID', 'Image URL', 'Age', 'Birth Year', 'Birth Place', 'Contract Expiration', 'Contract Value', 'Draft Year', 'Draft Team ID', 'Draft Round', 'Draft Pick']

write_csv(updated_players_csv, header_names)

csv.each do |row|
  puts "#{@num} of #{@row_count}"
  team_id = nil
  team_name = row['Team'].strip.downcase

  # find the matching team in memory, based on the name in the spreadsheet
  team = @teams.select{|t| t.nickname.downcase === team_name}.first
  team_id = team.id if team != nil

  first = row['First Name']
  last = row['Last Name']
  position = row['Position']
  height = row['Height']
  weight = row['Weight']

  if team_id
    p = Player.new(team_id, first, last, position, height, weight)
    p.id = @player_id
    p.image_url = team.default_player_image

    player_contract_expiration = team.player_salary_expiration_year(p.full_name)
    player_contract_amount = team.player_salary_annual_avg(p.full_name)

    p.contract_amount = player_contract_amount if player_contract_amount
    p.contract_expiration = player_contract_expiration if player_contract_expiration

    image_url, player_info, player_age, birth_year, birth_place, draft_year = @ws.nfl_info(last, first)

    p.image_url = image_url if image_url != '' and image_url != nil
    p.birth_year = birth_year if birth_year != '' and birth_year != nil
    p.birth_location = birth_place if birth_place != '' and birth_place != nil
    p.draft_year = draft_year if draft_year != '' and draft_year != nil

    row['Team ID'] = team_id
    row['Image URL'] = p.image_url
    row['Age'] = player_age
    row['Birth Year'] = p.birth_year
    row['Birth Place'] = p.birth_location
    row['Contract Expiration'] = p.contract_expiration
    row['Contract Value'] = p.contract_amount
    row['Draft Year'] = p.draft_year
    row['Draft Team ID'] = p.draft_team_id
    row['Draft Round'] = p.draft_round
    row['Draft Pick'] = p.draft_pick

    write_csv(updated_players_csv, row)

    @players.push(p)
    @player_id += 1
    @num += 1
  else
    puts "Cannot find matching team: '#{team_name}'"
  end
end
