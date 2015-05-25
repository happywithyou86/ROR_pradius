# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#Wrapper mobile glitch.
jQuery ->
  $('.wrapper').width($(window).width())
  if($(window).width() < 1190)
  	$('.wrapper').width(1190)

$(window).resize ->
  $('.wrapper').width($(window).width())
  if($(window).width() < 1190)
  	$('.wrapper').width(1190)