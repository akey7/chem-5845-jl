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
    @test all(isapprox.(gbm[:rs], [0.652, 1.098, 0.437], atol=0.01))
    @test all(isapprox.(gbm[:xs], [8.942, 3.531, 3.943], atol=0.01))
    @test all(isapprox.(gbm[:ys], [9.531, 7.955, 4.942], atol=0.01))
end 
