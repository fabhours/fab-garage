class CreateArticlesCategories < ActiveRecord::Migration
  # def change
  #   create_table :articles_categories do |t|
  #   end
  # end

  def change
  	create_table :articles_categories, :id => false do |t|
  		t.references :article
  		t.references :category
  	end
  end

  def self.down
  	drop_table :articles_categories
  end

end
