class AddOriginalCreatorToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :original_creator, :string, default: ""
  end
end
