module DashboardsHelper
  def date_conversion date
    date.strftime("%m/%d/%y")
  end

  def add_dollar_sign amount
    if !amount.blank?
      if amount.include?("$")
        return amount
      else
        return amount.insert(0,'$')
      end
    end
  end

  def format_life_loss amount
    amount.to_s.delete('-').insert(0,'($').insert(-1, ')')
  end

  def calc_month_amount logs
    logs.map(&:win_loss).map do |amount|
      if amount.include?("(")
        amount.delete!("($)").insert(0,'-').to_i
      else
        amount.to_i
      end
    end.reduce(:+)
  end

  def month_loss_format amount
    amount.to_s.delete('-').insert(0, '($').insert(-1, ')')
  end

  def date_time_ago_in_words from_time, to_time
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
      to_time = to_time.to_time if to_time.respond_to?(:to_time)
      distance_in_seconds = ((to_time - from_time).abs).round
      components = []

      %w(year month).each do |interval|
        # For each interval type, if the amount of time remaining is greater than
        # one unit, calculate how many units fit into the remaining time.
        if distance_in_seconds >= 1.send(interval)
          delta = (distance_in_seconds / 1.send(interval)).floor
          distance_in_seconds -= delta.send(interval)
          components << pluralize(delta, interval)
        end
      end

      components.join(", ")

  end

  def dollar_match(amount)
    if !amount.blank?
      if amount.include?("$")
        return amount
      else
       return "$" + amount
      end
    end
  end
end
