
module ApplicationHelper
  
  def pageless(total_pages, url=nil, container=nil)
      opts = {
        :totalPages => total_pages,
        :url        => url,
        :loaderImage => image_path("load.gif")
      }

      container && opts[:container] ||= container
      javascript_tag("$('#results').pageless(#{opts.to_json});")
    end
  def proper_word(comment_text)
  # 	len = 20 
	 # fragment = /.{#{len}}/
	 #  str = comment_text.split(/(\s+)/).map! { |word|
	 #    (/\s/ === word) ? word : word.gsub(fragment, '\0<wbr />')
	 #  }.join
    str =  (h(comment_text).gsub(/\n/, '</br>')).html_safe
  	return str.html_safe
  end

  def user_name_sidebar(user_name)
    str =user_name
    return user_name.gsub(" ", '<br>').html_safe
  end

  def find_zip_code(user)
    zip_code = user.user_location.postal_code
   begin
     result = Geocoder.search("#{zip_code}").first.country_code
    rescue
      if result.present?
         return  result
        elsif result.blank? 
          return false
        end
    end
  end

  def find_country_code(country_name)
     begin
    result= Geocoder.search(country_name).first.country_code
    rescue
      if result.present?
         return  result
        elsif result.blank? 
          return false
        end
    end
  end
  def text_color
    if current_user.present?
      return "gray contact_form_field form_element" 
    else
      return "contact_form_field form_element"
   end
  end
 def advertisement_section(url)
  if  url.include?("/static_pages/contact")
    advertisements =  Advertisement.find_all_by_position("contact_us_page")
  elsif url.include?("/users/edit")
        advertisements =  Advertisement.find_all_by_position("settings_page")
  elsif url.include?("/users/")
    advertisements =  Advertisement.find_all_by_position("owner_profile_page_saved_mode")
  elsif url.include?("/edit_profile")
        advertisements =  Advertisement.find_all_by_position("owner_profile_page_edit_mode")
  elsif url.include?("/contacts/index") 
    advertisements =  Advertisement.find_all_by_position("contacts_main_page")
  elsif url.include?("/forum/index")
     advertisements =  Advertisement.find_all_by_position("groups_main_page")
  elsif  url.include?("/forums/section/") 
    advertisements =  Advertisement.find_all_by_position("groups_title_thread_page")
  elsif  params[:id].present? &&  url.include?("/forums/thread/" + params[:id] + "/new")
        advertisements =  Advertisement.find_all_by_position("groups_suggest_new_thread_page")
  elsif url.include?("/forums/thread/")
    advertisements =  Advertisement.find_all_by_position("groups_detailed_thread_page")
  elsif url.include?("/dashboards/online_poker_room")
    advertisements =  Advertisement.find_all_by_position("dashboard_main_page_online_poker_room_tab")
  elsif url.include?("/dashboards/casino_poker_room")
     advertisements =  Advertisement.find_all_by_position("dashboard_main_page_casino_poker_room_tab")
  elsif url.include?("/dashboards/life_time")
    advertisements =  Advertisement.find_all_by_position("dashboard_main_page_life_time_profit_loss_tab")
  elsif url.include?("/dashboards/charts")
    advertisements =  Advertisement.find_all_by_position("dashboard_main_page_charts_tab")
  elsif url.include?("/dashboards/online_poker_room/edit")
        advertisements =  Advertisement.find_all_by_position("dashboard_edit_online_poker_room_tab")
  elsif url.include?("/dashboards/casino_poker_room/edit")
        advertisements =  Advertisement.find_all_by_position("dashboard_edit_casino_poker_room_tab")
  elsif url.include?("/searches/results")
      advertisements =  Advertisement.find_all_by_position("header_search_results_page")
  elsif url.include?("/users/inbox")
      advertisements =  Advertisement.find_all_by_position("messages_inbox_page")
  elsif url.include?("/users/sent")
      advertisements =  Advertisement.find_all_by_position("messages_sent_page")
  elsif url.include?("/users/trash")
      advertisements =  Advertisement.find_all_by_position("messages_trash_page")
  elsif  params[:prid].present? &&  url.include?("/users/" + params[:prid] )
        advertisements =  Advertisement.find_all_by_position("non_owner_profile_page")
  elsif url.include?("/pending_friends/requests")
    advertisements =  Advertisement.find_all_by_position("connection_requests_page")
  elsif url.include?("/user_plans/new")
    advertisements =  Advertisement.find_all_by_position("upgrade_page")
  elsif url.include?("/user_plans/subscribed")
    advertisements =  Advertisement.find_all_by_position("upgrade_confirmation_page")
  end  
   if !advertisements.blank? 
    advertisements =  advertisements.collect{|p| p if p.country_id == current_user.user_location.country_id}.compact
    else
    advertisements= Advertisement.all
   end
  
   if !advertisements.blank? 
       advertisement = advertisements[rand(advertisements.length)]
     if advertisement.image.url.include?("missing.png")
      return  link_to image_tag('blank-profile.png', width:  '100px', height:  '100px', class:  "img-responsive advertisement_image_other" ), "#{ advertisement.url.include?("http") ? advertisement.url : 'http://'+ advertisement.url }" ,target:"_blank"
     else
       return link_to image_tag(advertisement.image.url, width:  '100px', height:  '000px', class:  "img-responsive advertisement_image_other" ), "#{ advertisement.url.include?("http") ? advertisement.url : 'http://'+ advertisement.url }",target:"_blank"
    end
   else 
     advertisements= Advertisement.all
      advertisement = advertisements[rand(advertisements.length)]
      if !advertisement.nil?

     if advertisement.image.url.include?("missing.png")
      return  link_to image_tag('blank-profile.png', width:  '100px', height:  '100px', class:  "img-responsive advertisement_image_other" ), "#{ advertisement.url.include?("http") ? advertisement.url : 'http://'+ advertisement.url }" ,target:"_blank"
     else
       return link_to image_tag(advertisement.image.url, width:  '100px', height:  '000px', class:  "img-responsive advertisement_image_other" ), "#{ advertisement.url.include?("http") ? advertisement.url : 'http://'+ advertisement.url }",target:"_blank"

     end
   end
   end
  end

  def advertisement_section_1(url)
   advertisements =  Advertisement.find_all_by_position("home_page_spot_1")
    if advertisements.blank? ||  advertisements.nil?
     
       advertisements= Advertisement.all
       advertisement = advertisements[rand(advertisements.length)]
      if !advertisement.blank? ||  !advertisement.nil?
        return advertisement
     end
    else
       advertisement = advertisements[rand(advertisements.length)]
       return advertisement
     
    end
  end

  def advertisement_section_2(url)

      advertisements =  Advertisement.find_all_by_position("home_page_spot_2")
     if advertisements.blank? ||  advertisements.nil?
       home_1_add =  advertisement_section_1(url)
       advertisements= Advertisement.all
          advertisement = advertisements[rand(advertisements.length)]
         if !advertisement.blank? ||  !advertisement.nil?
           return advertisement
         end
     else
        advertisement = advertisements[rand(advertisements.length)]
         return advertisement
     end
  end

  def same_home_add(add_1,add_2)
   advertisements= Advertisement.all - [add_1]
   advertisement = advertisements[rand(advertisements.length)]
   if !advertisement.blank? ||  !advertisement.nil?
     return advertisement
   end
  end

  def check_usa(country_code)
    if country_code == "US"
     return "USA"
    else
     return country_code
    end
  end

  def my_profile_path(user)
    if !user.nil?
      if   user.custom_url.blank?
        return profile_path(user.prid)
      elsif !user.custom_url.blank?
       return profile_path(user.custom_url)
      end
    end
  end

  def add_url_protocol(url)
    !(url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]) ? "http://#{url}" : url
  end 

  def stripe_keys(key)
    # if $request.host == "pradius.herokuapp.com" || ENV['RAILS_ENV'] == "development"
    #   return {"api_key"=>"sk_test_u0elcwNs5nDErlYzYUF3gNJV","public_key"=>"pk_test_TbSKBb1ox79OwXwxVn9L6Qyv"}[key]
    # else  
    #   return {"api_key"=>"sk_live_H1PIjZAHVakuQCYLcruplfmA","public_key"=>"pk_live_EJsB6gVSn0iuRPAzAn26k2Ek"}[key]
    # end
  end
end

def render_title
  return @title if defined?(@title)
  "Poker Radius - Poker Social Network - Online Community"
end