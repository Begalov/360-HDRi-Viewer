extends Node3D

func _ready():
	get_tree().get_root().files_dropped.connect(_on_files_dropped)

func _on_files_dropped(files):
	var path = files[0]
	var image = Image.new()
	var err = image.load(path)
	if err != OK:
		pass
	var texture = ImageTexture.create_from_image(image)
	$Control/Label.text = path
	$WorldEnvironment.environment.sky.sky_material.panorama = texture
	$TrackballCamera.set_rotation(Vector3())


func _on_v_slider_mouse_entered():
	$TrackballCamera.mouse_enabled = false


func _on_v_slider_mouse_exited():
	$TrackballCamera.mouse_enabled = true


func _on_v_slider_value_changed(value):
	var A1 = 16
	var B1 = 1
	var A2 = 0
	var B2 = 1
	
	if value > 50:
		value = value / 50
		value = -A1 * (1 - value) + B1 * value
	else:
		value = value / 50
		value = A2 * (1 - value) + B2 * value

	$WorldEnvironment.environment.set_bg_energy_multiplier(value)
	$Control/Label2.text = 'Exposure: ' + str(value)



