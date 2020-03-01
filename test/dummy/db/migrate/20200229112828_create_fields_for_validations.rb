class CreateFieldsForValidations < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :email, :string

    add_column :companies, :subdomain, :string

    add_column :parts, :legacy_code, :string
    add_column :parts, :size, :string

    add_column :assemblies, :points, :integer
  end
end
