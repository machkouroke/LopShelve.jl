LopShelve.jl
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://lopuniverse.me/LopShelve.jl/)
============

### Julia implementation of Python Shelve
![image](https://user-images.githubusercontent.com/40785379/178375594-9693995a-3b67-40fb-aca7-5fce51b1ba94.png)

<a href="https://buymeacoffee.com/machkouroke" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>


## Why use LopShelve ?
A shelf is an object similar to a dictionary but which allows data persistence. You could thus save your data in a file as if it were a dictionary. This julia implementation is based on the <a href="https://docs.python.org/3/library/shelve.html">Shelve version of python</a>. So if you used the Shelve version of python you would not be out of place.
However this implementation does not stop there, you could also use LopShelve to map 
your data from database (Sqlite) to dictionary

## How use LopShelve ?

- Add the Shelve module by entering the following lines in your REPL 
```julia
]add LopShelve

```
- Import the LopShelve module then create a <b>Shelf</b> object with the open method! as following (Please specify the name of the file to open without extensions, if it does not exist it will be created)
```julia
using LopShelve: open!
```
### Ordinary File
```julia
data = open!("test_file") 
```
- You can then use your Shelf object as a dictionary (The data is automatically saved in the file)
```julia
data["user_name"] = "machkouroke"
data["password"] = "abcdefgh"
```
- To  save the data in the file
```julia
commit(data)
```
- You can also use the do...end syntax to automatically save the data if you end up using the shelf (Recommended)
```julia
open!("test_file") do data
  data["user_name"] = "machkouroke"
  data["password"] = "abcdefgh"
end
```
- You can delete a Shelf's file with the ```delete``` function
```julia
delete(data)
```
- If you use the do...end syntax
```julia
open!("test_file"; deletion=true) do data
  data["user_name"] = "machkouroke"
  data["password"] = "abcdefgh"
end
```
### DataBase Interface
```julia
data = open!("test_file.db", "table_name") 
```
- You can then use your Shelf object as a dictionary with table's primary key for indexing
For example The `table_name` table has two columns: username (Primary key) and password so we can register a user as follows
```julia
data["machkouroke"] = (password="abcdefgh")
data["johndoe"] = (password="abcdefghj")

length(data) # 2

"machkouroke" in data # true
"alex" in data # false

for i in data
  print(i)
end
```
<b>Output</b>
```julia
Dict{Symbol, AbstractVector} with 2 entries:
  :username  => ["machkouroke"]
  :Title    => ["abcdefgh"]
Dict{Symbol, AbstractVector} with 2 entries:
  :username  => ["johndoe"]
  :Title    => ["abcdefghj"]
```
- You can also delete a ShelfSql file with the ```delete``` function
```julia
delete(data)
```
