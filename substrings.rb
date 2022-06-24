dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(string,dictionary)
    sentence = string.split
    result = Hash.new(0)

    dictionary.each do |reference|
        sentence.each do |word|
            if word.downcase.include?(reference)
                result[reference] += 1
            end
        end
    end
    puts result
end

substrings("Howdy partner, sit down! How's it going?",dictionary)