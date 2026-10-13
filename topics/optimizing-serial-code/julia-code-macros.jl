using InteractiveUtils

function f(x, y)
    return 2x + y - 1
end

function g_unstable(x)
    x < 1 ? 1 : 0.5
end

function main()
    open("topics/optimizing-serial-code/julia-code-macros.txt", "w") do io
        println(io, "=== @code_lowered ===")
        show(io, MIME("text/plain"), code_lowered(f, (Float64, Float64)))

        println(io, "\n\n=== @code_typed ===")
        show(io, MIME("text/plain"), code_typed(f, (Float64, Float64)))

        println(io, "\n\n=== @code_llvm ===")
        code_llvm(io, f, (Float64, Float64))

        println(io, "\n=== @code_native ===")
        code_native(io, f, (Float64, Float64))
    end

    open("topics/optimizing-serial-code/julia-type-unstable.txt", "w") do io
        println(io, "=== @code_warntype ===")
        code_warntype(io, g_unstable, (Float32,))
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
