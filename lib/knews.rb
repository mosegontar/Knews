require "rss"
require "open-uri"
require "nokogiri"

class WashingtonPost

    def initialize
        @rss_url = "http://feeds.washingtonpost.com/rss/national"
        @feed = RSS::Parser.parse(open(@rss_url))
        @links = @feed.items.collect { |item| item.link}
    end

    def randomize
        @links.sample
    end

    def read_random
        link = self.randomize
        resp = open(link)
        text = self.parse_response(resp)
    end

    def parse_response(resp)
        doc = Nokogiri::HTML(resp)
        doc.css('article p').to_a.map {|i| i.text }
    end

end


class Knews
    def initialize
        @article = WashingtonPost.new.read_random
        @censored = []
        @score = Float(0)
    end

    def play
        @article.each do |line|
            @censored << self.censor(line)
        end
        
        @censored.each do |line|
            puts line.join(' ')
            puts
        end
    end

    def censor(line)
        censored = line.split.collect do |word|
            self.check_word(word)
        end        
    end

    def check_word(word)

        new_word = word.match(/^[^\w]?\w+/).to_s

        if new_word == self.is_upper?(new_word)
            return '_____' + word.scan(/[^\w+][\w+]?/)[0].to_s
        else
            return word
        end
    end

    def is_upper?(word)
        word.match(/^[[:upper:]][[:alpha:]]*/).to_s
    end
end



Knews.new.play


