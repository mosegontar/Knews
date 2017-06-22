require_relative "../lib/knews.rb"
require "test/unit"

class TestWashingtonPost < Test::Unit::TestCase

    def test_randomize
        articles = WashingtonPost.new
        article_link = articles.randomize
        assert(article_link.start_with?('http'))
    end

    def test_read_article
        articles = WashingtonPost.new
        assert_instance_of(Array, articles.read_random)
    end

end