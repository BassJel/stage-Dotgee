class CreatePops < ActiveRecord::Migration
  def change
    create_table :pops do |t|
      t.string :question
      t.integer :yes, :default => 0
      t.integer :no, :default => 0
    end
  end
end
