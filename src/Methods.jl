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

"""
    delete(s::Shelf)
delete the shelve file and shelf object

"""
function Base.delete!(s::Shelf)
    isfile(s.filename) && rm(s.filename)
    s = nothing
end