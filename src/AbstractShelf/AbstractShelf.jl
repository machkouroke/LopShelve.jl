abstract type AbstractShelf end
"""
    delete(s::Shelf)
delete the shelve file 

"""
function delete(s::AbstractShelf)
    isfile(s.filename) && rm(s.filename)
end