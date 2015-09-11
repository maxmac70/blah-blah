require 'json'

class Team
  attr_reader :id, :conference_id, :division_id, :city, :nickname, :abbreviation, :population, :image_url, :pfr_name
  attr_writer :id, :conference_id, :division_id, :city, :nickname, :abbreviation, :population, :image_url, :pfr_name

  def initialize(team_id, conference_id, division_id, city, nickname, abbreviation, population, image_url = '', pfr_name = '')
    @id = team_id
    @conference_id = conference_id
    @division_id = division_id
    @city = city
    @nickname = nickname
    @abbreviation = abbreviation
    @population = population
    @image_url = image_url
    @pfr_name = pfr_name
  end

  def as_json
    {
      :tid => @id,
      :cid => @conference_id,
      :did => @division_id,
      :region => @city,
      :name => @nickname,
      :abbrev => @abbreviation,
      :pop => @population,
      :imgUrl => @image_url
    }.to_json
  end

end
