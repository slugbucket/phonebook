class CreateSchemaMigrations < ActiveRecord::Migration
  def change
    create_table :schema_migrations, :id => false do |t|
      t.string :version, :null => false, :limit => 255

    end
  end
end
