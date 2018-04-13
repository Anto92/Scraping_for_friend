require 'rubygems'
require 'nokogiri'   
require 'open-uri'
require 'google_drive'

PAGE_URL = "https://m.investing.com/equities/wacker-chemie"
@i = 0

def crypto_trader
	page = Nokogiri::HTML(open(PAGE_URL))

	stock_price = page.xpath('//*[@id="siteWrapper"]/div[1]/section[2]/div[4]/div[2]/span[1]').text

	session = GoogleDrive::Session.from_config("config.json")

	ws = session.spreadsheet_by_key("13lUynOnK5XUWB0GERw68RL1s_YSKewqb4IjcZSCYoco").worksheets[0]

	ws["A1"] = "Prix actuel"
	ws["B1"] = "Nombre de refreshs"
	ws["A2"] = stock_price		
	ws["B2"] = @i
	ws.save
end

	while true
		crypto_trader
		@i = @i + 1
		sleep 5
	end
