Base.show(io::IO, x::ShelfSql) = print(
    io,
    "ShelfSQl:(db=$(x.db), 
 table=$(x.table), 
 file=$(x.filename), 
 primary_key=$(x.primary_key)"
)
bind_maker(value) = ("?,"^length(value))[1:end-1]

function Base.getindex(s::ShelfSql, key)
    key = value_process(key)
    query = "SELECT * from $(s.table) where $(s.primary_key) == $(key)" |> x -> replace.(x, "\"" => "")
    row = DBInterface.execute(s.db, query) |> DataFrame
    size(row)[1] != 0 || error("No row found for key $key")
    return row |> eachcol |> pairs |> Dict
end


""" 
    Base.setindex!(s::ShelfSql, value::NamedTuple, key)
Create a new row in the database or modify an existing row in the database
Usually this method is called with bracket square in which we put the key's value and the row's value
is the affected value.
```
    Exemple:
    db["justin"] = (year=2000, country="USA")
    # Multiple index values
    db[("John", "Doe")] = (year=1999, country="Benin")

```

"""
function Base.setindex!(s::ShelfSql, value::NamedTuple, key)
    """
        string_to_tuples(x)
    Convert a string to a tuple of strings or just a tuple
    ```
    Example:
    string_to_tuples("a") => ("a", )
    string_to_tuples(("a", "b")) => ("a", "b")
    ```
    """
    string_to_tuples(x) = x isa Tuple ? x : (x,)

    # We merge the keys and the values to have a united dictionary 
    # that we will then pass to the queries
    all_parameter = merge(Dict(pairs(value)),
        Dict(zip(Symbol.(string_to_tuples(s.primary_key)), string_to_tuples(key))))
    key = string(tuple(keys(all_parameter)...)) |> x -> replace.(x, ":" => "")
    query = "INSERT OR REPLACE INTO $(s.table) $key VALUES($(bind_maker(values(all_parameter))))"
    @show query
    DBInterface.execute(s.db, query, collect(values(all_parameter)))
end
function Base.in(item::Any, x::ShelfSql)
    try 
        x[item]
        return true
    catch e
        if e isa ErrorException 
            return false
        else
            throw(e)
        end
    end
end
function value_process(key)
    addappostrophe(x) = x isa String ? "'$x'" : x
    if key isa Tuple
        return addappostrophe.(key)
    else
        return addappostrophe(key)
    end
end

