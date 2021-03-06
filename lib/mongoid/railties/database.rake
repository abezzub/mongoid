namespace :db do

  # unless Rake::Task.task_defined?("db:drop")
  #   desc "Drops all the collections for the database for the current Rails.env"
  #   task :drop => "mongoid:drop"
  # end

  # unless Rake::Task.task_defined?("db:purge")
  #   desc "Drop all collections except the system collections"
  #   task :purge => "mongoid:purge"
  # end

  # unless Rake::Task.task_defined?("db:seed")
  #   # if another ORM has defined db:seed, don"t run it twice.
  #   desc "Load the seed data from db/seeds.rb"
  #   task :seed => :environment do
  #     seed_file = File.join(Rails.root, "db", "seeds.rb")
  #     load(seed_file) if File.exist?(seed_file)
  #   end
  # end

  # unless Rake::Task.task_defined?("db:setup")
  #   desc "Create the database, and initialize with the seed data"
  #   task :setup => [ "db:create", "db:mongoid:create_indexes", "db:seed" ]
  # end

  # unless Rake::Task.task_defined?("db:reset")
  #   desc "Delete data and loads the seeds"
  #   task :reset => [ "db:drop", "db:seed" ]
  # end

  # unless Rake::Task.task_defined?("db:create")
  #   task :create => :environment do
  #     # noop
  #   end
  # end

  # unless Rake::Task.task_defined?("db:migrate")
  #   task :migrate => :environment do
  #     # noop
  #   end
  # end

  # unless Rake::Task.task_defined?("db:schema:load")
  #   namespace :schema do
  #     task :load do
  #       # noop
  #     end
  #   end
  # end

  # unless Rake::Task.task_defined?("db:test:prepare")
  #   namespace :test do
  #     task :prepare => "mongoid:create_indexes"
  #   end
  # end

  # unless Rake::Task.task_defined?("db:create_indexes")
  #   task :create_indexes => "mongoid:create_indexes"
  # end

  # unless Rake::Task.task_defined?("db:remove_indexes")
  #   task :remove_indexes => "mongoid:remove_indexes"
  # end

  namespace :mongoid do
    desc "Create the indexes defined on your mongoid models"
    task :create_indexes => :environment do
      ::Rails.application.eager_load!
      ::Rails::Mongoid.create_indexes
    end

    desc "Remove indexes that exist in the database but aren't specified on the models"
    task :remove_undefined_indexes => :environment do
      ::Rails.application.eager_load!
      ::Rails::Mongoid.remove_undefined_indexes
    end

    desc "Remove the indexes defined on your mongoid models without questions!"
    task :remove_indexes => :environment do
      ::Rails.application.eager_load!
      ::Rails::Mongoid.remove_indexes
    end

    desc "Drops the database for the current Rails.env"
    task :drop => :environment do
      ::Mongoid::Sessions.default.drop
    end

    desc "Drop all collections except the system collections"
    task :purge => :environment do
      ::Mongoid.purge!
    end
  end
end
