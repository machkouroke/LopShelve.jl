include("../AbstractShelf/AbstractShelf.jl")

mutable struct Shelf <: AbstractShelf
    data::Dict{Any,Any}
    filename::String
    keys::Vector{Any}
    function Shelf(data::Dict{Any,Any}, filename::String)
        this = new(data, filename, keys(data) |> collect)
    end
end

include("baseFunction.jl")

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
