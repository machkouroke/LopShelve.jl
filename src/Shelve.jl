module Shelve

# Write your package code here.

end
module Shelve

using Serialization: serialize, deserialize


mutable struct Shelf
    data::Dict{Any,Any}
    filename::String
end
Base.show(io::IO, x::Shelf) = print(io, "$(x.data)")
function Base.getindex(s::Shelf, key::String)
    return s.data[key]
end
function Base.setindex!(s::Shelf, value::Any, key::Any)
    s.data[key] = value
    save(s)
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
