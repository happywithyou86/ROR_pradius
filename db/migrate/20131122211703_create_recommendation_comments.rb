class CreateRecommendationComments < ActiveRecord::Migration
  def change
    create_table :recommendation_comments do |t|
      t.integer :recommendation_id
      t.text :comment

      t.timestamps
    end
  end
end
