class AddUniqueIndexToProfilesUsername < ActiveRecord::Migration[7.0]
  def change
    add_index :profiles, :username, unique: true
  end
end
