
class Player
  attr_accessor :id, :team_id, :first_name, :last_name, :position, :height, :weight, :image_url, :birth_year, :birth_location, :contract_amount, :contract_expiration, :overall, :speed, :strength, :awareness, :catching, :blocking, :tackle, :stamina, :toughness, :coverage, :athleticism, :game_iq, :aggresiveness, :motor, :passing, :receiving, :def_rush, :kicking, :potential, :endurance, :hands, :draft_year, :draft_team_id, :draft_round, :draft_pick

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

  def set_ratings(speed, strength, endurance, athleticism, height, hands, game_iq, toughness, awareness, aggresiveness, motor, passing, receiving, blocking, def_rush, tackle, coverage, kicking, potential)
    @speed = speed
    @strength = strength
    @endurance = endurance
    @athleticism = athleticism
    @height = height
    @hands = hands
    @game_iq = game_iq
    @toughness = toughness
    @awareness = awareness
    @aggresiveness = aggresiveness
    @motor = motor
    @passing = passing
    @receiving = receiving
    @blocking = blocking
    @def_rush = def_rush,
    @tackle = tackle
    @coverage = coverage
    @kicking = kicking
    @potential = potential
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
      :hgt => @speed,
      :stre => @strength,
      :spd => @endurance,
      :jmp => @athleticism,
      :endu => @height,
      :hnd => @hands,
      :ins => @game_iq,
      :dnk => @toughness,
      :ft => @awareness,
      :fg => @aggresiveness,
      :tp => @motor,
      :blk => @passing,
      :stl => @receiving,
      :drb => @blocking,
      :pss => @def_rush,
      :reb => @tackle,
      :cvr => @coverage,
      :kck => @kicking,
      :pot => @potential
    }]
  end

  def free_agent_mood
    fam = []
    30.times {fam.push(0)}
    return fam
  end

  def default_face
    {
      :head => {
        :id => 0
      },
      :eyebrows => [
        {
          :id => 0,
          :lr => 'l',
          :cx => 135,
          :cy => 250
        },
        {
          :id => 0,
          :lr => 'r',
          :cx => 265,
          :cy => 250
        }
      ],
      :eyes => [
        {
          :id => 3,
          :lr => 'l',
          :cx => 135,
          :cy => 280,
          :angle => 26.341
        },
        {
          :id => 3,
          :lr => 'r',
          :cx => 265,
          :cy => 280,
          :angle => 26.341
        }
      ],
      :nose => {
        :id => 2,
        :lr => 'l',
        :cx => 200,
        :cy => 330,
        :size => 0.017,
        :flip => false
      },
      :mouth => {
        :id => 1,
        :cx => 200,
        :cy => 400
      },
      :hair => {
        :id => 1
      },
      :fatness => 0.0305,
      :color => '74453d',
    }
  end

  def json_format
    {
      # :face => self.default_face,
      :ratings => self.ratings,
      :born => {
        :year => @birth_year,
        :loc => @birth_location
      },
      :contract => {
        :amount => @contract_amount,
        :exp => @contract_expiration
      },
      :tid => @team_id,
      :pos => self.output_position,
      :height => @height,
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

end
