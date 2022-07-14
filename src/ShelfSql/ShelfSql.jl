include("../AbstractShelf/AbstractShelf.jl")
mutable struct ShelfSql <: AbstractShelf
    filename::String
end