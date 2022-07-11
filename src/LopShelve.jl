module LopShelve

using Serialization: serialize, deserialize


mutable struct Shelf
    data::Dict{Any,Any}
    filename::String
    keys::Vector{Any}
    function Shelf(data::Dict{Any,Any}, filename::String)
        this = new(data, filename, keys(data) |> collect)
    end
end


Base.show(io::IO, x::Shelf) = print(io, "Shelf:$(x.data)")

function Base.getindex(s::Shelf, key::String)
    return s.data[key]
end

function Base.setindex!(s::Shelf, value::Any, key::Any)
    s.data[key] = value
    s.keys = keys(s.data)
    save(s)
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
"""
    open(filename::String)
Open a given file in a Shelf object

If the file don't exist an empty Shelve object is created. Also 
the file name must'nt have extension

"""
function open!(filename::String)
    filename *= ".lop"
    if isfile(filename)
        return Shelf(deserialize(filename), filename)
    else
        return Shelf(Dict(), filename)
    end
end



"""
    save(s::Shelf)
Save the shelve data

"""
function save(s::Shelf)
    serialize(s.filename, s.data)
end



end
