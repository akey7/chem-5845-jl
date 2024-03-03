using Plots

include("lib/maxwell_boltzman.jl")
using .MaxwellBoltzmann

temp_1_k = 50.0
temp_2_k = 300.0
mass_amu = 32.0
steps = 100
N = 1000000
fraction_atoms_reassigned_per_step = 0.1



mb_dists = 
