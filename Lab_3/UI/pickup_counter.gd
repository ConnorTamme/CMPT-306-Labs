extends Control

var wallet: Wallet
@export var text: RichTextLabel

var formatting: String = "[font_size=20][color=black]" #This stuff allows text in a RichTextLabel
													   #to be formatted however you want

func initialize() -> void:
	assert(wallet)
	wallet.wallet_changed.connect(set_text)
	set_text()
	
func set_text() -> void:
	text.text = formatting + "Pickups: " + str(wallet.num_pickups)
