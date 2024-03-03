###########################################################
# LOAD MODULES                                            #
###########################################################

using Plots
using Random

include("lib/maxwell_boltzman.jl")
using .MaxwellBoltzmann

###########################################################
# CONFIGURATION                                           #
###########################################################

temp_1_k = 50.0
temp_2_k = 300.0
mass_amu = 32.0
steps = 100
N = 1000000
fraction_atoms_reassigned_per_step = 0.1

###########################################################
# SIMULATION                                              #
###########################################################

# Each of row of the following array is the ensemble at the corresponding step
ensembles = zeros(Float64, steps, N)

# Assign the velcoties of the first ensemble at the starting temperature
ensembles[1, :] = maxwell_rvs(temp_1_k, mass_amu, N)
println("Step 1 complete")

# Go through each subsequent ensemble (represented as a row in ensembles array), 
# randomly reassigning velocities at each step

num_atoms_to_reassign = Int64(ceil(N * fraction_atoms_reassigned_per_step))

for row in range(2, steps)
    ensembles[row, :] = copy(ensembles[row-1, :])
    atoms_to_reassign = randperm(length(ensembles[row, :]))[1:num_atoms_to_reassign]
    ensembles[row, atoms_to_reassign] = maxwell_rvs(temp_2_k, mass_amu, num_atoms_to_reassign)
    println("Step $row complete")
end

###########################################################
# PLOTTING                                                #
###########################################################

println("Generating before and after plot panels...")

# Array of velocities for PDFs
velocities = collect(range(0, 2000, 100))

# Plot the start and end distributions side-by-side
pdf_start = maxwell_pdf(velocities, temp_1_k, mass_amu)
pdf_end = maxwell_pdf(velocities, temp_2_k, mass_amu)

# Calculate the upper y limit
max_y = maximum(pdf_start) * 1.1

histogram(ensembles[1,:], bins=100, normalize=true, alpha=0.3, color=:blue, label="First Step")
plot_start = plot!(velocities, pdf_start, title="Distribution at $temp_1_k K", ylim=(0, max_y), xlabel="v (m/s)", ylabel="P(v)", linewidth=3, color=:blue, alpha=1.0, label="PDF Start")

histogram(ensembles[end,:], bins=100, normalize=true, alpha=0.3, color=:orange, label="End Step")
plot_end = plot!(velocities, pdf_end, title="Distribution at $temp_2_k K", ylim=(0, max_y), xlabel="v (m/s)", ylabel="P(v)", linewidth=3, color=:orange, alpha=1.0, label="PDF End")

combined_plots = plot(plot_start, plot_end, layout=(1, 2), size=(600, 300), dpi=300)

savefig(combined_plots, joinpath("output", "stochastic_collision.png"))

###########################################################
# DONE                                                    #
###########################################################

println("Done")
