//Programmed by Kevin O'Flaherty
//  search_friends_field and header_search_bar are exceptions to general rule

inputLimit = 70;
textareaLimit = 1000;

$(document).ready( function(){
    $("input").each( function(index) {

    	if(this.id == "search_friends_field")
    		$(this).attr('maxlength',textareaLimit);
    	else if(this.id == "header_search_bar")
    		$(this).attr('maxlength',textareaLimit);
        else if(this.id == "email_login_field")
            $(this).attr('maxlength',50);
        else if(this.id == "password_login_field")
            $(this).attr('maxlength',15);
    	else
    		$(this).attr('maxlength',inputLimit); 	
    });
    $("textarea").each( function(index) {
    	$(this).attr('maxlength',textareaLimit);
    });
});
