namespace :retweet do
  desc "import boe data for Today: #{Date.today}"
  task boe: :environment do
    TwitterManager.new
  end
end
