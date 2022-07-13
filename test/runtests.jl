using LopShelve
using Test

# Test of version 0.1.0
@testset "LopShelve.jl" begin
    test_Shelve = LopShelve.open!("test")
    @test test_Shelve.data == Dict()
    test_Shelve["hello"] = "world"
    @test test_Shelve["hello"] == "world"
    test_Shelve["complex_data"] = Dict(["a" => "1", "b" => "2"])
    @test test_Shelve["complex_data"] == Dict(["a" => "1", "b" => "2"])
    
    # After Insertion
    full_Shelve = LopShelve.open!("test")
    @test full_Shelve["hello"] == "world"
    @test full_Shelve["complex_data"] == Dict(["a" => "1", "b" => "2"])
    
    delete!(test_Shelve)
    delete!(full_Shelve)
end

# Test of version 0.1.1: add of composante verification
@testset "LopShelve.jl" begin
    config = LopShelve.open!("../config")
    config.data = Dict{Any, Any}("best_word" => "jeton", "dico" => "src/lop.com", "hello" => "world")
    @test config.data == Dict{Any, Any}("best_word" => "jeton", "dico" => "src/lop.com", "hello" => "world")
    @test ("best" in config) == false
    @test ("best_word" in config) == true
    delete!(config)
end
