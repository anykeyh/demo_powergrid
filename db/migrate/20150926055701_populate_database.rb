class PopulateDatabase < ActiveRecord::Migration
  def up
    conf = Rails.configuration.database_configuration[Rails.env]
    puts `psql --host #{conf["host"]} -U #{conf["user"]} #{conf["database"]} < "doc/pagila-data.sql"`
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
