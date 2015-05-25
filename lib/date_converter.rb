class DateConverter
  def self.i_to_date(int)
    years = int / 365

    days_in_new_year = int % 365

    months = days_in_new_year / 30

    "#{years} years, #{months} months"
  end
end