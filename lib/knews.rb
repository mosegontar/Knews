require "./washington_post"


class Knews
    def initialize
        @article = WashingtonPost.new.read_random
        @censored = []
    end

    def read
        @article.each do |line|
            censored, uppercases = censor(line)
            puts censored.join(' ')
            uppercases.each_with_index do |word, i|
                print (i+1).to_s + ": "
                resp = gets.chomp
                puts "You guessed #{resp}"
                puts "Real answer: #{word}"
                puts
                if i == uppercases.length - 1
                    puts line
                end
            end
        end
    end

    private

    def censor(line)
        p line.split
        uppercases = []
        censored = line.split.collect do |word|
            checked = check_word(word)
            uppercases << word unless checked == word
            checked
        end
        return censored, uppercases
    end

    def check_word(word)

        new_word = word.match(/^[^\w]?\w+/).to_s

        if new_word == is_upper?(new_word)
            return '_____' + word.scan(/[^\w+][\w+]*/)[0].to_s
        else
            return word
        end
    end

    def is_upper?(word)
        word.match(/^[[:upper:]][[:alpha:]]*/).to_s
    end
end

Knews.new.read