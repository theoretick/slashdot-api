
class StaticPagesController < ApplicationController
  def index
    latest_archived_url = Url.order('updated_at').last.target_url
    @latest_url = "/slashdot_postings/search?url=#{latest_archived_url}"
    @latest_10 = Url.order('updated_at').joins(:slashdot_postings).last(10)
    @latest_json = SlashdotPosting.last.to_json
  end

  def about
  end

end
