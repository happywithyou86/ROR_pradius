//Programmed by Kevin O'Flaherty
//  search_friends_field and header_search_bar are exceptions to general rule

inputLimit = 70;
textareaLimit = 1000;
bigtextareaLimit = 4000;
expirienceLimit = 1000;
recommendLimit =250;
achievementLimit =250;
forumtextareaLimit =4000;

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
        else if(this.id == "prid_text_field")
            $(this).attr('maxlength',30);
        else if(this.id == "user_name")
            $(this).attr('maxlength',30);
        else if(this.id == "register_firstname")
            $(this).attr('maxlength',15);
        else if(this.id == "register_lastname")
            $(this).attr('maxlength',15)
        else
    		$(this).attr('maxlength',inputLimit); 	
    });

    $("textarea").each( function(index) {
    	if (this.id == "search_friends_body"){
           $(this).attr('maxlength',bigtextareaLimit);
        }
        if (this.id == "forum_text_area"){
           $(this).attr('maxlength',forumtextareaLimit);
        }
        else{
           $(this).attr('maxlength',textareaLimit);
        }
    });
     
    $(".experience_description_field").each( function(index) {
        $(this).attr('maxlength',expirienceLimit);
    });
    $(".rec_comment_field").each( function(index) {
        $(this).attr('maxlength',recommendLimit);
    });
    $(".achievement_field").each( function(index) {
        $(this).attr('maxlength',achievementLimit);
    });

    
});