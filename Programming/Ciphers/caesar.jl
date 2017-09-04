# include("common.jl")
# include("monoalphabetic.jl")

ALPHABETH = string('a':'z'...)

"""
Encrypts the given plaintext according to the Caesar cipher.
The key is given as an integer, being the offset of each character;
so encrypt_caesar("abc", 1) == "BCD".
Converts the input to uppercase.
"""
function encrypt_caesar(plaintext::String, key::Integer)
    key = ((key-1) % 26) + 1
    keystr = string()
    for (index, letter) in enumerate(ALPHABETH)
        new_index = mod(index + key - 1, 26) + 1
        keystr *= string(ALPHABETH[new_index])
    end
    encrypt_monoalphabetic(plaintext, keystr)
end


"""
Decrypts the given ciphertext according to the Caesar cipher.
The key is given as an integer, being the offset of each character;
so decrypt_caesar("abcd", 1) == "zabc".
Converts the input to lowercase.
"""
function decrypt_caesar(ciphertext, key::Integer)
    # ciphertext: string;
    #        key: key
    #    Example: k=1 decrypts "B" as "a"
    key = mod(key-1, 26) + 1
    lowercase(encrypt_caesar(ciphertext, 26-key))
end

"""
Cracks the given ciphertext according to the Caesar cipher.
Returns (plaintext, key::Integer), such that encrypt_caesar(plaintext, key)
would return ciphertext.
With cleverness=0, simply does the shift that maximises e's frequency.
With cleverness=1, maximises the string's total fitness.
Converts the input to lowercase.
"""
function crack_caesar(input, fitness = false)
    ciphertext = letters_only(input)  
    texts = [(decrypt_caesar(ciphertext, key), key) for key in 0:25]

    max_fitness = string_fitness(texts[1][1])
    max_index = 1
    plaintext = texts[1][1]
    for index = 2:26
        text = texts[index][1]
        fitness = string_fitness(text)
        if fitness > max_fitness
            max_fitness = fitness
            max_index = index
            plaintext = text
        end
    end
    plaintext, max_index-1
end
