abstract type AbstractShelf end
"""
    delete(s::Shelf)
delete the shelve file and shelf object

"""
function Base.delete!(s::AbstractShelf)
    isfile(s.filename) && rm(s.filename)
    s = nothing
end