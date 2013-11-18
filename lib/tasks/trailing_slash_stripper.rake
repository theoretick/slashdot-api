
namespace :slashdot do
  #--------------------------------------------------------------------
  # one-time task for migrating old to new url formats in DB
  #--------------------------------------------------------------------
  desc "script to strip trailing slashes on all URLS and permalinks in the DB"
  task :strip_slashes_from_all_urls => :environment do

    def test_mode?
      false
    end

    puts "stripping slashdot_postings..."
    SlashdotPosting.all.each do |posting|

      old_permalink = posting.permalink
      new_permalink = old_permalink.end_with?('/') ? old_permalink.chop : old_permalink

      puts

      if old_permalink != new_permalink
        if test_mode?
          puts '== TEST MODE =='
        else
          puts "Updated SlashdotPosting Permalink format" if posting.update_attributes!(permalink: new_permalink)
        end
        puts "OLD: '#{old_permalink}'"
        puts "NEW: '#{new_permalink}'"
        puts
      end
    end

    puts "stripping urls..."
    Url.all.each do |url|

      old_url = url.target_url
      new_url = old_url.end_with?('/') ? old_url.chop : old_url

      puts

      if old_url != new_url
        if test_mode?
          puts '== TEST MODE =='
        else
          puts "Updated URL format" if url.update_attributes!(target_url: new_url)
        end
        puts "OLD: '#{old_url}'"
        puts "NEW: '#{new_url}'"
        puts
      end
    end
  end
end
