// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/autocomplete
//= require twitter/bootstrap
//= require raty.min
//= require jquery.jscrollpane
//= require select2
//= require pageless
//= require social-share-button
//= require_tree .

$( document ).ready(function() {
	 $(".premium_button").click(function(){
	 	$('#premium').hide()
	 })
	$('#pending_friend_how_you_know_him_online_poker_room').prop('checked', true);
	
	// Next Previous js	
	$("#contact_previous_button").click(function(){
		setTimeout( function(){ 
				if ($('#main_section .carousel-inner > :nth-child(2)').attr("class")=="friends_list_container item active" || $('#main_section .carousel-inner > :nth-child(2)').attr("class")=="friends_list_container item prev right")
				{
		      		$("#contact_previous_button").hide()
		      		$("#contact_next_button").show()
				}
				else{
		      		$("#contact_previous_button").show()
		      		$("#contact_next_button").show()
				}
			}
		 , 1 );
	});	
	$("#contact_next_button").click(function(){
		setTimeout( function(){ 
			if ($('#main_section .carousel-inner > :last-child').attr("class")=="friends_list_container item active" || $('#main_section .carousel-inner > :last-child').attr("class")=="friends_list_container item next left")
			{	
				$("#contact_next_button").hide()	      		
				$("#contact_previous_button").show()
			}
			else{
	      		$("#contact_next_button").show()
	      		$("#contact_previous_button").show()
			}
			}
		 , 1 );
	});
	$('#new_forum_post').on('submit', function () {
	    $('.disable_click').prop('disabled', true);
	});

});