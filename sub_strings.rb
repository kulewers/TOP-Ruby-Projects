def substrings(string, dictionary)
  string_array = string.downcase.gsub(/[^a-z ]/, '').split(' ')
  end_result = dictionary.reduce(Hash.new(0)) do |result, word|
    matching_words = string_array.filter_map {|string_word| string_word.include?(word)}
    if matching_words.length > 0
      result[word] += matching_words.length
    end
    result
  end
  p end_result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("Howdy partner, sit down! How's it going?", dictionary)