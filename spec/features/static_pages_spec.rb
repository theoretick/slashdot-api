require 'spec_helper'

describe "StaticPages" do

  describe "GET static_pages" do

    it "lands on the homepage successfully" do
      visit :index
      expect(page.status_code).to be(200)
    end

    it "lands on the about page successfully" do
      visit '/about'
      expect(page.status_code).to be(200)
    end

  end

end

