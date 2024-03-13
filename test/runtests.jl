using Test
using Random

include("../src/generalized_born.jl")
using .GeneralizedBornModel

function setup_test_environmment()
    Random.seed!(1234)
    init_model(10, 10, 2, 3)
end

@testset "Test GBM initialization" begin
    gbm = setup_test_environmment()
    println(gbm)
    @test all(isapprox.(gbm[:ys], [9.531, 7.955, 4.9424], atol=0.01))
end 
