require "csv"
module DataImporter
  class DataImporter::CSVImporter
    def initialize model
      @model = model
    end

    def execute
      destroy_all
      puts "== Load #{@model}"
      csv_table = CSV.parse(File.read(csv_file_path), headers: true)
      csv_table.each do |row|
        instance = @model.new
        row.to_hash.each do |key, value|
          instance[key] = value
        end
        instance.save!
      end
    end

    private
    def destroy_all
      puts "== Destroy All of #{@model}"
      if @model.new.attributes.keys.include?("deleted_at")
        @model.with_deleted.map{ |instance| instance.really_destroy! }
      else
        @model.destroy_all
      end
    end

    def csv_file_path
      Rails.root.join "db", "masters", "#{@model.name.underscore.pluralize}.csv"
    end
  end
end
