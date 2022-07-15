using Documenter
using LopShelve: Shelf, AbstractShelf
using LopShelve
makedocs(sitename="LopShelve", modules = [LopShelve])
deploydocs(
    ;repo = "github.com/machkouroke/LopShelve.jl.git", 
    versions = nothing
)