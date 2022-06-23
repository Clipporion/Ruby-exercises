def caesar(string,input)
    alphabet_up = {}
    alphabet_down = {}
    string = string.split("")

    i = 0
    ("A".."Z").map do |char|
    alphabet_up[char] = i
    i+=1
    end
    i = 0
    ("a".."z").map do |char|
        alphabet_down[char] = i
        i+=1
    end

    moved_up = {}
    moved_down = {}

    alphabet_up.map do |key,value|
    moved_up[(value-input)%26.abs] = key
    end

    alphabet_down.map do |key,value|
        moved_down[(value-input)%26.abs] = key
    end
    string.each do |char|
    if moved_up[alphabet_up[char]] != nil
        print moved_up[alphabet_up[char]]
    elsif moved_down[alphabet_down[char]] != nil
        print moved_down[alphabet_down[char]]
    else
        print char
    end
end
end

puts "Enter String"
string = gets.chomp
puts "Enter shift number"
shift = gets.chomp.to_i

caesar(string,shift)