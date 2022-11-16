extends Node

var url
#var product = find_node("ProductLabel")
#var merch = find_node("MerchLabel")
#var status = find_node("StatusLabel")
 

func _ready():
	pass
	# $HTTPRequest.connect("request_completed", self, "_on_request_completed")
	
func setup(_url):

	var html = yield(get_page(), "completed")

	var parsed = parse_page(html)
	find_node("ProductLabel").text = parsed["name"]
	find_node("MerchLabel").text = parsed["site"]
	find_node("PriceLabel").text = parsed["price"]



func get_page():

	var path = "C:/Users/flr/Desktop/bh.html"
	var file = File.new()
	file.open(path, File.READ)
	var text = file.get_as_text()
	file.close()
	## This would be a yield waiting for the signal of html completition thatd 
	## happen prior, above
	yield(get_tree().create_timer(3.0), "timeout")
	return text

func parse_page(html):
	## <div data-selenium="pricingPrice">$478.99</div>
	## <span data-selenium="stockStatus">In Stock</span>
	## <h1 data-selenium="productTitle">ASUS Radeon RX 6800 XT TUF GAMING Graphics Card</h1>
	## ERROR CHECKING SHOULD BE INCLUDED HERE
	## Get Price, stock, site, product name
	var whole = html 
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
	print(name)
	name = name.split(">", false, 1)[1]
	name = name.split("<", false, 1)[0]
	print(name)
	
	var site = ""
	if "bh-app" in whole:
		site = "bhphotovideo"
	print(site)
	return {
		"price":price,
		"stock":stock,
		"name":name,
		"site":site
	}
