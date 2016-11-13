namespace :boe do
  day = Date.today
  desc "Fetch boe data for day: #{day}"
  task fetch_data: :environment do
    Boe::ImportData.new
  end
end
