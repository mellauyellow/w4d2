class AddStatus < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :status,
      :string, default: "PENDING", null: false
  end
end
