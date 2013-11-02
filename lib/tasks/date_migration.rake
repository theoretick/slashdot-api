
namespace :slashdot do
  #--------------------------------------------------------------------
  # one-time task for migrating old to new date format in DB
  #--------------------------------------------------------------------
  desc "script to migrate old posting date format to new date format (single use)"
  task :update_all_date_formats => :environment do

    SlashdotPosting.all.each do |posting|
      date_raw = posting.post_date
      date_parsed = DateTime.parse(date_raw).to_s
      if posting.update_attributes!(post_date: date_parsed)
        puts "Updated SlashdotPosting ##{posting.id} date format: '#{date_raw}' to:"
        puts date_parsed
      end
    end

  end
end