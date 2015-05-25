class Advertisement < ActiveRecord::Base
    belongs_to :country
    validates_presence_of :image
    validates_presence_of :url
    validates_presence_of :country_id
    has_attached_file :image, 
      styles: { small: "64x64", med: "100x100", large: "200x200"},
      :storage => 's3',
      :s3_credentials => {
      :bucket => "AdvertismentImages",
      :access_key_id => "AKIAIL2JJRQ5QJEQFJZA",
      :secret_access_key => "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"
       }




end
