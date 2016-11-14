# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# => AutoBinList worker
class BoeData
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options queue: :boe_data, priority: :low
  recurrence backfill: true do
    daily.hour_of_day(05).minute_of_hour(30)
  end


  def perform
    ImportData.new
  end
end
