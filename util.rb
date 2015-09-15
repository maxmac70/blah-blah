require 'net/http'
require 'csv'
require './web_scrape'

class Util
  class << self
    def fix_player_images(input_file='csv/players_updated.csv', output_file='csv/players_updated.csv')
      output_csv_data = []
      csv_input_data = CSV.read(input_file)
      file_length = (csv_input_data.count - 1)
      output_csv_data << csv_input_data[0]
      images_changed = 0
      generic_team_photo_used = 0
      free_agent_photo_used = 0

      base_image_url = "http://static.nfl.com/static/content/public/image/fantasy/transparent/200x200"

      (1..file_length).each do |i|
        puts "Processing #{i} of #{file_length}" if i % 100 === 0

        # clean up team name padding while we're in here
        csv_input_data[i][0] = csv_input_data[i][0].strip

        # player image url
        player_image_url = csv_input_data[i][52]

        res = Net::HTTP.get_response(URI(player_image_url))

        if res.code.to_i != 200
          team_name = csv_input_data[i][0]
          team_abbr = Util.team_abbreviation(team_name)
          if team_abbr === 'FA'
            free_agent_photo_used += 1
          else
            generic_team_photo_used += 1
          end
          csv_input_data[i][52] = "#{base_image_url}/#{team_abbr}.png"
          images_changed += 1
        end
        output_csv_data << csv_input_data[i]
      end

      # write the new file
      Util.write_csv(output_file, output_csv_data)

      puts "Updated data written to `#{output_file}`"
      puts "Images Processed: #{file_length - 1}"
      puts "Images Changed: #{images_changed}"
      puts "Team Stock Photo Used: #{generic_team_photo_used}"
      puts "Free Agent Stock Photo Used: #{free_agent_photo_used}"
    end

    def fix_player_draft_data(draft_class_year=2015, input_file='csv/players_updated.csv', output_file='csv/players_updated.csv')
      output_csv_data = []
      csv_input_data = CSV.read(input_file)
      file_length = (csv_input_data.count - 1)
      output_csv_data << csv_input_data[0]
      draft_info_changed = 0

      @ws = WebScraper.new
      @draft_class = @ws.draft_log(draft_class_year)

      (1..file_length).each do |i|
        puts "Processing #{i} of #{file_length}" if i % 100 === 0

        team_name = csv_input_data[i][0]
        first_name = csv_input_data[i][1]
        last_name = csv_input_data[i][2]
        position = csv_input_data[i][3]
        draft_team_id = csv_input_data[i][59]

        if draft_team_id == '-1'
          player_name = "#{first_name} #{last_name}"
          player_name = player_name.split("'").last if player_name.include? "'"

          match_position = position.upcase

          case position.upcase
            when 'LT', 'RT'
              match_position = 'T'
            when 'LOLB', 'ROLB', 'MLB'
              match_position = 'LB'
            when 'LG', 'RG'
              match_position = 'G'
            when 'RE', 'LE'
              match_position = 'DE'
            when 'CB', 'FS', 'SS'
              match_position = 'DB'
          end

          if data_row = @draft_class.at("tr:contains('#{player_name}')")
            if pos = data_row.children[9].child.text
              if pos === match_position
                csv_input_data[i][58] = draft_class_year
                csv_input_data[i][60] = data_row.children[1].child.text.to_i
                csv_input_data[i][61] = data_row.children[3].child.text.to_i
                csv_input_data[i][59] = Util.team_id_from_pfr_abbreviation(data_row.children[5].child.text.strip)

                draft_info_changed += 1
              end
            end
          end

        end
        output_csv_data << csv_input_data[i]
      end

      # write the new file
      Util.write_csv(output_file, output_csv_data)

      puts "Updated data written to `#{output_file}`"
      puts "Players Checked: #{file_length - 1}"
      puts "Draft Class: #{draft_class_year}"
      puts "Draft Info Changed: #{draft_info_changed}"
    end

    def write_csv(file_name, csv_data)
      CSV.open(file_name, 'wb') do |csv|
        csv_data.each do |row|
          csv << row
        end
      end
    end

    def get_draft_log(year)
      url = "http://www.pro-football-reference.com/years/#{year}/draft.htm"
    end

    def team_id_from_pfr_abbreviation(team_abbreviation)
      abbreviation = team_abbreviation.strip.downcase

      return 0 if abbreviation === 'nor'
      return 1 if abbreviation === 'hou'
      return 2 if abbreviation === 'buf'
      return 3 if abbreviation === 'bal'
      return 4 if abbreviation === 'car'
      return 5 if abbreviation === 'cin'
      return 6 if abbreviation === 'den'
      return 7 if abbreviation === 'chi'
      return 8 if abbreviation === 'cle'
      return 9 if abbreviation === 'kan'
      return 10 if abbreviation === 'ari'
      return 11 if abbreviation === 'sfo'
      return 12 if abbreviation === 'oak'
      return 13 if abbreviation === 'ind'
      return 14 if abbreviation === 'dal'
      return 15 if abbreviation === 'mia'
      return 16 if abbreviation === 'nwe'
      return 17 if abbreviation === 'det'
      return 18 if abbreviation === 'atl'
      return 19 if abbreviation === 'pit'
      return 20 if abbreviation === 'phi'
      return 21 if abbreviation === 'gnb'
      return 22 if abbreviation === 'sea'
      return 23 if abbreviation === 'min'
      return 24 if abbreviation === 'nyg'
      return 25 if abbreviation === 'sdg'
      return 26 if abbreviation === 'jax'
      return 27 if abbreviation === 'nyj'
      return 28 if abbreviation === 'was'
      return 29 if abbreviation === 'ten'
      return 30 if abbreviation === 'tam'
      return 31 if abbreviation === 'stl'

      puts "!!! #{abbreviation}"

    end

    def team_abbreviation(team_name)
      name = team_name.strip.downcase

      return 'AZ' if name === 'cardinals'
      return 'ATL' if name === 'falcons'
      return 'BAL' if name === 'ravens'
      return 'BUF' if name === 'bills'
      return 'CAR' if name === 'panthers'
      return 'CHI' if name === 'bears'
      return 'CIN' if name === 'bengals'
      return 'CLE' if name === 'browns'
      return 'DAL' if name === 'cowboys'
      return 'DEN' if name === 'broncos'
      return 'DET' if name === 'lions'
      return 'GB' if name === 'packers'
      return 'HOU' if name === 'texans'
      return 'IND' if name === 'colts'
      return 'JAC' if name === 'jaguars'
      return 'KC' if name === 'chiefs'
      return 'MIA' if name === 'dolphins'
      return 'MIN' if name === 'vikings'
      return 'NE' if name === 'patriots'
      return 'NO' if name === 'saints'
      return 'NYG' if name === 'giants'
      return 'NYJ' if name === 'jets'
      return 'OAK' if name === 'raiders'
      return 'PHI' if name === 'eagles'
      return 'PIT' if name === 'steelers'
      return 'STL' if name === 'rams'
      return 'SD' if name === 'chargers'
      return 'SF' if name === '49ers'
      return 'SEA' if name === 'seahawks'
      return 'TB' if name === 'buccaneers'
      return 'TEN' if name === 'titans'
      return 'WAS' if name === 'redskins'

      return 'FA' # unknown - return 'FA' for free-agent?
    end
  end
end
