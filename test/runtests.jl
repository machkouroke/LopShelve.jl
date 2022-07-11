using LopShelve
using Test

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
end
