Base.show(io::IO, x::ShelfSql) = print(
    io,
    "ShelfSQl:(db=$(x.db), 
 table=$(x.table), 
 file=$(x.filename), 
 primary_key=$(x.primary_key)"
)

function Base.getindex(s::ShelfSql, key)
    key = value_process(key)
    query = "SELECT * from $(s.table) where $(s.primary_key) == $(key)" |> x -> replace.(x, "\"" => "")
    row = DBInterface.execute(s.db, query) |> DataFrame
    size(row)[1] != 0 || error("No row found for key $key")
    return row |> eachcol |> pairs |> Dict
end
function value_process(key)
    addappostrophe(x) = x isa String ? "'$x'" : x
    if key isa Tuple
        return addappostrophe.(key)
    else
        return addappostrophe(key)
    end
end
