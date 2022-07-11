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

include("Utilities.jl")
include("Methods.jl")

export open!, delete!

end
