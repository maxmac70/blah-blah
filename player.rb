
class Player
  attr_reader :id, :team_id, :first_name, :last_name, :position, :height, :weight, :image_url, :birth_year, :birth_location, :contract_amount, :contract_expiration, :overall, :speed, :strength, :awareness, :catching, :blocking, :tackle, :stamina, :toughness, :coverage, :athleticism, :game_iq, :aggresiveness, :motor, :passing, :receiving, :def_rush, :kicking, :potential, :endurance
  attr_writer :id, :team_id, :first_name, :last_name, :position, :height, :weight, :image_url, :birth_year, :birth_location, :contract_amount, :contract_expiration, :overall, :speed, :strength, :awareness, :catching, :blocking, :tackle, :stamina, :toughness, :coverage, :athleticism, :game_iq, :aggresiveness, :motor, :passing, :receiving, :def_rush, :kicking, :potential, :endurance

  def initialize(team_id = 0, first_name = '', last_name = '', position = '', height = nil, weight = nil)
    @team_id = team_id
    @first_name = first_name.strip
    @last_name = last_name.strip
    @position = position.strip.downcase
    @height = 70
    @weight =  200
    @image_url = ''
    @birth_year = 1985
    @birth_location = 'USA'
    @contract_amount = 1000
    @contract_expiration = 2017

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

    if height then
      puts height
      h = height.split("'")
      feet = h[0].to_i
      inches = h[1].to_i
      @height = (feet * 12) + inches
      puts @height
    end

    if weight then

      @weight = weight.to_i
      puts @weight
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
        puts "@position: #{@position}"
        'WTF'
    end
  end

  def position_group
    if ['QB', 'RB', 'WR', 'TE', 'OL'].include?(self.output_position)
      'off'
    elsif ['DL', 'LB', 'CB', 'S'].include?(self.output_position)
      'def'
    else
      'k'
    end
  end

  def draft_details
    details = {
      :round => 0,
      :pick => 0,
      :tid => -1,
      :originalTid => -1,
      :year => 2006,
      :teamName => nil,
      :teamRegion => nil,
      :pot => 75,
      :ovr => 65,
      :skills => []
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

  def json_format
    {
      :face => {
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
      },
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
      :rosterOrder => nil,
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
