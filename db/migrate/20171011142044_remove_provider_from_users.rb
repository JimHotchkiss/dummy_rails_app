class RemoveProviderFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :provider
  end
end
