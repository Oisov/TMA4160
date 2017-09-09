using Primes

"""
The discrete logarithm of x to the base g is the smallest
non-negative integer a such that x = g^a . We write
                log_g x = a.
The discrete logarithm problem in a cyclic group G is to
find the discrete logarithm
"""

#  Euler's Phi (or: totient) function
function eulerphi(n::Integer,factors=[])
    if n <= 0
        error("Argument 'n' must be a (positive) natural number.")
    end
    if length(factors)==0
        factors = keys(factor(n))
    end
    m = n
    for p in factors    # must be unique
        m = m - div(m, p)       # m = m * (1 - 1/p)
    end

    return m
end



# Simply calculates g^a modulo |G| = n, until g^a = x
function naive_discrete_log(x, g, n)
    # x = element
    # g = generator 
    # G = group
    temp_x = g
    power = 1
    while temp_x != x
        power += 1
        temp_x = mod(temp_x*g, n)
    end
    power
end

"""
Suppose n1, n2, ..., nk are positive integers that are pairwise co-prime.  
Then, for any given sequence of integers a1, a2, ... ak there exists an integer
x solving the following system of simultaneous congruences:

    x = a1 ( mod n1 )
    x = a2 ( mod n2 )
    x = a3 ( mod n3 )
         .
         .
         .
    x = ak ( mod nk )

The following code solves this system of congurences returning the smallest x assuming

    gcd(ni,nj) = 1

for every 1 <= i < j <= k.
"""
function CRT(a, n)
    N = prod(n)
    x = 0
    for (ai, ni) in zip(a, n)
        n2 = div(N, ni)
        x += ai*invmod(n2, ni)*n2
    end
    return x%N
end

function discrete_log(h, g, N)
    phi = eulerphi(N)   
    n = []
    a = []

    for (base, power) in factor(phi)

        n1 = base^power
        n2 = div(phi, n1)

        g1 = powermod(g, n2, N)
        h1 = powermod(h, n2, N)

        a1 = naive_discrete_log(h1, g1, N)

        push!(n, n1)
        push!(a, a1)
    end
    CRT(a, n)
end

# println(factor(72))
# println(discrete_log(85, 11, 125))
# println(naive_discrete_log(9689, 23, 11251))
# println(discrete_log(9689, 23, 11251))
println(discrete_log(85, 11, 125))

