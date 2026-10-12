using BenchmarkTools

function inner_rows!(C, A, B)
    m, n = A.size
    for i in 1:m
        for j in 1:n
            C[i, j] = A[i, j] + B[i, j]
        end
    end
    return C
end

function inner_cols!(C, A, B)
    m, n = A.size
    for j in 1:n
        for i in 1:m
            C[i, j] = A[i, j] + B[i, j]
        end
    end
    return C
end

function main()
    N = 2^10
    A = rand(N, N)
    B = rand(N, N)
    C = similar(A)

    b_row = @benchmark inner_rows!($C, $A, $B)
    println("Results for inner_rows:")
    display(b_row)
    b_col = @benchmark inner_cols!($C, $A, $B)
    println("Results for inner_cols:")
    display(b_col)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
