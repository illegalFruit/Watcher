extends Node

func _ready():
	find_node("HTTPRequest").connect("request_completed", self, "_http_request_completed")

func setup(url):
	## For debugging purposes, do different things here if testing 
	if Debug.offline:
		var html = yield(get_page_offline(filename), "completed")
		var parsed = parse_page(html, url)
		find_node("ProductLabel").text = parsed["name"]
		find_node("MerchLabel").text = parsed["site"]
		find_node("PriceLabel").text = parsed["price"]
	else:
		var html = get_page_online(url) # this should give an error as theres no yield
		var parsed = parse_page(html, url)
		find_node("ProductLabel").text = parsed["name"]
		find_node("MerchLabel").text = parsed["site"]
		find_node("PriceLabel").text = parsed["price"]

func get_page_online(url):
	var error = find_node("HTTPRequest").request("https://www.webpagetest.org/")

func _http_request_completed(result, response_code, headers, body):
	var a = body.get_string_from_ascii()

func get_page_offline(filename):
	var path = "C:/Users/flr/Desktop/filename.html"
	var file = File.new()
	file.open(path, File.READ)
	var text = file.get_as_text()
	file.close()
	## This would be a yield waiting for the signal of html completition thatd 
	## happen prior, above
	yield(get_tree().create_timer(3.0), "timeout")
	return text

func parse_page(html, url):
	## ERROR CHECKING SHOULD BE INCLUDED HERE
	## Get Price, stock, site, product name
	var whole = html
	var _site = ""
	for site in Globals.stores:
		if site in whole:
			_site = site
			break

	if _site == "bhphotovideo.com":
		var price = whole.split("pricingPrice", true, 1)[1]
		price = price.substr(0,20)
		price = price.split(">", false, 1)[1]
		price = price.split("<", false, 1)[0]

		var stock = whole.split("stockStatus", true, 1)[1]
		stock = stock.substr(0,60)
		stock = stock.split(">", false, 1)[1]
		stock = stock.split("<", false, 1)[0]

		var name = whole.split("productTitle", true, 1)[1]
		name = name.substr(0,400)
		name = name.split(">", false, 1)[1]
		name = name.split("<", false, 1)[0]
	elif _site == "newegg.com":
		print(whole)
	
	return {
#		"price":price,
#		"stock":stock,
#		"name":name,
#		"site":_site
		"price":0,
		"stock":0,
		"name":0,
		"site":0
	}
