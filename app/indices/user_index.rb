ThinkingSphinx::Index.define :user, :with => :active_record do
  indexes :prid, :sortable => true
  indexes "LOWER(name)", :as => :name, :sortable => true
  indexes user_location.location, :as => :location, :sortable => true
  #indexes favorite_online_site.online_site_id ,:as => :favorite_online_site
  #indexes favorite_casino.casino_id ,:as => :favorite_casino

  end
  