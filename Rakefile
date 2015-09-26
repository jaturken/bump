
namespace :db do
  require './config/initializers/db.rb'
  Sequel.extension :migration

  desc "Prints current schema version"
  task :version do
    version = if DB.tables.include?(:schema_info)
      DB[:schema_info].first[:version]
    end || 0
  puts "Schema Version: #{version}"
  end

  desc "Perform migration up to latest migration available"
  task :migrate do
    Sequel::Migrator.run(DB, "db/migrations")
    Rake::Task['db:version'].execute
  end

  desc "Perform rollback to specified target or full rollback as default"
  task :rollback, :target do |t, args|
    args.with_defaults(:target => 0)
    Sequel::Migrator.run(DB, "db/migrations", :target => args[:target].to_i)
    Rake::Task['db:version'].execute
  end

  desc "Perform migration reset (full rollback and migration)"
  task :reset do
    Sequel::Migrator.run(DB, "db/migrations", :target => 0)
    Sequel::Migrator.run(DB, "db/migrations")
    Rake::Task['db:version'].execute
  end

  desc 'Generate  empty Sequel migration.'
  task :generate_migration, :name do |_, args|
    if args[:name].nil?
      puts 'You must specify a migration name (e.g. rake generate:migration[create_events])!'
      exit false
    end

    content = "Sequel.migration do\n  up do\n    \n  end\n\n  down do\n    \n  end\nend\n"
    version = last_migration_number() + 1
    filename = File.join(File.dirname(__FILE__), 'db/migrations', "#{version}_#{args[:name]}.rb")

    File.open(filename, 'w') do |f|
      f.puts content
    end

    puts "Created the migration #{filename}"
  end

  private

  # Find number of last migration in migrations folder
  def last_migration_number
    (Dir["db/migrations/*"].map do |name|
      name.scan(/(\d+)\_/).flatten.last
    end.compact.max || 0).to_i
  end
end
