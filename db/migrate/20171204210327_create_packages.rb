class CreatePackages < ActiveRecord::Migration[5.1]
  def change
    create_table :packages do |t|
      t.string :name
      t.string :version
      t.timestamps
    end
    add_index :packages, [:name, :version], unique: true

    # create_table :versions do |t|
    #   t.string :package_name
    #   t.string :number
    #   t.timestamps
    # end
    # add_foreign_key :versions, :packages, column: :package_name, primary_key: :name

    create_table :descriptions do |t|
      t.belongs_to :package, null: false, index: true
      t.string :package_name
      t.datetime :publication
      t.string :title
      t.string :description
      t.string :author
      t.string :authors
      t.string :maintainer
      t.string :maintainers
      t.string :version
      t.timestamps
    end
  end
end
