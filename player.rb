
class Player
  attr_accessor :id, :team_id, :first_name, :last_name, :position, :height, :weight, :image_url, :birth_year, :birth_location, :contract_amount, :contract_expiration, :overall, :speed, :strength, :awareness, :catching, :blocking, :tackle, :stamina, :toughness, :coverage, :athleticism, :game_iq, :aggresiveness, :motor, :passing, :receiving, :def_rush, :kicking, :potential, :endurance, :hands, :draft_year, :draft_team_id, :draft_round, :draft_pick, :team_name

  def initialize(team_id = 0, first_name = '', last_name = '', position = '', height = nil, weight = nil)
    @team_id = team_id
    @first_name = first_name.strip
    @last_name = last_name.strip
    @position = position.strip.downcase
    @height = 70
    @weight =  200
    @image_url = ''
    @birth_year = 1984
    @birth_location = 'USA'
    @contract_amount = 435
    @contract_expiration = 2016

    @speed = 50
    @strength = 50
    @athleticism = 50
    @game_iq = 50
    @aggresiveness = 50
    @motor = 50
    @passing = 50
    @receiving = 50
    @def_rush = 50
    @kicking = 50
    @potential = 50
    @hands = 50
    @toughness = 50
    @overall = 50

    @draft_year = 2013
    @draft_team_id = -1
    @draft_pick = 0
    @draft_round = 0

    if height then
      h = height.split("'")
      feet = h[0].to_i
      inches = h[1].to_i
      @height = (feet * 12) + inches
    end

    if weight then
      @weight = weight.to_i
    else
      @weight = 200
    end
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end

  def output_position
    case @position
      when 'qb'
        'QB'
      when 'hb', 'fb'
        'RB'
      when 'wr'
        'WR'
      when 'te'
        'TE'
      when 'rg', 'rt', 'c', 'lg', 'lt'
        'OL'
      when 're', 'dt', 'le'
        'DL'
      when 'lolb', 'mlb', 'rolb'
        'LB'
      when 'cb'
        'CB'
      when 'ss', 'fs'
        'S'
      when 'k', 'p'
        'K'
      else
        'WTF'
    end
  end

  def position_group
    if ['QB', 'RB', 'WR', 'TE', 'OL'].include?(self.output_position)
      'off'
    elsif ['DL', 'LB', 'CB', 'S'].include?(self.output_position)
      'def'
    elsif self.output_position == 'K'
      'k'
    else # something went wrong, just set to 'offense'
      'off'
    end
  end

  def draft_details
    details = {
      :round => @draft_round,
      :pick => @draft_pick,
      :tid => @draft_team_id,
      :originalTid => -1,
      :year => @draft_year,
      :teamName => nil,
      :teamRegion => nil
    }

    return details
  end

  def ratings
    return [{
      :hgt => Player.limit_ratings(@speed),
      :stre => Player.limit_ratings(@strength),
      :spd => Player.limit_ratings(@endurance),
      :jmp => Player.limit_ratings(@athleticism),
      :endu => Player.limit_ratings(@height),
      :hnd => Player.limit_ratings(@hands),
      :ins => Player.limit_ratings(@game_iq),
      :dnk => Player.limit_ratings(@toughness),
      :ft => Player.limit_ratings(@awareness),
      :fg => Player.limit_ratings(@aggresiveness),
      :tp => Player.limit_ratings(@motor),
      :blk => Player.limit_ratings(@passing),
      :stl => Player.limit_ratings(@receiving),
      :drb => Player.limit_ratings(@blocking),
      :pss => Player.limit_ratings(@def_rush),
      :reb => Player.limit_ratings(@tackle),
      :cvr => Player.limit_ratings(@coverage),
      :kck => Player.limit_ratings(@kicking),
      :pot => Player.limit_ratings(@potential)
    }]
  end

  # __should__ return the overall value that matches the calculations on Football GM
  def overall
    position = self.output_position

    speed = Player.limit_ratings(@speed)
    strength = Player.limit_ratings(@strength)
    endurance = Player.limit_ratings(@endurance)
    athleticism = Player.limit_ratings(@athleticism)
    height = Player.limit_ratings(@height)
    hands = Player.limit_ratings(@hands)
    game_iq = Player.limit_ratings(@game_iq)
    toughness = Player.limit_ratings(@toughness)
    awareness = Player.limit_ratings(@awareness)
    aggresiveness = Player.limit_ratings(@aggresiveness)
    motor = Player.limit_ratings(@motor)
    passing = Player.limit_ratings(@passing)
    receiving = Player.limit_ratings(@receiving)
    blocking = Player.limit_ratings(@blocking)
    def_rush = Player.limit_ratings(@def_rush)
    tackle = Player.limit_ratings(@tackle)
    coverage = Player.limit_ratings(@coverage)
    kicking = Player.limit_ratings(@kicking)
    potential = Player.limit_ratings(@potential)

    case position
      when 'QB'
        overall = ((game_iq * 4) + (passing * 4) + (strength * 2) + speed + athleticism + (awareness * 2) + toughness) / 15
      when 'RB'
        overall = ((toughness * 4) + (awareness * 4) + (strength * 4) + (speed * 2) + (athleticism * 2) + (hands * 2)) / 22
      when 'TE'
        overall = ((receiving * 4) + (blocking * 4) + (toughness * 3) + (awareness * 3) + (speed * 2) + (strength * 2)) / 18
      when 'WR'
        overall = ((speed * 4) + (receiving * 4) + blocking + strength + athleticism + awareness + toughness) / 13
      else
        overall = 5
    end

    return Player.limit_ratings(overall)
  end

  def free_agent_mood
    fam = []
    30.times {fam.push(0)}
    return fam
  end

  def json_format
    {
      :ratings => self.ratings,
      :born => {
        :year => @birth_year,
        :loc => @birth_location
      },
      :contract => {
        :amount => @contract_amount.to_i,
        :exp => @contract_expiration
      },
      :tid => @team_id,
      :pos => self.output_position,
      :hgt => @height,
      :weight => @weight,
      :offDefK => self.position_group,
      :active => false,
      :name => self.full_name,
      :imgURL => @image_url,
      :freeAgentMood => self.free_agent_mood,
      :yearsFreeAgent => 0,
      :retiredYear => nil,
      :draft => self.draft_details,
      :injury => {
        :type => 'Healthy',
        :gamesRemaining => 0
      },
      :ptModifier => 1,
      :hof => false,
      :watch => false,
      :gamesUntilTradeable => 0,
      :pid => @id
    }
  end

  def self.limit_ratings(rating_value = 0)
    value = rating_value.to_i
    return 100 if (value > 100)
    return 0 if (value < 0)
    return value
  end

end
