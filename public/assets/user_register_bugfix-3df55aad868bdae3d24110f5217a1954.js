(function() {
  var nameToFirstandLast, setUpTextConcatination, updateNameField;

  $(document).ready(function() {
    if ((document.getElementById("register_name") != null) && (document.getElementById("register_firstname") != null) && (document.getElementById("register_lastname") != null)) {
      return setUpTextConcatination();
    }
  });

  setUpTextConcatination = function() {
    $("#register_firstname").change(function() {
      return updateNameField();
    });
    $("#register_lastname").change(function() {
      return updateNameField();
    });
    return nameToFirstandLast();
  };

  updateNameField = function() {
    var firstname, lastname;
    firstname = document.getElementById("register_firstname").value;
    lastname = document.getElementById("register_lastname").value;
    if (firstname === "" || lastname === "") {
      return document.getElementById("register_name").value = "";
    } else {
      return document.getElementById("register_name").value = "" + firstname + " " + lastname;
    }
  };

  nameToFirstandLast = function() {
    var array, name;
    name = document.getElementById("register_name").value;
    array = name.split(" ");
    if (array.length === 1) {
      document.getElementById("register_firstname").value = array[0];
    }
    if (array.length > 1) {
      document.getElementById("register_firstname").value = array[0];
      return document.getElementById("register_lastname").value = array[1];
    }
  };

}).call(this);
