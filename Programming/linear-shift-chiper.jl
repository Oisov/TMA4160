

ALPHABETH = string('a':'z'...)
ALPH_DICT = Dict(letter => index for (index, letter) in enumerate(ALPHABETH))
ALPH_LEN = length(ALPHABETH)

TEST = "This is some random message which should be encrypted"

function shift_chiper_encryption(plaintext, key)
    chipertext = plaintext
    for (index, letter) in enumerate(ALPHABETH)
        shifted_index = mod(index + key-1, ALPH_LEN)+1
        shifted_letter = ALPHABETH[shifted_index]
        println(shifted_letter)
        chipertext = replace(chipertext, letter, shifted_letter)
    end
     
    return chipertext
end

println(shift_chiper_encryption(TEST, 1))
