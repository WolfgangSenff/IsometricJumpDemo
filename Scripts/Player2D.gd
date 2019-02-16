extends Sprite

export (NodePath) onready var Player3D
onready var player3d = get_node(Player3D) if Player3D else null

const jump_x = 128
const jump_y = 65
const walk_x = 64
const walk_y = 65 / 2.0

var jump_upper_left = Vector2(-jump_x, -jump_y)
var jump_upper_right = Vector2(jump_x, -jump_y)
var jump_down_right = Vector2(jump_x, jump_y)
var jump_down_left = Vector2(-jump_x, jump_y)

var walk_upper_left = Vector2(-walk_x, -walk_y)
var walk_upper_right = Vector2(walk_x, -walk_y)
var walk_down_right = Vector2(walk_x, walk_y)
var walk_down_left = Vector2(-walk_x, walk_y)

# start is back-upper-left position, 128 x, 65 y
var is_moving = false

func _ready():
    $Tween.connect("tween_started", self, "on_move_begun")
    $Tween.connect("tween_completed", self, "on_move_done")
    
func on_move_begun(th, th1):
    is_moving = true

func on_move_done(th, th1):
    is_moving = false

func _physics_process(delta):
    if !is_moving:
        if Input.is_action_just_pressed("ui_left"):
            player3d.face_left()
            pass
        elif Input.is_action_just_pressed("ui_right"):
            player3d.face_right()
            pass
        
        if Input.is_action_just_pressed("ui_jump"):
            jump()
            player3d.jump()
        
        if Input.is_action_just_pressed("ui_move"):
            walk()
            player3d.walk()
        
func jump():
    if player3d.current_position == 3:
        $Tween.interpolate_property(self, "global_position", self.global_position, self.global_position + jump_upper_left, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.0)
    elif player3d.current_position == 0:
        $Tween.interpolate_property(self, "global_position", self.global_position, self.global_position + jump_upper_right, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.0)
    elif player3d.current_position == 1:
        $Tween.interpolate_property(self, "global_position", self.global_position, self.global_position + jump_down_right, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.0)
    elif player3d.current_position == 2:
        $Tween.interpolate_property(self, "global_position", self.global_position, self.global_position + jump_down_left, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.0)
    $Tween.start()
    
func walk():
    if player3d.current_position == 3:
        $Tween.interpolate_property(self, "global_position", self.global_position, self.global_position + walk_upper_left, 1.2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.0)
    elif player3d.current_position == 0:
        $Tween.interpolate_property(self, "global_position", self.global_position, self.global_position + walk_upper_right, 1.2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.0)
    elif player3d.current_position == 1:
        $Tween.interpolate_property(self, "global_position", self.global_position, self.global_position + walk_down_right, 1.2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.0)
    elif player3d.current_position == 2:
        $Tween.interpolate_property(self, "global_position", self.global_position, self.global_position + walk_down_left, 1.2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.0)
    $Tween.start()