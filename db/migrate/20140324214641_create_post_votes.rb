class CreatePostVotes < ActiveRecord::Migration
	def change
		create_table :post_votes do |t|

			t.belongs_to :post
			t.belongs_to :user
			t.integer :value

			t.timestamps
		end

		add_index :post_votes, :post_id
		add_index :post_votes, :user_id
	end
end
