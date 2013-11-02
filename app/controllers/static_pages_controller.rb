
class StaticPagesController < ApplicationController
  def index
    latest_archived_url = Url.order('updated_at').last.target_url
    @latest_url = "/slashdot_postings/search?url=#{latest_archived_url}"
  end

  def about
  end

end
