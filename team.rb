require 'json'
require 'mechanize'

class Team
  attr_accessor :id, :conference_id, :division_id, :city, :nickname, :abbreviation, :population, :image_url, :default_player_image, :salary_data

  def initialize(team_id, conference_id, division_id, city, nickname, abbreviation, population, image_url = '')
    @id = team_id
    @conference_id = conference_id
    @division_id = division_id
    @city = city
    @nickname = nickname
    @abbreviation = abbreviation
    @population = population
    @image_url = image_url
    @salary_data = nil
    @default_player_image = "http://static.nfl.com/static/content/public/image/fantasy/transparent/200x200/#{@abbreviation.upcase}.png"
  end

  def team_name_slug
    team_name = "#{city.gsub('(N)', '').gsub('(A)', '').strip} #{nickname}"
    return team_name.downcase.strip.gsub(' ', '-')
  end

  def player_salary_expiration_year(player_name)
    player_name = Team.fix_known_player_name(player_name)

    if @salary_data
      if data_row = @salary_data.at("tr:contains('#{player_name}')")
        element_count = data_row.children.length
        if expiration_year = data_row.children[element_count - 2].child.text
          if expiration_year_match = expiration_year.match(/(?:(?:19|20)[0-9]{2})/)
            return expiration_year_match[0].strip
          end
        end
      end
    end

    return nil
  end

  def player_salary_annual_avg(player_name)
    player_name = Team.fix_known_player_name(player_name)

    if @salary_data
      if data_row = @salary_data.at("tr:contains('#{player_name}')")
        element_count = data_row.children.length
        if avg_salary = data_row.children[element_count - 8].child.text
          return avg_salary.gsub(/\D/,'').to_i / 1000
        end
      end
    end

    return nil
  end

  def self.fix_known_player_name(player_name)
    # this is dumb, but just fixing some low-hanging fruit
    return 'DeAndre White' if player_name.downcase === 'deandrew white'

    return player_name.split("'").last if player_name.include? "'"

    return player_name
  end

  def json_format
    {`
      :tid => @id,
      :cid => @conference_id,
      :did => @division_id,
      :region => @city,
      :name => @nickname,
      :abbrev => @abbreviation,
      :pop => @population,
      :imgUrl => @image_url
    }
  end

end
