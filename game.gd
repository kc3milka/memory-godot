extends Node2D
var symbols = [1, 2, 3, 4, 5, 6, 7, 8]
var board: Array = []
var clone_list: Array = []
var picked_cards: Array = []
var gracz = true
var punkty1 = 0
var punkty2 = 0
func _ready() -> void:

	for i in symbols:
		board.append(symbols[i-1])
		board.append(symbols[i-1])
	board.shuffle()
	print(board)
	clone_cards()

func _process(delta: float) -> void:
	if gracz == true:
		%gracz1.add_theme_color_override("font_color", Color.from_string("#ff2a5f", Color.WHITE))
		%gracz2.add_theme_color_override("font_color", Color.from_string("#FFFFFF", Color.WHITE))
	else:
		%gracz2.add_theme_color_override("font_color", Color.from_string("#ff2a5f", Color.WHITE))
		%gracz1.add_theme_color_override("font_color", Color.from_string("#FFFFFF", Color.WHITE))

func clone_cards():
	for i in board.size():
		var clone = %card.duplicate()
		clone.symbol = board[i]
		clone.position.x = 200 + i * 200
		clone.position.y = 100
		if clone.position.x > 800 and clone.position.y == 100:
			clone.position.x = 200 + (i - 4) * 200
			if clone.position.x > 800:
				clone.position.x = 200 + (i - 8) * 200
				if clone.position.x > 800:
					clone.position.x = 200 + (i - 12) * 200
					clone.position.y += 150
				clone.position.y += 150
			clone.position.y += 150
		clone.card_clicked.connect(_on_card_picked)
		add_child(clone)
		clone_list.append(clone)
		print(clone.symbol)

func _on_card_picked(card_node: Node, card_symbol: int):
	picked_cards.append(card_node)
	card_node.revealed = true
	if picked_cards.size() == 2:
		get_tree().paused = true
		if picked_cards[0].symbol == picked_cards[1].symbol:
			if gracz == true: 
				punkty1+=1
				%gracz1.set_text("Gracz 1:\n" + str(punkty1))
			else: 
				punkty2+=1
				%gracz2.set_text("Gracz 2:\n" + str(punkty2))
		else:
			await get_tree().create_timer(1.0).timeout
			picked_cards[0].revealed = false
			picked_cards[1].revealed = false
			if gracz == true: gracz = false
			else: gracz = true
		await get_tree().create_timer(1.0).timeout
		picked_cards.clear()
		get_tree().paused = false
