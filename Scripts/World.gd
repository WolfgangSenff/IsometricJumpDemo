extends Spatial

var current_position = 2
var positions = []

func _ready():
    positions.append($LeftPosition)
    positions.append($FrontPosition)
    positions.append($RightPosition)
    positions.append($BackPosition)
    $Player.rotate_y(deg2rad(180))
    $Player/CharacterMesh/AnimationPlayer.connect("animation_finished", self, "on_animation_finished")
    face_right()

func face_left():
    current_position -= 1
    if current_position < 0:
        current_position = 3
    var current_transform = positions[current_position].transform
    $Camera.transform = current_transform
    
func face_right():
    current_position += 1
    if current_position >= 4:
        current_position = 0
    var current_transform = positions[current_position].transform
    $Camera.transform = current_transform
    
func jump():
    $Player.rotate_y(-90)
    $Player/CharacterMesh/AnimationPlayer.play("jump")

func walk():
    $Player.rotate_y(-90)
    $Player/CharacterMesh/AnimationPlayer.play("walking")
    
func on_animation_finished(anim):
    if anim != "default":
        $Player/CharacterMesh/AnimationPlayer.play("default")
    
    if anim == "walking" or anim == "jump":
        $Player.rotate_y(90)