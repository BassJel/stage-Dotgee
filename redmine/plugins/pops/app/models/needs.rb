class Needs < ActiveRecord::Base
  
  def needs
    create_table :texts do |t|
      t.string :text
    end
  end

end
