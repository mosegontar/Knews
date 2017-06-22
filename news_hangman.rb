require "rss"
require "open-uri"
require "nokogiri"



links = []
open("http://feeds.washingtonpost.com/rss/national") do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items.each do |item|
            p item.instance_variables
            links << item.link
        end
    end


a = open(links.sample)
doc = Nokogiri::HTML(a)
text = doc.css('article p').to_a.map {|i| i.text }
upcases = []
text.each do |line|
    line.scan(/[A-Z]\w+/).each {|w| upcases << w }
end
upcases.each do |k|
   p upcases
end

module RSSRetriever
  def get_rss(feed)
    open(feed)
  end
end
