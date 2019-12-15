class AddReviewedAndValidatedToAttenances < ActiveRecord::Migration[5.2]
  def change
  	add_column :attendances, :reviewed, :boolean, default: false
  	add_column :attendances, :validated, :boolean, default: false
  end
end
