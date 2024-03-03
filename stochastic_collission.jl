using Plots

include("lib/maxwell_boltzman.jl")
using .MaxwellBoltzmann

# Configuration of the simulation
temp_1_k = 50.0
temp_2_k = 300.0
mass_amu = 32.0
steps = 100
N = 1000000
fraction_atoms_reassigned_per_step = 0.1

# Array of each steps temperature
temps = collect(range(temp_1_k, temp_2_k, steps))

# Each of row of the following array is the ensemble at the corresponding step
ensembles = zeros(Float64, steps, N)

# Assign the velcoties of the first ensemble at the starting temperature
ensembles[1, :] = maxwell_rvs(temps[1], mass_amu, N)
