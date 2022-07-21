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
    open(f, filename::String)
Open a given file in a context manager

If the file don't exist an empty Shelve object is created. Also 
the file name must'nt have extension

"""
function open!(func, filename::String)
    data = open!(filename)
    try
        func(data)
    finally
        close(data)
    end
end

"""
    save(s::Shelf)
Save the shelve data in the file

"""
function save(s::Shelf)
    serialize(s.filename, s.data)
end

"""
    close(s::Shelf)
Close the shelve and save the data in the file and delete the object

"""
function close(s::Shelf)
    save(s)
    s = nothing
end
