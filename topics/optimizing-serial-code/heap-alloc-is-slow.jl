# needs to run with -O0, otherwise julia automatically optimize
using BenchmarkTools

function inner_alloc!(C, A, B)
    m, n = A.size
    for j in 1:m
        for i in 1:n
            val = [A[i,j] + B[i,j]]
            C[i,j] = val[1]
        end
    end
    return C
end

function inner_noalloc!(C, A, B)
    m, n = A.size
    for j in 1:m
        for i in 1:n
            val = A[i,j] + B[i,j]
            C[i,j] = val
        end
    end
    return C
end

function main()
    N = 2^10
    A = rand(N, N)
    B = rand(N, N)
    C = similar(A)

    b_alloc = @benchmark inner_alloc!($C, $A, $B)
    println("Results for inner_alloc:")
    display(b_alloc)

    b_noalloc = @benchmark inner_noalloc!($C, $A, $B)
    println("Results for inner_noalloc:")
    display(b_noalloc)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
