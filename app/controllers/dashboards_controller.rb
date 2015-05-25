class DashboardsController < ApplicationController
  before_action :redirect_non_signed_in_user

  before_action :data_for_side_bar

  before_action :redirect_non_premium_user

  def index
  end


  # Online Poker Room
  def online_poker_room
    @highlight = current_user.online_highlight

    @tournaments = current_user.online_tournaments.sort_by(&:tournaments_and_games_date)
    @cash_logs = current_user.online_cash_games.sort_by(&:tournaments_and_games_date)

    @edit =false
  end

  def online_poker_room_edit
    @highlight = OnlineHighlight.where(user_id: current_user.id).first

    @poker_rooms = OnlineSite.all.map(&:name).uniq
    @tournaments = current_user.online_tournaments.sort_by(&:tournaments_and_games_date)
    @cash_logs = current_user.online_cash_games.sort_by(&:tournaments_and_games_date)

    @edit =true
  end

  def online_edit
    highlight = OnlineHighlight.where(user_id: current_user).first
    highlight.update_attributes(highlight_params)
    redirect_to dash_online_poker_path
  end


  #  Casino Poker Room
  def casino_poker_room
    @highlight = current_user.casino_highlight

    @tournaments = current_user.casino_tournaments.sort_by(&:tournaments_and_games_date)
    @cash_logs = current_user.casino_cash_games.sort_by(&:tournaments_and_games_date)
  end

  def casino_poker_room_edit

    @highlight = CasinoHighlight.where(user_id: current_user.id).first

    @poker_rooms =  Casino.all.map(&:name).uniq
    @tournaments = current_user.casino_tournaments.sort_by(&:tournaments_and_games_date)
    @cash_logs = current_user.casino_cash_games.sort_by(&:tournaments_and_games_date)
  end

  def casino_edit
    highlight = CasinoHighlight.where(user_id: current_user).first
    highlight.update_attributes(highlight_params)
    redirect_to dash_casino_poker_path
  end


  # Both Highlight Best Hand

  def highlight_best_hand
    if params[:klass] == 'OnlineHighlight'
      current_user.online_highlight.cards.destroy_all
      params[:cardIds].values.each { |c| current_user.online_highlight.cards << Card.find(c) }
      render json: render_to_string( :partial => '/dashboards/best_hand_span', :locals => {:cards => current_user.online_highlight.cards} ).to_json, status: :ok
    else
      current_user.casino_highlight.cards.destroy_all
      params[:cardIds].values.each { |c| current_user.casino_highlight.cards << Card.find(c) }
      render json: render_to_string( :partial => '/dashboards/best_hand_span', :locals => {:cards => current_user.casino_highlight.cards} ).to_json, status: :ok

    end
  end


  # Both Tournament Update

  def tournament_log_edit
   if  params[:tournament_id].present?  &&  params[:type] == 'online'
    online_tournament =    OnlineTournament.find(params[:tournament_id])
    if !params[:tournLog][:tournaments_and_games_date].blank?
      mm =  params[:tournLog][:tournaments_and_games_date].split("/")[0]
      dd =params[:tournLog][:tournaments_and_games_date].split("/")[1]
      yy= params[:tournLog][:tournaments_and_games_date].split("/")[2]
      if !mm.blank? && !dd.blank?  && !yy.blank? 
       params[:tournLog][:tournaments_and_games_date] = dd+"/" + mm + "/" + yy
      else
        params[:tournLog][:tournaments_and_games_date] =  params[:tournLog][:tournaments_and_games_date]
      end

    else
     params[:tournLog][:tournaments_and_games_date] = Date.today
    end
    log = online_tournament.update_attributes(tourn_log_params)

      if log
        log =  OnlineTournament.find(params[:tournament_id])
        log.cards.delete_all
        if  params[:cardIds].present?
          params[:cardIds].values.each { |c| log.cards << Card.find(c) }
        end
        render :json => render_to_string( :partial => '/dashboards/tournament_log_row', :locals => {:tourn => log,:edit=>true} ).to_json, status: :ok

      else
        render :json => {failed: true}, status: :ok
      end 
   elsif params[:type] == 'online' && !params[:tournament_id].present? 
     if !params[:tournLog][:tournaments_and_games_date].blank?
      mm =  params[:tournLog][:tournaments_and_games_date].split("/")[0]
      dd =params[:tournLog][:tournaments_and_games_date].split("/")[1]
      yy= params[:tournLog][:tournaments_and_games_date].split("/")[2]
      params[:tournLog][:tournaments_and_games_date] = dd+"/" + mm + "/" + yy
     else
      params[:tournLog][:tournaments_and_games_date] = Date.today
     end

     log = current_user.online_tournaments.create(tourn_log_params)

      if log.save
       params[:cardIds].values.each { |c| log.cards << Card.find(c) }
       render :json => render_to_string( :partial => '/dashboards/tournament_log_row', :locals => {:tourn => log,:edit=>true} ).to_json , status: :ok

     else
       render :json => {failed: true}, status: :ok
     end
   end

  if  params[:tournament_id].present?  &&  params[:type] == 'casino'
    online_tournament =    CasinoTournament.find(params[:tournament_id])
     if !params[:tournLog][:tournaments_and_games_date].blank?
      mm =  params[:tournLog][:tournaments_and_games_date].split("/")[0]
      dd =params[:tournLog][:tournaments_and_games_date].split("/")[1]
      yy= params[:tournLog][:tournaments_and_games_date].split("/")[2]
       if !mm.blank? && !dd.blank?  && !yy.blank?   
         params[:tournLog][:tournaments_and_games_date] = dd+"/" + mm + "/" + yy
       else
         params[:tournLog][:tournaments_and_games_date] = params[:tournLog][:tournaments_and_games_date] 
       end
     else
      params[:tournLog][:tournaments_and_games_date] = Date.today
     end

    log = online_tournament.update_attributes(tourn_log_params)

      if log
        log =  CasinoTournament.find(params[:tournament_id])
        log.cards.delete_all
        if  params[:cardIds].present?
          params[:cardIds].values.each { |c| log.cards << Card.find(c) }
        end
        render :json => render_to_string( :partial => '/dashboards/tournament_log_row', :locals => {:tourn => log,:edit=>true} ).to_json, status: :ok
      else
        render :json => {failed: true}, status: :ok
      end 
   elsif params[:type] == 'casino' && !params[:tournament_id].present? 

    if params[:tournLog][:tournaments_and_games_date].blank?
      params[:tournLog][:tournaments_and_games_date] = Date.today
    
     else
      mm =  params[:tournLog][:tournaments_and_games_date].split("/")[0]
      dd =params[:tournLog][:tournaments_and_games_date].split("/")[1]
      yy= params[:tournLog][:tournaments_and_games_date].split("/")[2]
      params[:tournLog][:tournaments_and_games_date] = dd +"/" + mm + "/" + yy
      
     end
       log = current_user.casino_tournaments.create(tourn_log_params)
     if log.save
       params[:cardIds].values.each { |c| log.cards << Card.find(c) }
       render :json => render_to_string( :partial => '/dashboards/tournament_log_row', :locals => {:tourn => log,:edit=>true} ).to_json, status: :ok
     else
       render :json => {failed: true}, status: :ok
     end
   end


  end

  # Both Cash Log Update

  def cash_log_edit

    if  params[:type] == 'online'  && params[:cash_game_id].present?
      online_casino_game =    OnlineCashGame.find(params[:cash_game_id])
      if !params[:cashLog][:tournaments_and_games_date].blank?
       mm =  params[:cashLog][:tournaments_and_games_date].split("/")[0]
       dd =params[:cashLog][:tournaments_and_games_date].split("/")[1]
       yy= params[:cashLog][:tournaments_and_games_date].split("/")[2]
        if !mm.blank? && !dd.blank?  && !yy.blank?   
          params[:cashLog][:tournaments_and_games_date] = dd+"/" + mm + "/" + yy
        else
          params[:cashLog][:tournaments_and_games_date] =  params[:cashLog][:tournaments_and_games_date] 
        end
      else
      params[:cashLog][:tournaments_and_games_date] = Date.today
      end
      log = online_casino_game.update_attributes(cash_log_params)
      if log
        log =  OnlineCashGame.find(params[:cash_game_id])
        log.cards.delete_all

        if params[:cardIds].present?
          params[:cardIds].values.each { |c| log.cards << Card.find(c) }
        end 
        render :json => render_to_string( :partial => '/dashboards/cash_log_row', :locals => {:log => log,:edit=>true} ).to_json, status: :ok
      else
        render :json => {failed: true}, status: :ok
      end 
    elsif params[:type] == 'online' && !params[:cash_game_id].present?
      if !params[:cashLog][:tournaments_and_games_date].blank?
       mm =  params[:cashLog][:tournaments_and_games_date].split("/")[0]
       dd =params[:cashLog][:tournaments_and_games_date].split("/")[1]
       yy= params[:cashLog][:tournaments_and_games_date].split("/")[2]
       params[:cashLog][:tournaments_and_games_date] = dd+"/" + mm + "/" + yy
      else
       params[:cashLog][:tournaments_and_games_date] = Date.today
      end
        log = current_user.online_cash_games.create(cash_log_params)

      if log.save
        params[:cardIds].values.each { |c| log.cards << Card.find(c) }
        render :json => render_to_string( :partial => '/dashboards/cash_log_row', :locals => {:log => log,:edit=>true} ).to_json, status: :ok
      else
        render :json => {failed: true}, status: :ok
      end
   end
   if   params[:type] == 'casino' && params[:cash_game_id].present?
     casino_casino_game =    CasinoCashGame.find(params[:cash_game_id])
      if !params[:cashLog][:tournaments_and_games_date].blank?
       mm =  params[:cashLog][:tournaments_and_games_date].split("/")[0]
       dd =params[:cashLog][:tournaments_and_games_date].split("/")[1]
       yy= params[:cashLog][:tournaments_and_games_date].split("/")[2]

       if !mm.blank? && !dd.blank?  && !yy.blank?   
         params[:cashLog][:tournaments_and_games_date] = dd+"/" + mm + "/" + yy
       else
         params[:cashLog][:tournaments_and_games_date] = params[:cashLog][:tournaments_and_games_date] 
       end
      else
        params[:cashLog][:tournaments_and_games_date] = Date.today
      end
      log = casino_casino_game.update_attributes(cash_log_params)
      if log
        log =  CasinoCashGame.find(params[:cash_game_id])
        log.cards.delete_all

        if params[:cardIds].present?
          params[:cardIds].values.each { |c| log.cards << Card.find(c) }
        end 
        render :json => render_to_string( :partial => '/dashboards/cash_log_row', :locals => {:log => log,:edit=>true} ).to_json, status: :ok
      else
        render :json => {failed: true}, status: :ok
      end 
   elsif   params[:type] == 'casino' && !params[:cash_game_id].present?
      if !params[:cashLog][:tournaments_and_games_date].blank?
       mm =  params[:cashLog][:tournaments_and_games_date].split("/")[0]
       dd =params[:cashLog][:tournaments_and_games_date].split("/")[1]
       yy= params[:cashLog][:tournaments_and_games_date].split("/")[2]
       if !mm.blank? && !dd.blank?  && !yy.blank?   
          params[:cashLog][:tournaments_and_games_date] = dd+"/" + mm + "/" + yy
        else
          params[:cashLog][:tournaments_and_games_date] =  params[:cashLog][:tournaments_and_games_date] 
        end
      else
       params[:cashLog][:tournaments_and_games_date] = Date.today
      end

        log = current_user.casino_cash_games.create(cash_log_params)
      if log.save
        params[:cardIds].values.each { |c| log.cards << Card.find(c) }
        render :json => render_to_string( :partial => '/dashboards/cash_log_row', :locals => {:log => log,:edit=>true} ).to_json, status: :ok
      else
        render :json => {failed: true}, status: :ok
      end

    end
  end




  # Life_time
  def life_time
    life = current_user.online_tournaments + current_user.online_cash_games + current_user.casino_tournaments + current_user.casino_cash_games
    @life_time = UserDashboard.life_time(life)

    @life_profit = UserDashboard.life_profit(life) || 0
    @life_loss = UserDashboard.life_loss(life) || 0

  end

  # Charts

  def charts
    @chart_data = UserDashboard.get_chart_data(current_user)
  end

  def online_tournament_edit_form

  @poker_rooms = OnlineSite.all.map(&:name) + Casino.all.map(&:name)

   if  params[:type] == "casino"

     tournament = CasinoTournament.find(params[:tournId])
   else
     tournament = OnlineTournament.find(params[:tournId])
   end
    render json: { partial: render_to_string( partial: '/dashboards/tournament_edit', locals: { tournament_id: tournament.id,tournament: tournament} ), id: tournament.id }, status: :ok
  end

  def online_cash_edit_form
       @poker_rooms = OnlineSite.all.map(&:name) + Casino.all.map(&:name)
   if  params[:type] == "casino"
     cash_log = CasinoCashGame.find(params[:cashId])
   else
    cash_log = OnlineCashGame.find(params[:cashId])

   end
     render json: { partial: render_to_string( partial: '/dashboards/cash_log_edit', locals: { cash_log_id: cash_log.id,cash_log: cash_log } ), id: cash_log.id }, status: :ok
  
  end

  def tournament_log_delete
    if  params[:type] == "online"
      id = params[:tournLog]
      OnlineTournament.find(id).destroy
      render json: {id: id}, status: :ok
    else
      id = params[:tournLog]
      CasinoTournament.find(id).destroy
      render json: {id: id}, status: :ok
    end
  end

   def cash_log_delete
      if  params[:type] == "online"
        id = params[:cashLog]
        OnlineCashGame.find(id).destroy
        render json: {id: id}, status: :ok
      else
        id = params[:cashLog]
        CasinoCashGame.find(id).destroy
        render json: {id: id}, status: :ok
      end
   end

  private
    def data_for_side_bar
      @data = UserProfile.get(current_user.prid, current_user)
    end

    def highlight_params
      params.require(:highlight).permit!
    end

    def tourn_log_params
      params.require(:tournLog).permit!
    end

    def cash_log_params
      params.require(:cashLog).permit!
    end
end
