#Since there isn't a first an last name field in the model. This code will
#copy text from first and last name fields into register name.
#Ex: name = firstname + " " + lastname

$(document).ready ->
	if document.getElementById("register_name")? && document.getElementById("register_firstname")? && document.getElementById("register_lastname")?
		setUpTextConcatination()

setUpTextConcatination = ->
	$("#register_firstname").change ->
		updateNameField()
	$("#register_lastname").change ->
		updateNameField()
	nameToFirstandLast()

updateNameField = ->
	firstname = document.getElementById("register_firstname").value
	lastname = document.getElementById("register_lastname").value
	if firstname == "" || lastname == ""
		document.getElementById("register_name").value = ""
	else
		document.getElementById("register_name").value = "#{firstname} #{lastname}"

nameToFirstandLast = ->
	name = document.getElementById("register_name").value
	array = name.split(" ");
	if array.length == 1
		document.getElementById("register_firstname").value = array[0]
	if array.length > 1
		document.getElementById("register_firstname").value = array[0]
		document.getElementById("register_lastname").value = array[1]

