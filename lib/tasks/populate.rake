# require 'pg'

# require 'nokogiri'

# require 'open-uri'

# namespace :db do
#   desc "Fill database with sample data"

#   task :populate => :environment do


#     User.create(prid: "1",
#                 name: "Jason",
#                 email: "jason@gmail.com",
#                 password: "password",
#                 confirmed_account: true,
#                 password_confirmation: "password",
#                 online_player: true,
#                 casino_player: true,
#                 year_started_playing_poker: Date.new(2001,2,3)
#     )

#     500.times do
#       User.create!(name: Faker::Name.name,
#                   email: Faker::Internet.email,
#                   password: "password",
#                   confirmed_account: true,
#                   password_confirmation: "password")
#     end

#     200.times do
#       ProfileVisit.create(visitor_id: User.all.sample.id, profile_user_id: User.all.sample.id)
#     end

#     5.times do |n|
#       n += 2
#       #UserLocation.create(user_id: n, postal_code: "30043")
#       if n.odd?
#         UserProfilePicture.create(user_id: n, url: "http://www.wcoomd.org/en/about-us/annual-competitions/~/media/WCO/Public/Global/Images/About%20us/Annual%20competitions/Photo%20competition/2010/France%20%20MAITRE%20ET%20BONS%20ELEVES%20Photo%20Francis%20Roche2.ashx")
#       end
#     end

#   #  PendingFriend.create(requester_id: 7, requestee_id: 1)
#    # PendingFriend.create(requester_id: 8, requestee_id: 1)

#     6.times do |n|
#       Friend.create(user_id: 1, friend_id: n + 2)
#     end

#     100.times do
#       Friend.create(user_id: User.all.sample.id, friend_id: User.all.sample.id)
#     end

#     Casino.create(name: "Mohegan Sun", url: 'http://mohegansun.com/')


# =begin

#     countries = []

#     turn_off = 0

#     ('a'..'z').to_a.each do |term|
#       escaped_term = CGI.escape(term)

#       url = "http://www.pokerpages.com/directory/results.php3?Name=#{escaped_term}&City=&State=0&Country=0&GameCategoryID=0&PokerHouseID=&index=0&submit=Search+Casinos"

#       doc = Nokogiri::HTML(open(url))

#       doc.css('.tournformside-select').each do |input|
#         if input[:name] == "Country" and turn_off == 0
#           turn_off = 1
#           input.css('option').each do |option|
#             countries <<  option[:value]
#           end
#         end
#       end

#       tds = doc.css('.centercontent').css('table').css('td')


#       record_casino_url = ''

#       record_casino_name = ''

#       tds.each do |row|
#         a_tag = row.css('p').css('a')

#         record_casino_name = a_tag.text

#         if a_tag.present?
#           href = a_tag[0]["href"]

#           casino_url = "http://www.pokerpages.com" + href

#           casino_doc = Nokogiri::HTML(open(casino_url))

#           casino_doc.css('.leftcol.photobg').css('a').each do |a_tag|
#             if a_tag.text == ' Website'
#               record_casino_url =  a_tag[:href]
#             end
#           end
#         end

#         Casino.create(name: record_casino_name, url: record_casino_url)
#       end
#     end

# =end

#     # OnlineSite.create(name: "Zynga Poker", url: "http://zynga.com/game/poker")
#     # OnlineSite.create(name: "World Series of Poker (EA)", url: "http://www.ea.com/world-series-of-poker-ios")
#     # OnlineSite.create(name: "Pokerist (Texas Poker)", url: "http://pokerist.com/en/")
#     # OnlineSite.create(name: "XBox WSOP Full House Pro", url: "http://www.wsop.com/xbox-poker/")
#     # OnlineSite.create(name: "Live Ace", url: "https://www.liveace.com")

#     # OnlineSite.create(name: "24poker.com", url: "24poker.com")
#     # OnlineSite.create(name: "24hPoker", url: "24hpoker.com")
#     # OnlineSite.create(name: "32Red Poker", url: "http://www.32red.com/?BTag=32RedBanAff4414")
#     # OnlineSite.create(name: "7 Sultans Poker", url: "http://www.7sultanspoker")
#     # OnlineSite.create(name: "Absolute Poker", url: "http://www.absolutepoker.com")
#     # OnlineSite.create(name: "Action Poker", url: "http://www.actionpokernetwork.com")
#     # OnlineSite.create(name: "AllStar", url: "http://allstarsportsbook.com/poker/")
#     # OnlineSite.create(name: "Allpro", url: "http://allpro.eu/poker")
#     # OnlineSite.create(name: "Americas Card Room", url: "http://www.osga.com/poker/acr.html")
#     # OnlineSite.create(name: "Aspinalls", url: "http://www.aspinalls.com")
#     # OnlineSite.create(name: "Aztec Riches Poker", url: "http://www.aztecrichespoker.com")
#     # OnlineSite.create(name: "Belmont", url: "http://www.belmont.ag/Poker")
#     # OnlineSite.create(name: "Bet 24", url: "https://www.bet24.com")
#     # OnlineSite.create(name: "Bet Direct", url: "http://www.betdirect.com/poker")
#     # OnlineSite.create(name: "Bet at Home", url: "http://www.bet-at-home.com/poker.aspx")
#     # OnlineSite.create(name: "bet365poker", url: "http://poker.bet365.com")
#     # OnlineSite.create(name: "BetFair", url: "http://www.betfairpoker.com")
#     # OnlineSite.create(name: "BetOnBet", url: "http://www.betonbet.com")
#     # OnlineSite.create(name: "BetOnline", url: "http://www.osga.com/poker/betonline.html")
#     # OnlineSite.create(name: "BetonUSA Poker", url: "http://www.betonusa.com/poker/index.php")

#     # OnlineSite.create(name: "Betsson.com", url: "http://www.betsson.com/en/poker")
#     # OnlineSite.create(name: "Bet USA", url: "http://www.betusa.ag/poker")
#     # OnlineSite.create(name: "BLUESQ", url: "http://www.bluesq.com/bluesquare/bspoker/index.shtml")
#     # OnlineSite.create(name: "Bodog", url: "http://bodog.net/")
#     # OnlineSite.create(name: "BookMaker Poker", url: "http://www.bmaker.com/")
#     # OnlineSite.create(name: "Bovada", url: "http://poker.bovada.lv/")
#     # OnlineSite.create(name: "Bowmans", url: "http://www.bowmans.com")
#     # OnlineSite.create(name: "Boylesports Poker", url: "http://www.boylepoker.com")
#     # OnlineSite.create(name: "BreakAway Poker", url: "http://www.breakawaypoker.com")
#     # OnlineSite.create(name: "bwin Poker", url: "http://www.bwin.com")
#     # OnlineSite.create(name: "Cake Poker", url: "http://www.wincake.com/")
#     # OnlineSite.create(name: "Canbet Poker", url: "http://www.canbet.com/site/poker")
#     # OnlineSite.create(name: "Captain Cook's Poker", url: "http://www.captaincookspoker.com")
#     # OnlineSite.create(name: "Carbon Poker", url: "http://www.carbonpoker.ag/")
#     # OnlineSite.create(name: "Caribbean Sun Poker", url: "http://www.sunpoker.com/")
#     # OnlineSite.create(name: "CasualPoker", url: "http://casualpoker.com/")
#     # OnlineSite.create(name: "Casino Club Poker", url: "http://www.casinoclub-poker.com")
#     # OnlineSite.create(name: "Casino.net Poker", url: "http://www.casino.net/en/default.htm")
#     # OnlineSite.create(name: "CDPoker", url: "http://www.cdpoker.com")
#     # OnlineSite.create(name: "Celeb Poker", url: "http://www.celebpoker.com")
#     # OnlineSite.create(name: "City Poker", url: "http://www.citypoker.com")
#     # OnlineSite.create(name: "ClassicPoker", url: "http://www.classicpoker.com")
#     # OnlineSite.create(name: "College Poker Network", url: "http://www.collegepokernetwork.com")
#     # OnlineSite.create(name: "Colosseum Poker", url: "http://www.colosseumpoker.com")

#     # OnlineSite.create(name: "Colt Poker", url: "http://www.coltpoker.com")
#     # OnlineSite.create(name: "Cool Hand Poker", url: "http://www.coolhandpoker.com")
#     # OnlineSite.create(name: "Coral / Eurobet", url: "http://www.coralpoker.com")
#     # OnlineSite.create(name: "Crazy Parrot Poker", url: "http://www.crazyparrotpoker.com")
#     # OnlineSite.create(name: "Cyber Bet Poker", url: "http://www.cyberbetpoker.com")
#     # OnlineSite.create(name: "Delta Poker", url: "http://www.deltapoker.com")
#     # OnlineSite.create(name: "DSI Poker", url: "http://www.betdsi.eu/football-betting?cmpid=18849_8958")
#     # OnlineSite.create(name: "DoylesRoom", url: "https://www.americascardroom.eu")
#     # OnlineSite.create(name: "Duplicate Poker", url: "http://www.duplicatepoker.com")
#     # OnlineSite.create(name: "Easyodds Poker", url: "http://www.easyoddspoker.com")
#     # OnlineSite.create(name: "EmpirePoker", url: "http://www.empirepoker.com")
#     # OnlineSite.create(name: "EPokerRoom", url: "http://www.epokerroom.com")
#     # OnlineSite.create(name: "EuroBet / Coral", url: "http://poker.insidebet.com")
#     # OnlineSite.create(name: "Euro Club Poker", url: "http://www.euroclubpoker.com")
#     # OnlineSite.create(name: "Euro Super Poker", url: "http://www.eurosuperpoker.com")
#     # OnlineSite.create(name: "ExpressPoker", url: "http://www.expresspoker.com")
#     # OnlineSite.create(name: "FabulousPoker", url: "http://www.fabulouspoker.com")
#     # OnlineSite.create(name: "Fair Poker", url: "http://www.fairpoker.com")
#     # OnlineSite.create(name: "Fish Pond Poker", url: "http://www.fishpondpoker.com")
#     # OnlineSite.create(name: "Fortune Poker", url: "http://www.fortunepoker.com")
#     # OnlineSite.create(name: "Francite Poker", url: "http://www.francitepoker.com")
#     # OnlineSite.create(name: "Full Tilt Poker", url: "http://www.fulltiltpoker.com")
#     # OnlineSite.create(name: "GamesGrid Poker", url: "http://www.gamesgrid.com")
#     # OnlineSite.create(name: "Gaming Floor Poker", url: "http://www.gfpoker.com")
#     # OnlineSite.create(name: "GamTrak Poker", url: "http://www.gamtrakpoker.com")
#     # OnlineSite.create(name: "Golden Riviera Poker", url: "http://www.goldenrivierapoker.com")

#     # OnlineSite.create(name: "Golden Tiger Poker", url: "http://www.goldentigerpoker.com")
#     # OnlineSite.create(name: "GoldenPalace", url: "http://www.goldenpalacepoker.com")
#     # OnlineSite.create(name: "Goldenarchpoker", url: "http://www.goldenarchpoker.com")
#     # OnlineSite.create(name: "Grand Bay Poker", url: "http://www.grandbaypoker.com")
#     # OnlineSite.create(name: "HiLife Poker", url: "http://www.hilifepoker.com")
#     # OnlineSite.create(name: "Hog Poker", url: "http://www.hogpoker.com")
#     # OnlineSite.create(name: "HoldemPoker", url: "http://www.holdempoker.com")
#     # OnlineSite.create(name: "Hollywood International", url: "http://www.hollywoodsportsbook.eu/poker")
#     # OnlineSite.create(name: "Hollywood Poker", url: "http://www.hollywoodpoker.com")
#     # OnlineSite.create(name: "HolyCowPoker.com", url: "http://www.holycowpoker.com")
#     # OnlineSite.create(name: "IdolPoker.com", url: "http://www.idolpoker.com")
#     # OnlineSite.create(name: "Imperial Poker", url: "http://www.imperialpoker.com")
#     # OnlineSite.create(name: "InterPoker", url: "http://www.interpoker.com")
#     # OnlineSite.create(name: "Intertops", url: "http://www.intertops.eu/?ispref=intertopsaff&btag=a_5353b_35")
#     # OnlineSite.create(name: "Irisheyespoker.com", url: "http://www.irisheyespoker.com")
#     # OnlineSite.create(name: "Irish Racing", url: "http://www.irishracingpoker.com")
#     # OnlineSite.create(name: "IronDuke", url: "http://www.ironduke.com")
#     # OnlineSite.create(name: "IslandPoker.com", url: "http://www.islandpoker.com")
#     # OnlineSite.create(name: "JetSetPoker.com", url: "http://www.jetsetpoker.com")
#     # OnlineSite.create(name: "JillAnn Poker", url: "http://www.jillannpoker.com")
#     # OnlineSite.create(name: "Juega Poker", url: "http://www.juegapokerya.com")
#     # OnlineSite.create(name: "Juicy Stakes", url: "http://juicystakes.eu/?T=22465&Lang=en")
#     # OnlineSite.create(name: "Ladbrokes Poker", url: "http://www.ladbrokespoker.com")
#     # OnlineSite.create(name: "Lady Rose Poker", url: "http://www.ladyrosepoker.com")
#     # OnlineSite.create(name: "Liberty Poker", url: "http://www.liberty-poker.com")
#     # OnlineSite.create(name: "LinesMaker", url: "http://www.linesmaker.eu")
#     # OnlineSite.create(name: "Littlewoods Poker", url: "http://www.littlewoodspoker.com")
#     # OnlineSite.create(name: "LiveActionPoker", url: "http://www.liveactionpoker.com")
#     # OnlineSite.create(name: "Lock Poker", url: "http://lockpoker.eu/")
#     # OnlineSite.create(name: "London Poker Club", url: "http://www.londonpokerclub.com")
#     # OnlineSite.create(name: "LuckyRiverPoker.com", url: "http://www.luckyriverpoker.com")
#     # OnlineSite.create(name: "Mansion Poker", url: "http://www.mansionpoker.com")
#     # OnlineSite.create(name: "Martinspoker.com", url: "http://www.martinspoker.com")
#     # OnlineSite.create(name: "Mermaid Poker", url: "http://www.mermaidpoker.com")
#     # OnlineSite.create(name: "Mirabelle", url: "http://www.mirabellepoker.com")
#     # OnlineSite.create(name: "MtPoker.com", url: "http://www.mtpoker.com")
#     # OnlineSite.create(name: "My Sportsbook.com", url: "http://www.mysportsbook.ag/poker")
#     # OnlineSite.create(name: "MyTeamPoker.com", url: "http://www.myteampoker.com")
#     # OnlineSite.create(name: "NetPoker24", url: "http://www.netpoker24.com")
#     # OnlineSite.create(name: "New York Poker", url: "http://www.newyorkpoker.com")
#     # OnlineSite.create(name: "No.1 Poker", url: "http://www.no1poker.com/Default.aspx")
#     # OnlineSite.create(name: "Noble Poker", url: "http://www.noblepoker.com")
#     # OnlineSite.create(name: "NordicBet.com", url: "http://www.nordicbet.com")
#     # OnlineSite.create(name: "Nordic Poker", url: "http://www.nordicbet.com/en-us/home_page")
#     # OnlineSite.create(name: "Pacific Poker", url: "http://www.pacificpoker.com")
#     # OnlineSite.create(name: "Paddy Power", url: "http://www.paddypowerpoker.com")
#     # OnlineSite.create(name: "Page 3 Poker", url: "http://www.page3poker.co.uk")
#     # OnlineSite.create(name: "Play Aces", url: "http://www.playersonly.ag/poker/Promotions.php")
#     # OnlineSite.create(name: "Play Web Poker", url: "http://www.playwebpoker.com")
#     # OnlineSite.create(name: "Players Only Poker", url: "http://www.playersonly.ag/poker-welcome?oldurl=y")
#     # OnlineSite.create(name: "Panther Poker", url: "http://www.pantherpoker.com")
#     # OnlineSite.create(name: "ParadisePoker", url: "http://www.paradisepoker.com")
#     # OnlineSite.create(name: "ParBet Poker", url: "http://www.parbet.com/poker/index.php")
#     # OnlineSite.create(name: "ParthenonPoker.com", url: "http://www.parthenonpoker.com")
#     # OnlineSite.create(name: "Party Poker", url: "http://www.partypoker.com")
#     # OnlineSite.create(name: "PayDay Poker", url: "http://www.paydaypoker.com")
#     # OnlineSite.create(name: "Pitbull Poker", url: "http://www.pitbullpoker.com")
#     # OnlineSite.create(name: "PKR", url: "http://www.pkr.com/en/")
#     # OnlineSite.create(name: "PLAYitnowCasino.com", url: "http://www.playitnowcasino.com")
#     # OnlineSite.create(name: "Poker333", url: "http://www.poker333.com")
#     # OnlineSite.create(name: "Pokerbilly", url: "http://www.pokerbilly.com")
#     # OnlineSite.create(name: "Poker in Canada", url: "http://www.pokerincanada.com")
#     # OnlineSite.create(name: "PokerSchoolOnline", url: "http://www.pokerschoolonline.com/")
#     # OnlineSite.create(name: "Planet Poker", url: "http://www.planetpoker.com")
#     # OnlineSite.create(name: "Play 4 Fun Poker.com", url: "http://www.play4funpoker.com")
#     # OnlineSite.create(name: "Play Web Poker", url: "http://www.playwebpoker.com")
#     # OnlineSite.create(name: "PlusPoker.com", url: "http://www.pluspoker.com")
#     # OnlineSite.create(name: "Pockets Rockets Poker", url: "http://www.pocketrocketspoker.com")
#     # OnlineSite.create(name: "Poker Aces Club", url: "http://www.pokeracesclub.com")
#     # OnlineSite.create(name: "PokerChamps.com", url: "http://www.pokerchamps.com")
#     # OnlineSite.create(name: "Pokercity.com", url: "http://www.pokercity.com")
#     # OnlineSite.create(name: "PokerDaddy", url: "http://www.pokerdaddy.com")
#     # OnlineSite.create(name: "Poker Heaven", url: "http://www.pokerheaven.com")
#     # OnlineSite.create(name: "PokerHost", url: "http://www.pokerhost.com/")
#     # OnlineSite.create(name: "Poker Hour", url: "http://www.pokerhour.net")
#     # OnlineSite.create(name: "Poker Kings", url: "http://www.pokerkings.com")
#     # OnlineSite.create(name: "PokerLover.com", url: "http://www.pokerlover.com")
#     # OnlineSite.create(name: "Poker Metro", url: "http://www.pokermetro.com")
#     # OnlineSite.create(name: "Poker Mountain", url: "http://www.pokermountain.com")
#     # OnlineSite.create(name: "PokerNow.com", url: "http://www.pokernow.com")

#     # OnlineSite.create(name: "Poker Ocean", url: "http://www.pokerocean.com")
#     # OnlineSite.create(name: "Poker Piazza", url: "http://www.pokerpiazza.com")
#     # OnlineSite.create(name: "PokerPlaydium.com", url: "http://www.pokerplaydium.com")
#     # OnlineSite.create(name: "PokerPlex", url: "http://www.pokerplex.com")
#     # OnlineSite.create(name: "PokerRoom", url: "http://www.pokerroom.com")
#     # OnlineSite.create(name: "Poker Shootout", url: "http://www.pokershootout.com")
#     # OnlineSite.create(name: "PokerSouls", url: "http://www.pokersouls.com")
#     # OnlineSite.create(name: "PokerStars", url: "http://www.pokerstars.com")
#     # OnlineSite.create(name: "Pokertropolis", url: "http://www.pokertropolis.com")
#     # OnlineSite.create(name: "PokerWorld", url: "http://www.pokerworld.com")
#     # OnlineSite.create(name: "Popular Poker", url: "http://www.popularpoker.com")
#     # OnlineSite.create(name: "PowerPlayer.com", url: "http://www.powerplayer.com")
#     # OnlineSite.create(name: "Prestige-Poker.com", url: "http://www.prestige-poker.com")
#     # OnlineSite.create(name: "Private1Casino.com", url: "http://www.private1casino.com")
#     # OnlineSite.create(name: "Proper Poker", url: "http://www.properpoker.com")
#     # OnlineSite.create(name: "PSTPoker", url: "http://www.pstpoker.com")
#     # OnlineSite.create(name: "Pure Poker", url: "http://www.purepoker.com")
#     # OnlineSite.create(name: "RakebackPoker", url: "http://www.rakebackpoker.com")
#     # OnlineSite.create(name: "readaBet.com", url: "http://www.readabet.com")
#     # OnlineSite.create(name: "Ramblas Poker", url: "http://www.ramblas.ru")
#     # OnlineSite.create(name: "RealPoker.co.uk", url: "http://www.realpoker.co.uk")
#     # OnlineSite.create(name: "Redbet", url: "http://www.redbet.com")
#     # OnlineSite.create(name: "RedKings Poker", url: "http://www.redkings.com")
#     # OnlineSite.create(name: "Red Star Poker", url: "http://www.redstarpoker.com")
#     # OnlineSite.create(name: "Ritz Club London", url: "http://www.theritzclublondon.com")
#     # OnlineSite.create(name: "River Belle Poker", url: "http://www.riverbelle.com")
#     # OnlineSite.create(name: "Roxy Poker", url: "http://www.roxypoker.com")

#     # OnlineSite.create(name: "Royal Blue Poker", url: "http://www.royalbluepoker.com")
#     # OnlineSite.create(name: "Royal Vegas Poker", url: "http://www.royalvegaspoker.com")
#     # OnlineSite.create(name: "SelectPoker.com", url: "http://www.selectpoker.com")
#     # OnlineSite.create(name: "Spin32Poker.com", url: "http://www.spin32poker.com")
#     # OnlineSite.create(name: "Spin Palace Poker", url: "http://www.spinpalacepoker.com")
#     # OnlineSite.create(name: "SportingOdds Poker", url: "http://www.sportingoddspoker.com")
#     # OnlineSite.create(name: "Sport Fanatik", url: "http://www.sportfanatik.com/poker")
#     # OnlineSite.create(name: "Sports.com", url: "http://www.sports.com/poker")
#     # OnlineSite.create(name: "Sportsbetting.ag", url: "http://www.sportsbetting.ag/poker")
#     # OnlineSite.create(name: "Sportsbook.com", url: "http://www.sportsbook.com")
#     # OnlineSite.create(name: "Street Legal Poker", url: "http://www.streetlegalpoker.com")
#     # OnlineSite.create(name: "Sun Poker", url: "http://www.sunpoker.com/")
#     # OnlineSite.create(name: "SuperBook", url: "http://www.superbook.com")
#     # OnlineSite.create(name: "SuperCityPoker.com", url: "http://www.supercitypoker.com")
#     # OnlineSite.create(name: "SuperiorPoker.com", url: "http://www.superiorpoker.com")
#     # OnlineSite.create(name: "TaiwanCasino.com", url: "http://www.taiwancasino.com")
#     # OnlineSite.create(name: "TGF Poker", url: "http://www.tgfpoker.com")
#     # OnlineSite.create(name: "The Platinum Poker Club", url: "http://www.theplatinumpokerclub.com")
#     # OnlineSite.create(name: "ThePokerClub.com", url: "http://www.thepokerclub.com")
#     # OnlineSite.create(name: "ThunderLuck Poker", url: "http://www.thunderluckpoker.com")
#     # OnlineSite.create(name: "Tiger Poker", url: "http://www.tigerpoker.com")
#     # OnlineSite.create(name: "Titan Poker", url: "http://www.titanpoker.com/")
#     # OnlineSite.create(name: "TigerGaming.com", url: "http://www.tigergaming.com")
#     # OnlineSite.create(name: "Total Poker", url: "http://www.totalpoker.com")
#     # OnlineSite.create(name: "Tower Gaming", url: "http://www.towergaming.com")
#     # OnlineSite.create(name: "Trident Poker", url: "http://www.tridentpoker.com")

#     # OnlineSite.create(name: "True Moneygames", url: "http://www.truemoneygames.com")
#     # OnlineSite.create(name: "TruePoker", url: "http://www.truepoker.eu/landings/affiliates/poker/promo6/landing.html")
#     # OnlineSite.create(name: "UK Pokerstars", url: "http://www.ukpokerstars.com")
#     # OnlineSite.create(name: "UKbetting poker", url: "http://www.ukbettingpoker.co.uk")
#     # OnlineSite.create(name: "UK-Poker.co.uk", url: "http://www.uk-poker.co.uk/")
#     # OnlineSite.create(name: "UltimateBet", url: "http://www.ultimatebet.com")
#     # OnlineSite.create(name: "Unibet", url: "http://www.unibet.com")
#     # OnlineSite.create(name: "Vegas Queens Poker", url: "http://www.vegasqueenspoker.com")
#     # OnlineSite.create(name: "VCPoker", url: "http://www.vcpoker.com")
#     # OnlineSite.create(name: "VaeioPoker.com", url: "http://www.valeiopoker.com")
#     # OnlineSite.create(name: "Victory Poker", url: "http://www.victorypoker.com")
#     # OnlineSite.create(name: "Vikingbet Poker", url: "http://www.vikingbetpoker.com")
#     # OnlineSite.create(name: "VIPpoker", url: "http://www.vip.com/?skin=poker")
#     # OnlineSite.create(name: "Virgin", url: "http://www.virgingames.com/poker")
#     # OnlineSite.create(name: "Virtual City Poker", url: "http://www.virtualcitypoker.com")
#     # OnlineSite.create(name: "Wasspoker", url: "http://www.wasspoker.com")
#     # OnlineSite.create(name: "Walkerpoker", url: "http://www.walkerpoker.com")
#     # OnlineSite.create(name: "Wild Jack Poker", url: "http://www.wildjackcasino.com/")
#     # OnlineSite.create(name: "William Hill Poker", url: "http://www.williamhillpoker.com")
#     # OnlineSite.create(name: "World Poker Exchange", url: "http://www.wsex.com/poker")
#     # OnlineSite.create(name: "WPoker.com", url: "http://www.pooker.com")



#     # FavoriteCasino.create(user_id: 1, casino_id: 1)

#     # FavoriteOnlineSite.create(user_id: 1, online_site_id: 1)

#     # 20.times do
#     #   FavoriteOnlineSite.create(user_id: User.all.sample.id, online_site_id: 1)
#     #   FavoriteCasino.create(user_id: User.all.sample.id, casino_id: 1)
#     # end

#     30.times do
#       model = [UserProfilePicture, Endorsement, Friend, User, Recommendation].sample.to_s

#       ActivityComment.create(klass_name: model, klass_id: rand(5), user_id: rand(1..10), comment: SecureRandom.hex)
#     end

#     Forum.create(name: "GENERAL POKER DISCUSSION")
#     Forum.create(name: "RESULTS AND VARIANCE")
#     Forum.create(name: "ONLINE POKER")
#     Forum.create(name: "THE PLAYER'S LOUNGE")

#     ForumSection.create( forum_id: 1, name: "General Poker Discussion",
#                          description: "Want to talk about the ins and outs of the poker world? Then this is the forum for you.")
#     ForumSection.create( forum_id: 1, name: "Results and Variance",
#                          description: "Vent and rant about your bad beats, coolers and downswings, or boast about your big scores and successful runs here")
#     ForumSection.create( forum_id: 1, name: "Conspiracies, Scandals, and Scammers",
#                          description: "Here you will find the latest information on poker scandals, cheating methods, and known poker cheaters and scammers, along with the usual online poker is rigged debate.")
#     ForumSection.create( forum_id: 1, name: "Poker News, Opinions, and Rumors",
#                          description: "This forum is where to find all the latest rumors and news in the poker world. Feel free to offer you opinions or knowledge on the latest breaking stories in poker here.")
#     ForumSection.create( forum_id: 1, name: "Poker Tube",
#                          description: "In here you'll find poker videos ranging from televised poker shows to parody videos.")

#     100.times do
#       ForumThread.create(name: Faker::Lorem.words.join(" "),
#                          user_id: User.all.to_a.sample.id,
#                          forum_section_id: [1,2,3,4].sample)
#     end

#     1000.times do
#       ForumPost.create(user_id: User.all.to_a.sample.id, forum_thread_id: ForumThread.all.sample.id, message: Faker::Lorem.paragraph)
#     end

#     countries =Country.all
#     countries.each do |country|
#     country.delete
#     end

#     # America is always #1
#     Country.create(name: "United States"  photo_name: "flags/United_States_of_America.png")

  
#     Country.create(name: "Afghanistan", photo_name: "flags/Afghanistan.png")
#     Country.create(name: "Albania", photo_name: "flags/Albania.png")
#     Country.create(name: "Algeria", photo_name: "flags/Algeria.png")
#     Country.create(name: "American Samoa", photo_name: "flags/American_Samoa.png")
#     Country.create(name: "Andorra", photo_name: "flags/Andorra.png")
#     Country.create(name: "Angola", photo_name: "flags/Angola.png")
#     Country.create(name: "Anguilla", photo_name: "flags/Anguilla.png")
#     Country.create(name: "Antigua and Barbuda", photo_name: "flags/Antigua_and_Barbuda.png")
#     Country.create(name: "Argentina", photo_name: "flags/Argentina.png")
#     Country.create(name: "Armenia", photo_name: "flags/Armenia.png")
#     Country.create(name: "Aruba", photo_name: "flags/Aruba.png")
#     Country.create(name: "Australia", photo_name: "flags/Australia.png")
#     Country.create(name: "Austria", photo_name: "flags/Austria.png")
#     Country.create(name: "Azerbaijan", photo_name: "flags/Azerbaijan.png")
#     Country.create(name: "Bahamas", photo_name: "flags/Bahamas.png")
#     Country.create(name: "Bahrain", photo_name: "flags/Bahrain.png")
#     Country.create(name: "Bangladesh", photo_name: "flags/Bangladesh.png")
#     Country.create(name: "Barbados", photo_name: "flags/Barbados.png")
#     Country.create(name: "Belarus", photo_name: "flags/Belarus.png")
#     Country.create(name: "Belgium", photo_name: "flags/Belgium.png")
#     Country.create(name: "Belize", photo_name: "flags/Belize.png")
#     Country.create(name: "Benin", photo_name: "flags/Benin.png")
#     Country.create(name: "Bermuda", photo_name: "flags/Bermuda.png")
#     Country.create(name: "Bhutan", photo_name: "flags/Bhutan.png")
#     Country.create(name: "Bolivia", photo_name: "flags/Bolivia.png")
#     Country.create(name: "Bosnia", photo_name: "flags/Bosnia.png")
#     Country.create(name: "Botswana", photo_name: "flags/Botswana.png")
#     Country.create(name: "Brazil", photo_name: "flags/Brazil.png")
#     Country.create(name: "British Virgin Islands", photo_name: "flags/British_Virgin_Islands.png")
#     Country.create(name: "Brunei", photo_name: "flags/Brunei.png")
#     Country.create(name: "Bulgaria", photo_name: "flags/Bulgaria.png")
#     Country.create(name: "Burkina Faso", photo_name: "flags/Burkina_Faso.png")
#     Country.create(name: "Burundi", photo_name: "flags/Burundi.png")
#     Country.create(name: "Cambodia", photo_name: "flags/Cambodia.png")
#     Country.create(name: "Cameroon", photo_name: "flags/Cameroon.png")
#     Country.create(name: "Canada", photo_name: "flags/Canada.png")
#     Country.create(name: "Cape Verde", photo_name: "flags/Cape_Verde.png")
#     Country.create(name: "Cayman Islands", photo_name: "flags/Cayman_Islands.png")
#     Country.create(name: "Central African Republic", photo_name: "flags/Central_African_Republic.png")
#     Country.create(name: "Chad", photo_name: "flags/Chad.png")
#     Country.create(name: "Chile", photo_name: "flags/Chile.png")
#     Country.create(name: "China", photo_name: "flags/China.png")
#     Country.create(name: "Christmas Island", photo_name: "flags/Christmas_Island.png")
#     Country.create(name: "Colombia", photo_name: "flags/Colombia.png")
#     Country.create(name: "Comoros", photo_name: "flags/Comoros.png")
#     Country.create(name: "Cook Islands", photo_name: "flags/Cook_Islands.png")
#     Country.create(name: "Costa Rica", photo_name: "flags/Costa_Rica.png")
#     Country.create(name: "Croatia", photo_name: "flags/Croatia.png")
#     Country.create(name: "Cuba", photo_name: "flags/Cuba.png")
#     Country.create(name: "Cyprus", photo_name: "flags/Cyprus.png")
#     Country.create(name: "Czech Republic", photo_name: "flags/Czech_Republic.png")
#     Country.create(name: "Cote d'Ivoire", photo_name: "flags/Cote_d'Ivoire.png")
#     Country.create(name: "Democratic Republic of the Congo", photo_name: "flags/Democratic_Republic_of_the_Congo.png")
#     Country.create(name: "Denmark", photo_name: "flags/Denmark.png")
#     Country.create(name: "Djibouti", photo_name: "flags/Djibouti.png")
#     Country.create(name: "Dominica", photo_name: "flags/Dominica.png")
#     Country.create(name: "Dominican Republic", photo_name: "flags/Dominican_Republic.png")
#     Country.create(name: "Ecuador", photo_name: "flags/Ecuador.png")
#     Country.create(name: "Egypt", photo_name: "flags/Egypt.png")
#     Country.create(name: "El Salvador", photo_name: "flags/El_Salvador.png")
#     Country.create(name: "Equatorial Guinea", photo_name: "flags/Equatorial_Guinea.png")
#     Country.create(name: "Eritrea", photo_name: "flags/Eritrea.png")
#     Country.create(name: "Estonia", photo_name: "flags/Estonia.png")
#     Country.create(name: "Ethiopia", photo_name: "flags/Ethiopia.png")

#     Country.create(name: "Falkland Islands", photo_name: "flags/Falkland_Islands.png")
#     Country.create(name: "Faroe Islands", photo_name: "flags/Faroe_Islands.png")
#     Country.create(name: "Fiji", photo_name: "flags/Fiji.png")
#     Country.create(name: "Finland", photo_name: "flags/Finland.png")
#     Country.create(name: "France", photo_name: "flags/France.png")
#     Country.create(name: "French Polynesia", photo_name: "flags/French_Polynesia.png")
#     Country.create(name: "Gabon", photo_name: "flags/Gabon.png")
#     Country.create(name: "Gambia", photo_name: "flags/Gambia.png")
#     Country.create(name: "Georgia", photo_name: "flags/Georgia.png")
#     Country.create(name: "Germany", photo_name: "flags/Germany.png")
#     Country.create(name: "Ghana", photo_name: "flags/Ghana.png")
#     Country.create(name: "Gibraltar", photo_name: "flags/Gibraltar.png")
#     Country.create(name: "Greece", photo_name: "flags/Greece.png")
#     Country.create(name: "Greenland", photo_name: "flags/Greenland.png")
#     Country.create(name: "Grenada", photo_name: "flags/Grenada.png")
#     Country.create(name: "Guam", photo_name: "flags/Guam.png")
#     Country.create(name: "Guatemala", photo_name: "flags/Guatemala.png")
#     Country.create(name: "Guinea", photo_name: "flags/Guinea.png")
#     Country.create(name: "Guinea Bissau", photo_name: "flags/Guinea_Bissau.png")
#     Country.create(name: "Guyana", photo_name: "flags/Guyana.png")
#     Country.create(name: "Haiti", photo_name: "flags/Haiti.png")
#     Country.create(name: "Honduras", photo_name: "flags/Honduras.png")
#     Country.create(name: "Hong Kong", photo_name: "flags/Hong_Kong.png")
#     Country.create(name: "Hungary", photo_name: "flags/Hungary.png")

#     Country.create(name: "Iceland", photo_name: "flags/Iceland.png")
#     Country.create(name: "India", photo_name: "flags/India.png")
#     Country.create(name: "Indonesia", photo_name: "flags/Indonesia.png")
#     Country.create(name: "Iran", photo_name: "flags/Iran.png")
#     Country.create(name: "Iraq", photo_name: "flags/Iraq.png")
#     Country.create(name: "Ireland", photo_name: "flags/Ireland.png")
#     Country.create(name: "Israel", photo_name: "flags/Israel.png")
#     Country.create(name: "Italy", photo_name: "flags/Italy.png")
#     Country.create(name: "Jamaica", photo_name: "flags/Jamaica.png")
#     Country.create(name: "Japan", photo_name: "flags/Japan.png")
#     Country.create(name: "Jordan", photo_name: "flags/Jordan.png")
#     Country.create(name: "Kazakhstan", photo_name: "flags/Kazakhstan.png")
#     Country.create(name: "Kenya", photo_name: "flags/Kenya.png")
#     Country.create(name: "Kiribati", photo_name: "flags/Kiribati.png")
#     Country.create(name: "Kuwait", photo_name: "flags/Kuwait.png")
#     Country.create(name: "Kyrgyzstan", photo_name: "flags/Kyrgyzstan.png")
#     Country.create(name: "Laos", photo_name: "flags/Laos.png")
#     Country.create(name: "Latvia", photo_name: "flags/Latvia.png")
#     Country.create(name: "Lebanon", photo_name: "flags/Lebanon.png")
#     Country.create(name: "Lesotho", photo_name: "flags/Lesotho.png")
#     Country.create(name: "Liberia", photo_name: "flags/Liberia.png")
#     Country.create(name: "Libya", photo_name: "flags/Libya.png")
#     Country.create(name: "Liechtenstein", photo_name: "flags/Liechtenstein.png")
#     Country.create(name: "Lithuania", photo_name: "flags/Lithuania.png")
#     Country.create(name: "Luxembourg", photo_name: "flags/Luxembourg.png")
#     Country.create(name: "Macao", photo_name: "flags/Macao.png")
#     Country.create(name: "Macedonia", photo_name: "flags/Macedonia.png")
#     Country.create(name: "Madagascar", photo_name: "flags/Madagascar.png")
#     Country.create(name: "Malawi", photo_name: "flags/Malawi.png")

#     Country.create(name: "Malaysia", photo_name: "flags/Malaysia.png")
#     Country.create(name: "Maldives", photo_name: "flags/Maldives.png")
#     Country.create(name: "Mali", photo_name: "flags/Mali.png")
#     Country.create(name: "Malta", photo_name: "flags/Malta.png")
#     Country.create(name: "Marshall Islands", photo_name: "flags/Marshall_Islands.png")
#     Country.create(name: "Martinique", photo_name: "flags/Martinique.png")
#     Country.create(name: "Mauritania", photo_name: "flags/Mauritania.png")
#     Country.create(name: "Mauritius", photo_name: "flags/Mauritius.png")
#     Country.create(name: "Mexico", photo_name: "flags/Mexico.png")
#     Country.create(name: "Micronesia", photo_name: "flags/Micronesia.png")
#     Country.create(name: "Moldova", photo_name: "flags/Moldova.png")
#     Country.create(name: "Monaco", photo_name: "flags/Monaco.png")
#     Country.create(name: "Mongolia", photo_name: "flags/Mongolia.png")
#     Country.create(name: "Montserrat", photo_name: "flags/Montserrat.png")
#     Country.create(name: "Morocco", photo_name: "flags/Morocco.png")
#     Country.create(name: "Mozambique", photo_name: "flags/Mozambique.png")
#     Country.create(name: "Myanmar", photo_name: "flags/Myanmar.png")
#     Country.create(name: "Namibia", photo_name: "flags/Namibia.png")
#     Country.create(name: "Nauru", photo_name: "flags/Nauru.png")
#     Country.create(name: "Nepal", photo_name: "flags/Nepal.png")
#     Country.create(name: "Netherlands", photo_name: "flags/Netherlands.png")
#     Country.create(name: "Netherlands Antilles", photo_name: "flags/Netherlands_Antilles.png")
#     Country.create(name: "New Zealand", photo_name: "flags/New_Zealand.png")
#     Country.create(name: "Nicaragua", photo_name: "flags/Nicaragua.png")
#     Country.create(name: "Niger", photo_name: "flags/Niger.png")
#     Country.create(name: "Nigeria", photo_name: "flags/Nigeria.png")
#     Country.create(name: "Niue", photo_name: "flags/Niue.png")
#     Country.create(name: "Norfolk Island", photo_name: "flags/Norfolk_Island.png")
#     Country.create(name: "Norway", photo_name: "flags/Norway.png")
#     Country.create(name: "Oman", photo_name: "flags/Oman.png")
#     Country.create(name: "Pakistan", photo_name: "flags/Pakistan.png")

#     Country.create(name: "Palau", photo_name: "flags/Palau.png")
#     Country.create(name: "Panama", photo_name: "flags/Panama.png")
#     Country.create(name: "Papua New Guinea", photo_name: "flags/Papua_New_Guinea.png")
#     Country.create(name: "Paraguay", photo_name: "flags/Paraguay.png")
#     Country.create(name: "Peru", photo_name: "flags/Peru.png")
#     Country.create(name: "Philippines", photo_name: "flags/Philippines.png")
#     Country.create(name: "Pitcairn Islands", photo_name: "flags/Pitcairn_Islands.png")
#     Country.create(name: "Poland", photo_name: "flags/Poland.png")
#     Country.create(name: "Portugal", photo_name: "flags/Portugal.png")
#     Country.create(name: "Puerto Rico", photo_name: "flags/Puerto_Rico.png")
#     Country.create(name: "Qatar", photo_name: "flags/Qatar.png")
#     Country.create(name: "Republic of the Congo", photo_name: "flags/Republic_of_the_Congo.png")
#     Country.create(name: "Romania", photo_name: "flags/Romania.png")
#     Country.create(name: "Russian Federation", photo_name: "flags/Russian_Federation.png")
#     Country.create(name: "Rwanda", photo_name: "flags/Rwanda.png")
#     Country.create(name: "Saint Kitts and Nevis", photo_name: "flags/Saint_Kitts_and_Nevis.png")
#     Country.create(name: "Saint Lucia", photo_name: "flags/Saint_Lucia.png")
#     Country.create(name: "Saint Pierre", photo_name: "flags/Saint_Pierre.png")
#     Country.create(name: "Saint Vicent and the Grenadines", photo_name: "flags/Saint_Vicent_and_the_Grenadines.png")
#     Country.create(name: "Samoa", photo_name: "flags/Samoa.png")
#     Country.create(name: "San Marino", photo_name: "flags/San_Marino.png")
#     Country.create(name: "Sao Tome and Principe", photo_name: "flags/Sao_Tome_and_Principe.png")
#     Country.create(name: "Saudi Arabia", photo_name: "flags/Saudi_Arabia.png")
#     Country.create(name: "Senegal", photo_name: "flags/Senegal.png")
#     Country.create(name: "Serbia and Montenegro", photo_name: "flags/Serbia_and_Montenegro.png")
#     Country.create(name: "Seychelles", photo_name: "flags/Seychelles.png")
#     Country.create(name: "Sierra Leone", photo_name: "flags/Sierra_Leone.png")
#     Country.create(name: "Singapore", photo_name: "flags/Singapore.png")
#     Country.create(name: "Slovakia", photo_name: "flags/Slovakia.png")
#     Country.create(name: "Slovenia", photo_name: "flags/Slovenia.png")

#     Country.create(name: "Soloman Islands", photo_name: "flags/Soloman_Islands.png")
#     Country.create(name: "Somalia", photo_name: "flags/Somalia.png")
#     Country.create(name: "South Africa", photo_name: "flags/South_Africa.png")
#     Country.create(name: "South Georgia", photo_name: "flags/South_Georgia.png")
#     Country.create(name: "South Korea", photo_name: "flags/South_Korea.png")
#     Country.create(name: "Spain", photo_name: "flags/Spain.png")
#     Country.create(name: "Sri Lanka", photo_name: "flags/Sri_Lanka.png")
#     Country.create(name: "Sudan", photo_name: "flags/Sudan.png")
#     Country.create(name: "Suriname", photo_name: "flags/Suriname.png")
#     Country.create(name: "Swaziland", photo_name: "flags/Swaziland.png")

#     Country.create(name: "Sweden", photo_name: "flags/Sweden.png")
#     Country.create(name: "Switzerland", photo_name: "flags/Switzerland.png")
#     Country.create(name: "Syria", photo_name: "flags/Syria.png")
#     Country.create(name: "Taiwan", photo_name: "flags/Afghanistan.png")
#     Country.create(name: "Tajikistan", photo_name: "flags/Tajikistan.png")
#     Country.create(name: "Tanzania", photo_name: "flags/Tanzania.png")
#     Country.create(name: "Thailand", photo_name: "flags/Thailand.png")
#     Country.create(name: "Tibet", photo_name: "flags/Tibet.png")
#     Country.create(name: "Timor-Leste", photo_name: "flags/Timor-Leste.png")
#     Country.create(name: "Togo", photo_name: "flags/Togo.png")
#     Country.create(name: "Tonga", photo_name: "flags/Tonga.png")
#     Country.create(name: "Trinidad and Tobago", photo_name: "flags/Trinidad_and_Tobago.png")
#     Country.create(name: "Tunisia", photo_name: "flags/Tunisia.png")
#     Country.create(name: "Turkey", photo_name: "flags/Turkey.png")
#     Country.create(name: "Turkmenistan", photo_name: "flags/Turkmenistan.png")
#     Country.create(name: "Turks and Caicos Islands", photo_name: "flags/Turks_and_Caicos_Islands.png")

#     Country.create(name: "Tuvalu", photo_name: "flags/Tuvalu.png")
#     Country.create(name: "UAE", photo_name: "flags/UAE.png")
#     Country.create(name: "Uganda", photo_name: "flags/Uganda.png")
#     Country.create(name: "Ukraine", photo_name: "flags/Ukraine.png")
#     Country.create(name: "United Kingdom", photo_name: "flags/United_Kingdom.png")
#     Country.create(name: "Uruguay", photo_name: "flags/Uruguay.png")
#     Country.create(name: "US Virgin Islands", photo_name: "flags/US_Virgin_Islands.png")
#     Country.create(name: "Uzbekistan", photo_name: "flags/Uzbekistan.png")
#     Country.create(name: "Vanuatu", photo_name: "flags/Vanuatu.png")
#     Country.create(name: "Vatican City", photo_name: "flags/Vatican_City.png")
#     Country.create(name: "Venezuela", photo_name: "flags/Venezuela.png")
#     Country.create(name: "Vietnam", photo_name: "flags/Vietnam.png")
#     Country.create(name: "Wallis and Futuna", photo_name: "flags/Wallis_and_Futuna.png")
#     Country.create(name: "Yemen", photo_name: "flags/Yemen.png")
#     Country.create(name: "Zambia", photo_name: "flags/Zambia.png")
#     Country.create(name: "Zimbabwe", photo_name: "flags/Zimbabwe.png")

#   end
# end

