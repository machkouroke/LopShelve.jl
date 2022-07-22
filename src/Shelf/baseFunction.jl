Base.show(io::IO, x::Shelf) = print(io, "Shelf:$(x.data)")

function Base.getindex(s::Shelf, key::String)
    return s.data[key]
end

function Base.setindex!(s::Shelf, value::Any, key::Any)
    s.data[key] = value
    s.keys = keys(s)
end

function Base.in(item::Any, x::Shelf)
    return item in keys(x.data)
end

function Base.keys(x::Shelf)
    keys(x.data) |> collect
end

function Base.iterate(x::Shelf, state::Int64=1)::Union{Tuple{Any,Int64}, Nothing}
    return state > (x.keys |> length) ? nothing : (x.keys[state], state + 1)
end
