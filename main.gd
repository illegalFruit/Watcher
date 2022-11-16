extends Node

#Load from .txt saved items 
#Generate saved items and continue checking every X time 

var addTrackerBtn = null

var popup = null 
var website = null 
var url = null
var itemName = null
var cancel = null
var save = null
var itemScene = preload("res://ItemContainer.tscn")
var itemsArray = {}
var timer = Timer.new()

var sitesToCheck = []


func _ready():
	pass
#	timer.connect("timeout",self,"check_site")
#	timer.wait_time = 10
#	timer.one_shot = false
#	add_child(timer)
#	timer.start()
#
#	addTrackerBtn = find_node("AddTracker")
#	popup = find_node("Popup")
#	website = find_node("inptWebsite") 
#	url = find_node("inputURL")
#	itemName = find_node("inptName")
#	cancel = find_node("btnCancel")
#	save = find_node("btnSave")
#
#	addTrackerBtn.connect("pressed", self, "_add_pressed")
#	cancel.connect("pressed", self, "_cancel_pressed")
#	save.connect("pressed", self, "_save_pressed")
#	$HTTPRequest.connect("request_completed", self, "_on_request_completed")

func _add_pressed():
	popup.visible = true

func _cancel_pressed():
	popup.visible = false
	website = null
	url = null
	itemName = null
	
func _save_pressed():
	## Should check validity of inputs 
#	itemName = find_node("inptName")
#	website = find_node("inptWebsite")
#	url = find_node("inputURL")
#	## Create the item banner and input values
#	var a = itemScene.instance()
#	## Pass vars 
#	a.find_node("Label").text = itemName.text
#	find_node("ItemBox").add_child(a)
	sitesToCheck.append(find_node("inputURL"))

	popup.visible = false
	website = null
	url = null
	itemName = null
	
func check_site():
	for s in sitesToCheck:
		$HTTPRequest.request(s)


func _on_request_completed(result, response_code, headers, body):
	print("Response: ", response_code, " Megabytes: ", float(body.size()) / 1000000.0)
	var a = body.get_string_from_ascii()
	## Check if the Out of stock flag is located in the string
	#if "Temporarily Out of Stock" in a: return 
	## Else the stock must be in- grab the price. Sloppy implementation
	a = a.split("pricingPrice")[1]
	a = a.split("<")[0]
	a = a.split(">")[1]
	print(a)
	
var r = find_node("refresh")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	##find_node("refresh").text = str(timer.time_left)
