require 'machinist/active_record'

User.blueprint do
  email {"#{sn}@email.com"}
  password { "12345678" }
  password_confirmation { object.password }
end

Team.blueprint do
  # Attributes here
  name {"team_#{sn}" }
end

League.blueprint do
  name { "league_#{sn}" }
  start_date { Time.now }
  end_date   { Time.now + 6.weeks }
end

League.blueprint(:with_teams) do
  name { "league_#{sn}" }
  start_date { Time.now }
  end_date   { Time.now + 6.weeks }
  object.save!
  object.teams << (Team.make!)
  object.teams << (Team.make!)
  object.save!
end

Game.blueprint do
  # Attributes here
end

TeamMember.blueprint do
  # Attributes here
end

LeagueManager.blueprint do
  # Attributes here
end

TeamManager.blueprint do
  # Attributes here
end

GameOfficial.blueprint do
  # Attributes here
end

Location.blueprint do
  name { "location_#{sn}" }
  notes { "note note note #{sn}" }
end
