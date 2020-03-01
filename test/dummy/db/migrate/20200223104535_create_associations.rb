# frozen_string_literal: true

class CreateAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string 'name'
      t.boolean 'active'
      t.integer 'company_id'
    end

    create_table :companies do |t|
      t.integer 'owner'
      t.timestamps
    end

    create_table(:companies_users, id: false) do |t|
      t.references :company
      t.references :user
    end
  end
end
