class UserDashboard

  def self.get_chart_data user
    online_total = OnlineTournament.within_a_year_for_user(user) + OnlineCashGame.within_a_year_for_user(user)
    casino_total = CasinoTournament.within_a_year_for_user(user) + CasinoCashGame.within_a_year_for_user(user)
    online_month = OnlineTournament.created_this_month(user) + OnlineCashGame.created_this_month(user)
    casino_month = CasinoTournament.created_this_month(user) + CasinoCashGame.created_this_month(user)

    data = {
      online_total_data: self.monthly_profit_loss(online_total),
      casino_total_data: self.monthly_profit_loss(casino_total),

      online_hours: self.monthly_hours(online_total),
      casino_hours: self.monthly_hours(casino_total),

      largest_online: self.largest_win_loss(online_total),
      largest_casino: self.largest_win_loss(casino_total),

      tourn_online: self.tournament_summary(OnlineTournament.within_a_year_for_user(user)),
      tourn_casino: self.tournament_summary(CasinoTournament.within_a_year_for_user(user)),

      least_online: self.least_profitable_rooms(online_month),
      most_online: self.most_profitable_rooms(online_month),
      least_casino: self.least_profitable_rooms(casino_month),
      most_casino: self.most_profitable_rooms(casino_month)
    }
  end




  def self.life_time life
    self.group_by_month(life).sort
  end

  def self.life_profit life
    life.map(&:win_loss).select {|p| !p.include?("(")}.map(&:to_i).reduce(:+)
  end

  def self.life_loss life
    life.map(&:win_loss).select { |p| p.include?("(") }.map{ |l| -l.gsub(/\D/, '').to_i }.reduce(:+)
    # life.map(&:win_loss).select { |p| p.include?("(") }.map{ |l| l.delete("()").insert(0,'-').to_i }.reduce(:+)
  end

  ################################
  # Total Gain ANd Loss by Month #
  ################################

  def self.monthly_profit_loss data
    grouped = self.group_by_month(data)
    self.transform_profit_loss_for_graph(grouped)

  end

   # Returns necessary format for google charts
  def self.transform_profit_loss_for_graph grouped
    return_array = []

    grouped.each do |key, value|

      current_array = []
      current_array << key.strftime('%b')

      value.map!(&:win_loss).map! do |number|
        if number.include?("(")
          -number.gsub(/\D/, '').to_i
        else
          number.to_i
        end

      end

      prof, loss = value.partition {|x| x > 0}
      prof.reduce(:+) ? current_array << prof.reduce(:+) : current_array << 0
      loss.reduce(:+) ? current_array << loss.reduce(:+) : current_array << 0
      return_array << current_array
    end
    return_array.reverse

  end


  ###########################################
  # Total Hours Played By Month And Average #
  ###########################################

  def self.monthly_hours total
    grouped = self.group_by_month(total)

    return_array = []

    grouped.each do |k, v|
      month = k.strftime('%b')
      hours = self.determineHours(v)
      average = (hours / 30).round(2)

      return_array << [month, hours.round(2), average]

    end

    return_array.reverse

  end


  def self.determineHours objs
    objs.map(&:hours).compact.reduce(:+) + (objs.map(&:minutes).compact.reduce(:+) / 60.0).round(2)
  end

  ##########################
  # Largest Win Worst Loss #
  ##########################

  def self.largest_win_loss total
    grouped = self.group_by_month(total)

    return_array = []

    grouped.each do |k, v|
      month = k.strftime('%b')
      largest_win_loss = self.determineLargestWinLoss(v)
      return_array << [month, largest_win_loss].flatten
    end

    return_array.reverse
  end


  def self.determineLargestWinLoss objs
    mapped = objs.map(&:win_loss)
    mapped.map!{|b| b.gsub(/\D/, '-')}.map!(&:to_i)

    win = mapped.select { |a| a >= 0 }.max || 0
    loss = mapped.select { |a| a <= 0 }.min || 0

    win_obj = objs[mapped.index(win)] if !mapped.index(win).nil?
    win_date = win_obj ? win_obj.tournaments_and_games_date.strftime('%B %e, %Y') : 'N/A'
    win_room = win_obj ? win_obj.location : 'N/A'

    loss_obj = objs[mapped.index(loss)] if !mapped.index(loss).nil?
    loss_date = loss_obj ? loss_obj.tournaments_and_games_date.strftime('%B %e, %Y') : 'N/A'
    loss_room = loss_obj ? loss_obj.location : 'N/A'

    [win, win_date, win_room, loss, loss_date, loss_room]

  end

  ###############################
  # Tournament Winnings Summary #
  ###############################

  def self.tournament_summary tournaments
    grouped = self.group_by_month(tournaments)

    return_array = []
    grouped.each do |k, v|
      month = k.strftime('%b')
      amount = v.count
      tournaments = self.tournaments_in_array(v)
      gross_win = self.life_profit(v) ? self.life_profit(v) : 0
      gross_loss = self.life_loss(v) ? self.life_loss(v) : 0
      total = gross_loss + gross_win
      return_array << [month, amount, tournaments, total]
    end
    return_array.reverse
  end

  def self.tournaments_in_array t_array
    # location instead of title maybe?
    t_array.map { |t| [t.title, t.win_loss,  t.tournaments_and_games_date.nil? ? t.created_at.strftime('%B %e, %Y') : t.tournaments_and_games_date.strftime('%B %e, %Y') ] }
  end



  #########################
  # Poker Room Pie Charts #
  #########################


  # [['Room', 2332]]
  def self.least_profitable_rooms data
    grouped = self.group_and_calculate_win_loss_total(data)
    grouped.sort_by {|key, value| value}[0..3].delete_if{|a| a.last >=0 }
  end

  def self.most_profitable_rooms data
    grouped = self.group_and_calculate_win_loss_total(data)
    grouped.sort_by {|key, value| value}.reverse[0..3].delete_if{|a| a.last < 0 }
  end

  #  helpers
  def self.group_and_calculate_win_loss_total data
    grouped = data.group_by(&:location)
    grouped.update(grouped) do |k,v|
      v = self.calculateTotalWinLoss(v.map!(&:win_loss))
    end
  end

  def self.calculateTotalWinLoss array
    array.map! do |amount|
      amount.include?("(") ? -amount.gsub(/\D/, '').to_i : amount.gsub(/\D/, '').to_i
    end.reduce(:+)
  end



  private
    def self.group_by_month data
     data.group_by{|v| v.tournaments_and_games_date.nil? ? v.created_at.beginning_of_month : v.tournaments_and_games_date.beginning_of_month}

    end
end







