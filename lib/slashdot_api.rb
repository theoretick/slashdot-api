#----------------------------------------------------------------------
# SlashdotApi v1.0
#
# - scrapes Slashdot to build DB objects SlashdotPostings and Urls
# each has_many of the other. Validates presence of permalink/target_url
# and uniqueness.
#
# http://github.com/theoretick/slashdot-api
#----------------------------------------------------------------------
require 'nokogiri'

#----------------------------------------------------------------------
# GET req slashdot archive page
# GET permalinks to recent slashdot stories
# finds or creates SlashdotPosting objects from permalinks
# finds or creates Url objects from each permalink-body's anchors
#----------------------------------------------------------------------
class SlashdotApi

  def get_postings(timeframe='w')

    first_anchor = 21 # first 21 anchors are nav links
    archive_url = 'http://slashdot.org/archive.pl?op=bytime&keyword=&week'

    # default: all archive_urls on page (skip last where href='page 2')
    request_count ||= -2
    # request_count = timeframe.to_i + first_anchor - 1 # -1 == index 0


    response = Faraday.get(archive_url)
    doc = Nokogiri::HTML(response.body)

    # array of slashdot posting urls from archive page
    archived_postings = doc.css('div.grid_24 a')[first_anchor..request_count]

    parent_body_anchors = []
    archived_postings.each { |anchor| parent_body_anchors << anchor.attribute("href").to_s }

    # Iterate through each posting on archive page to create SlashdotPosting instance
    parent_body_anchors.each_with_index do |anchor, index|
      posting_urls = []
      old_permalink = 'http:' + anchor

      # check and ensure no trailing slashes
      permalink = old_permalink.end_with?('/') ? old_permalink.chop : old_permalink


      # find/init SlashdotPosting.new instance from each posting_url
      s = SlashdotPosting.find_by(permalink: permalink)

      if s.blank?

        # open each slashdot discussion link as 'posting'
        posting = Faraday.get(permalink)

        parse(posting)

        # builds posting_url array with relevant body anchors that aren't slashdot
        @document.css('div.body a').each do |body_anchor|
          body_url = body_anchor.attribute("href").to_s
          posting_urls << body_url
        end

        # dont bother creating a listing if no links; i.e. "Ask Slashdot" posts
        unless posting_urls.empty?
          posting = SlashdotPosting.create!(
            site:          "slashdot",
            permalink:     permalink,
            title:         title,
            author:        author,
            comment_count: comment_count,
            post_date:     post_date
          )

          # find/init Url.new instance from each url in posting's body
          # and associate with SlashdotPosting instance
          posting_urls.each do |raw_url|
            # ensure no trailing slash
            url = raw_url.end_with?('/') ? raw_url.chop : raw_url

            unless url.starts_with?('/~') # internal slashdot user urls
              u = Url.find_or_initialize_by(target_url: url)
              u.slashdot_postings << SlashdotPosting.find_or_initialize_by(permalink: posting.permalink)
              puts ">  Saved URL: '#{url}'." if u.save
            end
          end
        end
      end
    end # end of parent_body_anchors block
  end

  # Private: parses @document with nokogiri if not already parsed
  #
  # returns a Nokogiri::HTML::Object from HTML object
  def parse(posting)
    @document = Nokogiri::HTML(posting.body)
  end

  def title
    @document.css('title').text
  end

  def author
    @document.css('header div.details a').text
  end

  def comment_count
    @document.css('span.totalcommentcnt').first.text
  end

  def post_date
    date_raw = @document.css('header div.details time').text
    DateTime.parse(date_raw).to_s
  end
end