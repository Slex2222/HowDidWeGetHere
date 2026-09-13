@tool
extends EditorPlugin

var Dock: VBoxContainer


var LocationTitle: Label
var LocationInput: LineEdit
var LocationBrowser: Button
var FolderDialog: FileDialog

var NameTitle: Label
var NameInput: LineEdit
var CreateButton: Button

var Alert: AcceptDialog

func _enter_tree() -> void:
	Dock = VBoxContainer.new()
	Dock.name = "Instance Creator"
	
	LocationTitle = Label.new()
	LocationTitle.text = "Path Selector"
	Dock.add_child(LocationTitle)
	
	LocationInput = LineEdit.new()
	LocationInput.text = "res://Instances/"
	Dock.add_child(LocationInput)
	
	LocationBrowser = Button.new()
	LocationBrowser.text = "Select Parrent Folder"
	LocationBrowser.pressed.connect(OpenFolderBrowser)
	Dock.add_child(LocationBrowser)
	var Spacer = Control.new()
	Spacer.custom_minimum_size.y = 20
	Dock.add_child(Spacer)
	
	NameTitle = Label.new()
	NameTitle.text = "Name Selector"
	Dock.add_child(NameTitle)
	
	NameInput = LineEdit.new()
	NameInput.placeholder_text = "Input Instance Name..."
	Dock.add_child(NameInput)
	
	CreateButton = Button.new()
	CreateButton.text = "Create Instance"
	CreateButton.pressed.connect(CreateInstance)
	Dock.add_child(CreateButton)
	
	FolderDialog = FileDialog.new()
	FolderDialog.file_mode = FileDialog.FILE_MODE_OPEN_DIR
	FolderDialog.access = FileDialog.ACCESS_RESOURCES
	FolderDialog.dir_selected.connect(FolderSelected)
	
	Dock.add_child(FolderDialog)
	
	Dock.add_theme_constant_override("separation", 5)
	
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, Dock)

func _exit_tree():
	remove_control_from_docks(Dock)
	Dock.free()

func CreateInstance() -> void:
	var Path = LocationInput.text.strip_edges()
	var InstanceName = NameInput.text.strip_edges()
	
	if Path.is_empty():
		Alert = AcceptDialog.new()
		Alert.title = "Error: Path unusable."
		Alert.dialog_text = "Select a usable path. Input another if its empty or nonexistent."
		Dock.add_child(Alert)
		
		Alert.popup_centered() 
		return
	
	if InstanceName.is_empty():
		Alert = AcceptDialog.new()
		Alert.title = "Error: Instance Name unusable"
		Alert.dialog_text = "Select a usable Name. Input one if its empty."
		Dock.add_child(Alert)
		
		Alert.popup_centered() 
		return
	
	var InstancePath = Path + "/" + InstanceName
	
	var Folders := [
		"Assets",
		"Sounds",
		"Scripts",
		"Scenes"
	]
	
	var ScriptTypes := [
		"Custom components",
		"Custom States",
		"Master Script"
	]
	
	DirAccess.make_dir_recursive_absolute(
		ProjectSettings.globalize_path(InstancePath)
	)
	
	for Folder in Folders:
		var FolderPath = InstancePath + "/" + Folder
		
		DirAccess.make_dir_recursive_absolute(
			ProjectSettings.globalize_path(FolderPath)
		)
		
		CreateGitKeep(FolderPath)
	
	for ScriptType in ScriptTypes:
		var ScriptTypePath = InstancePath + "/Scripts/" + ScriptType
		
		DirAccess.make_dir_recursive_absolute(
			ProjectSettings.globalize_path(ScriptTypePath)
		)
		
		CreateGitKeep(ScriptTypePath)
	
	EditorInterface.get_resource_filesystem().scan()
	
	Alert = AcceptDialog.new()
	Alert.title = "Succes: Added" + InstanceName
	Alert.dialog_text = "Succesfully created the inserted instance"
	Dock.add_child(Alert)
	
	Alert.popup_centered() 

func FolderSelected(path: String):
	LocationInput.text = path

func OpenFolderBrowser():
	FolderDialog.popup_centered_ratio()

func CreateGitKeep(BasePath):
	var GitkeepPath = BasePath + "/.gitkeep" 
	var File := FileAccess.open(GitkeepPath, FileAccess.WRITE)
	File.close()
