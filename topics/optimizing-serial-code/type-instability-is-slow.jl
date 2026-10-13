using BenchmarkTools
using InteractiveUtils

function f(x, y)
    return x + y
end

function g(x)
    a = 4
    b = 2
    for i in 1:100
        c = f(x[1], a)
        d = f(b, c)
        a = f(d, x[2])
    end
    return a
end

function main()
    arr_mixed = Number[1.0, 2]  # Vector{Number}
    arr_typed = [1.0, 2.0]      # Vector{Float64}

    @code_llvm debuginfo=:none g(arr_mixed)
    b_mixed = @benchmark g($arr_mixed)
    display(b_mixed)

    @code_llvm debuginfo=:none g(arr_typed)
    b_typed = @benchmark g($arr_typed)
    display(b_typed)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
