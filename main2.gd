extends Node

var plus_button
var remove_button
var save_button

func _ready():
	plus_button = find_node("PlusButton")
	plus_button.connect("pressed", self, "_show_popup")
	remove_button = find_node("RemoveButton")
	remove_button.connect("pressed", self, "_remove_item")
	save_button = find_node("SaveButton")
	save_button.connect("pressed", self, "_add_entry")


func _show_popup():
	find_node("Popup").visible = true

func _add_entry():
	if not validate_link(): return 
	create_entry()
	find_node("Popup").visible = false

func create_entry():
	var entry_packed = load("res://Entry.tscn")
	var entry = entry_packed.instance()
	var entries = find_node("EntriesContainer")
	entries.add_child(entry)
	entry.setup(find_node("WebsiteURL").text)

func validate_link():
	var url_text = find_node("WebsiteURL").text
	for store in Globals.stores:
		if store in url_text:
			return true
	return false

func _remove_item():
	if find_node("EntriesContainer").get_child_count() > 0:
		var pressed_button = find_node("EntriesContainer").get_child(0).group.get_pressed_button()
		if is_instance_valid(pressed_button):
			find_node("EntriesContainer").remove_child(pressed_button)
			pressed_button.queue_free()

func _process(delta):
	## Remove Entry Text if entry detected
	var entries = find_node("EntriesContainer")
	var add_entry_text = find_node("AddItemsText")
	if entries.get_child_count() > 0:
		  add_entry_text.visible = false
	## Debug label
	var debug_label = find_node("DebugLabel")
	if Debug.offline:
		debug_label.text = "MODE: Offline"
	else:
		debug_label.text = "MODE: Online"
	
	
	
