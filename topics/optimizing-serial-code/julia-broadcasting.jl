# how does A .+ B .+ C works?
using BenchmarkTools

# under the hood, it lowers to something like
function manual_broadcast(A, B, C)
    return map((a, b, c)->a + b + c, A, B, C)
end

# note that there are two ways to do this
function unfused(A, B, C)
    # this one is done in higher language like in Python,
    # since you need JIT to compile the new func on the fly
    tmp = A +. B
    return tmp .+ C
end

function fused(A, B, C)
    # JIT allow us to do it in a more optimal way, with fewer alloc
    return A .+ B .+ C
end

# we can also use it on function
function f(x)
    return x^2
end

function g(arr)
    return f.(arr)
end

# or do it using map
function manual_add!(D, A, B, C)
    # note that a matrix is just an array...
    for i in eachindex(A)
        D[i] = A[i] + B[i] + C[i]
    end
    return D
end

# in general, for an expression with full dots D .= f.(A) .+ g.(B) .* h.(C)
# fyi, one can also write this expression as @. D = f(A) + g(B) * h(C)
function manual_dot_expression(D, A, B, C, f, g, h)
    for i in eachindex(A)
        D[i] = f(A[i]) + g(B[i]) * h(C[i])
    end
    return D
end
