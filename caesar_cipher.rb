def caesar_cipher(string, shift)
  ciphered_string = string.split('').map do |letter|
    letter_code = letter.ord
    if letter_code.between?(65, 90)
      letter_code -= 65
      (((letter_code + shift) % 26) + 65).chr
    elsif letter_code.between?(97, 122)
      letter_code -= 97
      (((letter_code + shift) % 26) + 97).chr
    else
      letter_code.chr
    end
  end
  p ciphered_string.join('')
end

caesar_cipher("What a string!", -5)