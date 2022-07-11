Shelve.jl
============

### Julia implementation of Shelve
![image](https://user-images.githubusercontent.com/40785379/178275883-2640a000-95e6-4f11-9a4b-c95d1d66dce2.png)

<a href="https://buymeacoffee.com/machkouroke" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>


## Why use Shell ?
A shelf is an object similar to a dictionary but which allows data persistence. You could thus save your data in a file as if it were a dictionary. This julia implementation is based on the <a href="https://docs.python.org/3/library/shelve.html">Shelve version of python</a>. So if you used the Shelve version of python you would not be out of place.

## How use Shell ?
- Add the Shelve module by entering the following lines in your REPL (The project is not yet published on Pkg)
```julia
]add https://github.com/machkouroke/Shelve.jl.git

```
- Import the Shelve module then create a <b>Shelf</b> object with the open method! as following (Please specify the name of the file to open without extensions, if it does not exist it will be created)
```julia
using Shelve
data = Shelve.open!("test_file")
```
- You can then use your Shelf object as a dictionary
```julia
data["user_name"] = "machkouroke"
data["password"] = "abcdefgh"
```
