require './team'
require './player'
require 'csv'

@teams = []
@players = []
@player_id = 1
@free_agents = 0

import_file = "players.csv"
output_file = 'roster_file.json'

saints = Team.new(0, 1, 6, 'New Orleans', 'Saints', "NO", 1.2, 'http://i.imgur.com/P7fTi0C.png', 'nor')
@teams.push(saints)
texans = Team.new(1, 0, 2, 'Houston', 'Texans', 'HOU', 4.3, 'http://i.imgur.com/w23F0wJ.png', 'hou')
@teams.push(texans)
bills = Team.new(2, 0, 0, 'Buffalo', 'Bills', 'BUF', 1.2, 'http://i.imgur.com/rRTKTk9.png', 'buf')
@teams.push(bills)
ravens = Team.new(3, 0, 1, 'Baltimore', 'Ravens', 'BAL', 2.2, 'http://i.imgur.com/Q0x8yKD.png', 'bal')
@teams.push(ravens)
panthers = Team.new(4, 1, 6, 'Carolina', 'Panthers', 'CAR', 1.8, 'http://i.imgur.com/hIUdLFG.png', 'car')
@teams.push(panthers)
bengals = Team.new(5, 0, 1, 'Cincinnati', 'Bengals', 'CIN', 1.6, 'http://i.imgur.com/VOGS13w.png', 'cin')
@teams.push(bengals)
broncos = Team.new(6, 0, 3, 'Denver', 'Broncos', 'DEN', 2.2, 'http://i.imgur.com/Fj9siZb.png', 'den')
@teams.push(broncos)
bears = Team.new(7, 1, 5, 'Chicago', 'Bears', 'CHI', 8.8, 'http://i.imgur.com/Lyfa452.png', 'chi')
@teams.push(bears)
browns = Team.new(8, 0, 1, 'Cleveland', 'Browns', 'CLE', 1.9, 'http://i.imgur.com/5xBTnD3.png', 'cle')
@teams.push(browns)
chiefs = Team.new(9, 0, 3, 'Kansas City', 'Chiefs', 'KC', 1.4, 'http://i.imgur.com/0OlNGwc.png', 'kc')
@teams.push(chiefs)
cards = Team.new(10, 1, 7, 'Arizona', 'Cardinals', 'ARI', 3.4, 'http://i.imgur.com/z17OLiP.png', 'ari')
@teams.push(cards)
niners = Team.new(11, 1, 7, 'San Francisco', '49ers', 'SF', 3.4, 'http://i.imgur.com/T30YQiE.png', 'sf')
@teams.push(niners)
raiders = Team.new(12, 0, 3, 'Oakland', 'Raiders', 'OAK', 1.6, 'http://i.imgur.com/iT0ELls.png', 'oak')
@teams.push(raiders)
colts = Team.new(13, 0, 2, 'Indianapolis', 'Colts', 'IND', 1.7, 'http://i.imgur.com/GXZfoaI.png', 'ind')
@teams.push(colts)
cowboys = Team.new(14, 1, 4, 'Dallas', 'Cowboys', 'DAL', 4.7, 'http://i.imgur.com/R07htwi.png', 'dal')
@teams.push(cowboys)
dolphins = Team.new(15, 0, 0, 'Miami', 'Dolphins', 'MIA', 5.4, 'http://i.imgur.com/9GQb2KE.png', 'mia')
@teams.push(dolphins)
pats = Team.new(16, 0, 0, 'New England', 'Patriots', 'NE', 4.4, 'http://i.imgur.com/8aGKfgn.png', 'ne')
@teams.push(pats)
lions = Team.new(17, 1, 5, 'Detroit', 'Lions', 'DET', 4.0, 'http://i.imgur.com/A9tGOwU.png', 'det')
@teams.push(lions)
falcons = Team.new(18, 1, 6, 'Atlanta', 'Falcons', 'ATL', 4.3, 'http://i.imgur.com/LaGxOjX.png', 'atl')
@teams.push(falcons)
steelers = Team.new(19, 0, 1, 'Pittsburgh', 'Steelers', 'PIT', 1.8, 'http://i.imgur.com/J83Hddm.png', 'pit')
@teams.push(steelers)
eagles = Team.new(20, 1, 4, 'Philadephia', 'Eagles', 'PHI', 5.4, 'http://i.imgur.com/jBj1pS1.png', 'phi')
@teams.push(eagles)
packers = Team.new(21, 1, 5, 'Green Bay', 'Packers', 'GB', 1.6, 'http://i.imgur.com/Nvc7G6g.png', 'gb')
@teams.push(packers)
seahawks = Team.new(22, 1, 7, 'Seattle', 'Seahawks', 'SEA', 3.0, 'http://i.imgur.com/IvMyq5c.png', 'sea')
@teams.push(seahawks)
vikings = Team.new(23, 1, 5, 'Minnesota', 'Vikings', 'MIN', 2.6, 'http://i.imgur.com/BQsTOeK.png', 'min')
@teams.push(vikings)
giants = Team.new(24, 1, 4, 'New York (N)', 'Giants', 'NYG', 18.7, 'http://i.imgur.com/HugEtCZ.png', 'nyg')
@teams.push(giants)
chargers = Team.new(25, 0, 3, 'San Diego', 'Chargers', 'SD', 2.9, 'http://i.imgur.com/5l9QLhb.png', 'sd')
@teams.push(chargers)
jags = Team.new(26, 0, 2, 'Jacksonville', 'Jaguars', 'JAC', 2.1, 'http://i.imgur.com/RWkymqZ.png', 'jac')
@teams.push(jags)
jets = Team.new(27, 0, 0, 'New York (A)', 'Jets', 'NYJ', 18.7, 'http://i.imgur.com/fbC2OFr.png', 'nyj')
@teams.push(jets)
redskins = Team.new(28, 1, 4, 'Washington', 'Redskins', 'WAS', 4.2, 'http://i.imgur.com/r1CJokx.png', 'was')
@teams.push(redskins)
titans = Team.new(29, 0, 2, 'Tennessee', 'Titans', 'TEN', 1.3, 'http://i.imgur.com/M5ItolY.png', 'ten')
@teams.push(titans)
bucs = Team.new(30, 1, 6, 'Tampa Bay', 'Buccaneers', 'TB', 2.2, 'http://i.imgur.com/jPv6Aq2.png', 'tb')
@teams.push(bucs)
rams = Team.new(31, 1, 7, 'St. Louis', 'Rams', 'STL', 2.2, 'http://i.imgur.com/RPUO4Kz.png', 'stl')
@teams.push(rams)


csv_data = File.read(import_file)
csv = CSV.parse(csv_data, :headers => true)
csv.each do |row|
  team_id = nil
  team_name = row['Team'].strip.downcase
  team = @teams.select{|t| t.nickname.downcase === team_name}.first
  team_id = team.id if team != nil
  first = row['First Name']
  last = row['Last Name']
  position = row['Position']
  height = row['Height']
  weight = row['Weight']
  stamina = row['Stamina']
  speed = row['Speed']
  strength = row['Strength']
  toughness = row['Toughness']
  awareness = row['Awareness']
  pass_block = row['Pass Block']
  run_block = row['Run Block']
  tackle = row['Tackle']
  man_cov = row['Man Coverage']
  zone_cov = row['Zone Coverage']
  overall = row['OVR']
  kick_pwr = row['Kick Power']
  kick_acc = row['Kick Accuracy']
  throw_pwr = row['Throw Power']
  throw_acc_short = row['Throw Accuracy Short']
  throw_acc_mid = row['Throw Accuracy Mid']
  throw_acc_deep = row['Throw Accuracy Deep']
  throw_on_run = row['Throw On The Run']
  block_shedding = row['Block Shedding']
  pursuit = row['Pursuit']
  catching = row['Catching']
  agility = row['Agility']
  hit_power = row['Hit Power']
  acceleration = row['Acceleration']
  jumping = row['Jumping']
  power_moves = row['Power Moves']

  if team_id
    p = Player.new(team_id, first, last, position, height, weight)
    p.id = @player_id
    p.endurance = stamina.to_i
    p.speed = speed.to_i
    p.strength = strength.to_i
    p.toughness = toughness.to_i
    p.awareness = awareness.to_i
    p.game_iq = awareness.to_i
    p.blocking = (pass_block.to_i + run_block.to_i) / 2
    p.tackle = tackle.to_i
    p.coverage = (man_cov.to_i + zone_cov.to_i) / 2
    p.overall = overall.to_i
    p.potential = overall.to_i
    p.kicking = (kick_pwr.to_i + kick_acc.to_i) / 2
    p.strength = throw_pwr.to_i if position.downcase === 'qb'
    p.passing = (throw_acc_short.to_i + throw_acc_mid.to_i + throw_acc_deep.to_i + throw_on_run.to_i) / 4
    p.def_rush = (block_shedding.to_i + pursuit.to_i) / 2
    p.receiving = catching.to_i
    p.hands = catching.to_i
    p.athleticism = (agility.to_i + acceleration.to_i) / 2
    p.aggresiveness = hit_power.to_i
    p.motor = (power_moves.to_i + jumping.to_i) / 2 if p.position_group === 'def'
    p.motor = (jumping.to_i) if p.position_group != 'def'

    # team_count = @players.select{|p| p.team_id === team_id}.count
    # puts "Team: #{team_name}"
    # puts "Players: #{team_count}"

    # if p.overall < 64 or team_count > 52
    #   p.team_id = -1
    #   @free_agents += 1
    # end

    @players.push(p)
    @player_id += 1
  else
    puts "Cannot find #{team_name}"
  end
end

puts "player count: #{@players.count}"
# puts "free agent count: #{@free_agents}"

File.open(output_file, 'w') do |f|
  players = @players.map{|p| p.json_format}

  output = {
    :startingSeason => 2016,
    :players => players
  }

  f.write output.to_json
end
