require 'net/http'
require 'csv'

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

    def write_csv(file_name, csv_data)
      CSV.open(file_name, 'wb') do |csv|
        csv_data.each do |row|
          csv << row
        end
      end
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
