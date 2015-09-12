require 'mechanize'

class WebScraper
  attr_accessor :agent

  def initialize()
    @agent = Mechanize.new {|agent| agent.user_agent_alias = 'Mac Safari'}
  end

  def nfl_info(last_name, first_name)
    player_name = "#{first_name} #{last_name}"
    link_name = "#{last_name}, #{first_name}"
    url = "http://www.nfl.com/players/search?category=name&filter=#{player_name}&playerType=current"

    @agent.get(url) do |page|
      name_links = page.links.find {|l| l.text == link_name}
      return nil unless name_links

      player_page = name_links.click

      parsed_info = ''
      birth_year = nil
      birth_place = nil
      player_age = nil
      draft_year = nil
      draft_team = nil
      draft_round = nil
      draft_pick = nil

      if player_page
        if info = player_page.search(".player-info > p:nth-child(4)")
          if info.children[2] != nil
            parsed_info = info.children[2].text.gsub(/\s+/, ' ').strip
            if year_match = parsed_info.match(/(?:(?:19|20)[0-9]{2})/)
              birth_year = year_match[0].strip
            end
            if city_state_match = parsed_info.match(/([a-zA-Z ]+, [a-zA-z ]+)/)
              birth_place = city_state_match[0].strip.gsub(' , ', ', ')
            else
              if place_match = parsed_info.match(/([a-zA-Z ]+)/)
                birth_place = place_match[0].strip
              end
            end
          end
        end

        if player_age_el = player_page.search(".player-info > p:nth-child(3)").children[6]
          player_age = player_age_el.content.gsub("\r\n\t\t\t\t\t\t\r\n\t\t\t\t\t\r\n\t\t\t\t", "").gsub(":", "").strip if player_age_el.content
        end

        photo = player_page.search("#player-bio > div.player-photo > img").attr('src')

        draft_page_link = player_page.links.find {|l| l.href == 'draft' and l.text == 'Draft'}

        if draft_page_link
          draft_page = draft_page_link.click

          if draft_info = draft_page.search("#player-stats-wrapper > h2.draft-header")
            if draft_year_match = draft_info.text.match(/(?:(?:19|20)[0-9]{2})/)
              draft_year = draft_year_match[0].strip
            end
          end
        end
      end

      return photo, parsed_info, player_age, birth_year, birth_place, draft_year
    end
  end

  def team_contract_info(team_name_slug)
    # http://www.spotrac.com/nfl/contracts/arizona-cardinals/

    url = "http://www.spotrac.com/nfl/contracts/#{team_name_slug}/"
    puts "url: #{url}"

    @agent.get(url) do |page|
      # just return the result page, we can parse later
      return page.search("#main > div.teams > table > tbody")
    end
  end

end


