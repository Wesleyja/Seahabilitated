class AddCoordinatesToSurfboards < ActiveRecord::Migration[5.2]
  def change
    add_column :surfboards, :latitude, :float
    add_column :surfboards, :longitude, :float
  end
end
