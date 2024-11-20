extends Node3D

var selected_character_scene: String = ""  # 選択されたキャラクターのシーンパス

@onready var button_1 = $UI/Button1
@onready var button_2 = $UI/Button2
@onready var start_button = $UI/StartButton



func _ready():
	# ボタンのシグナルをメソッドに接続
	$UI/Button1.connect("pressed", Callable(self, "_on_button1_pressed"))
	$UI/Button2.connect("pressed", Callable(self, "_on_button2_pressed"))
	$UI/StartButton.connect("pressed", Callable(self, "_on_start_button_pressed"))

# キャラクター1を選択
func _on_button1_pressed():
	selected_character_scene = "res://characters/Character1.tscn"

# キャラクター2を選択
func _on_button2_pressed():
	selected_character_scene = "res://characters/Character2.tscn"

# ゲーム開始ボタンが押されたとき
func _on_start_button_pressed():
	if selected_character_scene != "":
		spawn_character(selected_character_scene, Vector3(0, 0, 0))
		button_1.hide()
		button_2.hide()
		start_button.hide()
	else:
		print("キャラクターが選択されていません！")

# キャラクターを生成する
func spawn_character(character_scene_path: String, spawn_position: Vector3):
	print("ロードするシーンパス: ", character_scene_path)  # デバッグ用

	var character_scene = load(character_scene_path)
	if character_scene == null:
		print("エラー: キャラクターシーンがロードできません: ", character_scene_path)
		return

	var character_instance = character_scene.instantiate()
	character_instance.global_transform.origin = spawn_position
	add_child(character_instance)

	# キャラクター内のカメラをアクティブに設定
	var character_camera = character_instance.get_node("Camera3D")  # キャラクター内のCamera3D
	if character_camera:
		character_camera.current = true
