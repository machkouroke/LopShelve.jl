module LopShelve
using Serialization: serialize, deserialize


include("Shelf/Shelf.jl")
include("ShelfSql/ShelfSql.jl")

export open!, delete!, Shelf

end
