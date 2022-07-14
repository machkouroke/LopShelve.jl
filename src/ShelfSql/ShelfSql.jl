using SQLite: DB
using DBInterface
using DataFrames
include("../AbstractShelf/AbstractShelf.jl")
mutable struct ShelfSql <: AbstractShelf
    db::DB
    table::String
    filename::String
    primary_key::Union{Tuple, String}
end

include("baseFunction.jl")

function open!(filename::String, table::String)
    if isfile(filename)
        db = DB(filename)
        primary_key = (DBInterface.execute(db, "SELECT l.name FROM pragma_table_info(?) as l WHERE l.pk <> 0", [table]) |>
                      DataFrame).name
        if length(primary_key) == 0
            error("No primary key found in table $table")
        elseif length(primary_key) == 1
            primary_key = primary_key[1]
        else
            primary_key = Tuple(primary_key)
        end
        return ShelfSql(db, table, filename, primary_key)
    else
        error("File $filename not found")
    end
end
test = open!("src/ShelfSql/test.sqlite", "places_id")
test.primary_key = ("year", "state")
@show test[(2015, "01")] |> DataFrame