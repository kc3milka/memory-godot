extends StaticBody2D
signal card_clicked(card_node: Node, card_symbol: int)
var symbol = ""
var revealed = false

func _ready() -> void:
	%AnimatedSprite2D.play("default")
	
func reveal():
	revealed = true
	%AnimatedSprite2D.play(str(symbol))
	
func _process(delta: float) -> void:
	if revealed == false:
		%AnimatedSprite2D.play("default")
		
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT and revealed == false:
			card_clicked.emit(self, symbol)
			reveal()
