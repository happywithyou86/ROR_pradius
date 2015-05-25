$(document).ready(function() {
	$('.bubble').hide();
	setBubbleOpenListener();	
});

function setBubbleOpenListener() {
	$('#password_info_bubble').click(function(e) {
		e.stopPropagation();
		console.log("inside open listener");
		e.preventDefault();
		$('.bubble').slideDown();
		$(this).unbind("click");
		setBubbleCloseListener();
	});
}

function setBubbleCloseListener() {
	$('.row').click(function(e) {
		e.stopPropagation();
		console.log("inside close listener");
		$('.bubble').slideUp();
		$(this).unbind("click");
		setBubbleOpenListener();
	});
}
;
