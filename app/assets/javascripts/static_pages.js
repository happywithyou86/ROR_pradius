$(function() {
	$('div#subject_type').hide()
	if($('.background-color-indicator')[0]) { $('.wrapper').css("background-color","white") };
	$('#issue_type').change(function () {
        var selected_value = this.value;
        if (selected_value=="other")
        {
          $('div#subject_type').show()
        }
        else
        {
          $('div#subject_type').hide()	
        }
       
    });
      
});

