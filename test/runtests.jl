using Shelve
using Test

@testset "Shelve.jl" begin
    test_Shelve = Shelve.open!("test")
    @test test_Shelve.data == Dict()
    test_Shelve["hello"] = "world"
    @test test_Shelve["hello"] == "world"
    test_Shelve["complex_data"] = Dict(["a" => "1", "b" => "2"])
    @test test_Shelve["complex_data"] == Dict(["a" => "1", "b" => "2"])

    # After Insertion
    full_Shelve = Shelve.open!("test")
    @test full_Shelve["hello"] == "world"
    @test full_Shelve["complex_data"] == Dict(["a" => "1", "b" => "2"])
end
