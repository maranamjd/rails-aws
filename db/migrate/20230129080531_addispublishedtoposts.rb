class Addispublishedtoposts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :is_published, :boolean, default: false
  end
end
