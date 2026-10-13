using BenchmarkTools

struct MySlowComplex
    real <: Any
    imag <: Any
end

Base.:+(a::MySlowComplex, b::MySlowComplex) = MySlowComplex(a.real + b.real, a.imag + b.imag)
Base.:+(a::MySlowComplex, b::Number) = MySlowComplex(a.real + b, a.imag)
Base.:+(a::Number, b::MySlowComplex) = MySlowComplex(a + b.real, b.imag)


struct MyFastComplex{T<:Number}
    real::T
    imag::T
end

Base.:+(a::MyFastComplex, b::MyFastComplex) = MyFastComplex(a.real + b.real, a.imag + b.imag)
Base.:+(a::MyFastComplex, b::Number) = MyFastComplex(a.real + b, a.imag)
Base.:+(a::Number, b::MyFastComplex) = MySlowComplex(a + b.real, b.imag)

function main()
    # MySlowComplex is not a bits type
    # MyFastComplex<Float64> is a bits type
    # TODO: compare the speed
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end