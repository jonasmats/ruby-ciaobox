require File.expand_path(File.join(File.dirname(__FILE__), '../master_importer/csv_importer'))

namespace :master do
  desc "Import master data in 'db/masters'"

  task import: :environment do
    [SocialNetwork].each do |model|
      DataImporter::CSVImporter.new(model).execute
    end
  end
end
