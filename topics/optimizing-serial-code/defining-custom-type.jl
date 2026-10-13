struct MyComplex{T<:Real} <:Number
    real::T
    imag::T
end

# constructor for mixed field
MyComplex(r::Number, i::Number) = MyComplex(promote(r, i)...)

# unary
Base.:-(a::MyComplex) = MyComplex(-a.real, -a.imag)

# binary
Base.:+(a::MyComplex, b::MyComplex) = MyComplex(a.real + b.real, a.imag + b.imag)
Base.:-(a::MyComplex, b::MyComplex) = MyComplex(a.real - b.real, a.imag - b.imag)
Base.:*(a::MyComplex, b::MyComplex) = MyComplex(
    a.real * b.real - a.imag * b.imag,
    a.real * b.imag + a.imag * b.real
)
function Base.:/(a::MyComplex, b::MyComplex)
    denom = b.real^2 + b.imag^2
    return MyComplex(
        (a.real * b.real + a.imag * b.imag) / denom,
        (a.imag * b.real - a.real * b.imag) / denom
    )
end

# identities
Base.zero(::Type{MyComplex}) = MyComplex(0, 0)
Base.one(::Type{MyComplex}) = MyComplex(1, 0)

# equality
Base.:(==)(a::MyComplex, b::MyComplex) = (a.real == b.real) && (a.imag == b.imag)

# promote & convert
Base.convert(::Type{MyComplex}, x::Number) = MyComplex(x, zero(x))
Base.promote_rule(::Type{MyComplex}, ::Type{T}) where {T<:Number} = MyComplex

# broadcasting
Base.broadcastable(x::MyComplex) = Ref(x)

# printing
function Base.show(io::IO, c::MyComplex)
    print(io, c.real, c.imag >= 0 ? " + " : " - ", abs(c.imag), "im")
end

function main()
    custom_complex_num = MyComplex(2, 3.5)
    println(custom_complex_num)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end