module SocialsHelper
	def get_url(url)
    page = Nokogiri::HTML(open(url))  
    debugger
    return page.css("meta[property='og:image']").first.values.second
  end


end
