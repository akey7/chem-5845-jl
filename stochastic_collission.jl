using Plots
using Random

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

# Go through each subsequent ensemble, 
# randomly reassigning velocities at each step

num_atoms_to_reassign = Int64(ceil(N * fraction_atoms_reassigned_per_step))

for row in range(2, steps)
    ensembles[row, :] = copy(ensembles[row-1, :])
    atoms_to_reassign = randperm(length(ensembles[row, :]))[1:num_atoms_to_reassign]
    ensembles[row, atoms_to_reassign] = maxwell_rvs(temps[row], mass_amu, num_atoms_to_reassign)
end
