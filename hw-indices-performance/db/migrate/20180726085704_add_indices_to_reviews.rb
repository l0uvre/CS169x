class AddIndicesToReviews < ActiveRecord::Migration
  def change
    add_index :reviews, :moviegoer_id
    add_index :reviews, :movie_id
  end
end
