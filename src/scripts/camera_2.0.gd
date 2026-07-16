extends Camera2D
 
@export var zoomSpeed : float = 10;
@export var panSpeed : float = 3;
@onready var bee_hole: Sprite2D = %BeeHole
@onready var panel: Panel = $"../../UILayer/UIRoot/Panel"

var zoomTarget 

var dragMousePos = Vector2.ZERO
var dragCameraPos = Vector2.ZERO
var isDragging : bool = false;

func _ready():
	zoomTarget = zoom
	global_position = Vector2(bee_hole.global_position.x + (panel.size.x / 2), bee_hole.global_position.y)
	

func _process(delta):
	Zoom(delta)
	SimplePan(delta)
	ClickAndDrag()
	
func Zoom(delta):
	#Contols Camera Zoom
	if Input.is_action_just_pressed("Zoom In"):
		zoomTarget *= 1.1
	
	if Input.is_action_just_pressed("Zoom Out"):
		zoomTarget *= 0.9
	
	zoom = zoom.slerp(zoomTarget, zoomSpeed * delta)

func SimplePan(delta):
	#moves camera with wasd
	var panAmount = Vector2.ZERO
	if Input.is_action_pressed("Camera Up"):
		position.y -= panSpeed
	if Input.is_action_pressed("Camera Down"):
		position.y += panSpeed
	if Input.is_action_pressed("Camera Left"):
		position.x -= panSpeed
	if Input.is_action_pressed("Camera Right"):
		position.x += panSpeed
	
	#controls speed of pan
	#Faster while closer and slower while farhter away
	panAmount = panAmount.normalized()
	position += panAmount * delta * 1000 * (1/zoom.x)
	
func ClickAndDrag():
	#Pans the camera with mouse and click
	if !isDragging and Input.is_action_just_pressed("Pan"):
		dragMousePos = get_viewport().get_mouse_position()
		dragCameraPos = position
		isDragging = true
	
	if isDragging and Input.is_action_just_released("Pan"):
		isDragging = false
		
	if isDragging:
		var moveVector = get_viewport().get_mouse_position() - dragMousePos
		position =  dragCameraPos - moveVector * 1/zoom.x
