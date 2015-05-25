class AddCountryCodeToCountryTable < ActiveRecord::Migration
  def change
    add_column :countries, :country_code, :string
  end
end
