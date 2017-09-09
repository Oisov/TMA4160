include("common.jl")
include("monoalphabetic.jl")

ALPHABETH = string('a':'z'...)

"""
Encrypts the given plaintext according to the Affine cipher.
The key is given as a pair of integers: first the multiplier, then
the additive constant.
The multiplier must be coprime to 26. If it is not, an error is thrown.
Converts the input to uppercase, but retains symbols.
Optional argument: offset=0, which specifies what number 'a' should be
considered as.
"""
function encrypt_affine(plaintext::String, mult::Integer, add::Integer)
    if mult % 2 == 0 || mult % 13 == 0
        error("The multiplier must be coprime to 26.")
    end

    keystr = string()
    for (index, letter) in enumerate(ALPHABETH)
        new_index = mod(index*mult + add - 1, 26) + 1
        keystr *= string(ALPHABETH[new_index])
    end
    encrypt_monoalphabetic(plaintext, keystr)
end

"""
Encrypts the given plaintext according to the Affine cipher.
The key is given as a pair of integers: first the multiplier, then
the additive constant.
The multiplier must be coprime to 26. If it is not, an error is thrown.
Converts the input to uppercase, but retains symbols.
Optional argument: offset=0, which specifies what number 'a' should be
considered as.
"""
function decrypt_affine(ciphertext::String, mult::Integer, add::Integer)
    if mult % 2 == 0 || mult % 13 == 0
        error("The multiplier must be coprime to 26.")
    end

    keystr = string()
    for (index, letter) in enumerate(ALPHABETH)
        new_index = mod(index*mult + add - 1, 26) + 1
        keystr *= string(ALPHABETH[new_index])
    end
    decrypt_monoalphabetic(ciphertext, keystr)
end

text = "Hello world"
cipher = encrypt_affine(text, 1, 1)
println(cipher)
println(decrypt_affine(cipher, 1, 1))
