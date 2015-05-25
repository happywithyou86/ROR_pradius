$(document).ready(function() {
	$('.bubble').hide();
	setBubbleOpenListener();	
});

function setBubbleOpenListener() {
	$('#password_info_bubble').click(function(e) {
		e.stopPropagation();
		console.log("inside open listener");
		e.preventDefault();
		setBubbleCloseListener();
		$('.bubble').show();
		$(this).unbind("click");
		
	});
}

function setBubbleCloseListener() {
	$('.row').click(function(e) {
		e.stopPropagation();
		console.log("inside close listener");
		$('.bubble').hide();
		$(this).unbind("click");
		setBubbleOpenListener();
	});
}