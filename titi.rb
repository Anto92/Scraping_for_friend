require 'rubygems'
require 'nokogiri'   
require 'open-uri'
require 'spreadsheet'

PAGE_URL = "https://m.investing.com/equities/wacker-chemie"

def crypto_trader
	page = Nokogiri::HTML(open(PAGE_URL))

	stock_price = page.xpath('//*[@id="siteWrapper"]/div[1]/section[2]/div[4]/div[2]/span[1]').text

	Spreadsheet.client_encoding = 'UTF-8'
	workbook = Spreadsheet::Workbook.new

	worksheet = workbook.create_worksheet
	worksheet[0,0] = ("Prix actuel")
	worksheet[0,1] = ("nombre de refreshs")
	i = 0

	while true
		worksheet[1,0] = (stock_price)		
		worksheet[1,1] = (i)
		workbook.write  Dir.pwd + '/le-nom-que-tu-veux-donner-a-ton-fichier-excel.xls'
		i = i + 1
		sleep 30
	end
end

crypto_trader
