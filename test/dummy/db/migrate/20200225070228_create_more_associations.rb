class CreateMoreAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :name
      t.timestamps
    end
 
    create_table :books do |t|
      t.belongs_to :author
      t.datetime :published_at
      t.timestamps
    end

    create_table :physicians do |t|
      t.string :name
      t.timestamps
    end
  
    create_table :patients do |t|
      t.string :name
      t.timestamps
    end
  
    create_table :appointments do |t|
      t.belongs_to :physician
      t.belongs_to :patient
      t.datetime :appointment_date
      t.timestamps
    end

    create_table :suppliers do |t|
      t.string :name
      t.timestamps
    end
 
    create_table :accounts do |t|
      t.belongs_to :supplier
      t.string :account_number
      t.timestamps
    end
 
    create_table :account_histories do |t|
      t.belongs_to :account
      t.integer :credit_rating
      t.timestamps
    end

    create_table :assemblies do |t|
      t.string :name
      t.timestamps
    end
 
    create_table :parts do |t|
      t.string :part_number
      t.timestamps
    end
 
    create_table :assemblies_parts, id: false do |t|
      t.belongs_to :assembly
      t.belongs_to :part
    end
  end
end
