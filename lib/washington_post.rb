require "rss"
require "open-uri"
require "nokogiri"

class WashingtonPost

    def initialize
        @rss_url = "http://feeds.washingtonpost.com/rss/national"
        @feed = RSS::Parser.parse(open(@rss_url))
        @links = @feed.items.collect { |item| item.link}
    end

    # Select a random link to a WashPo article
    def randomize
        @links.sample
    end

    def read_random
        random_link = self.randomize
        resp = open(random_link)

        text = self.parse_response(resp)
    end

    def parse_response(resp)
        doc = Nokogiri::HTML(resp)
        doc.css('article p').to_a.map {|i| i.text }
    end

end