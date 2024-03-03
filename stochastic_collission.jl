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

# Array of each step's temperature
temps = collect(range(temp_1_k, temp_2_k, steps))

# Each of row of the following array is the ensemble at the corresponding step
ensembles = zeros(Float64, steps, N)

# Assign the velcoties of the first ensemble at the starting temperature
ensembles[1, :] = maxwell_rvs(temps[1], mass_amu, N)

# Go through each subsequent ensemble (represented as a row in ensembles array), 
# randomly reassigning velocities at each step

num_atoms_to_reassign = Int64(ceil(N * fraction_atoms_reassigned_per_step))

for row in range(2, steps)
    ensembles[row, :] = copy(ensembles[row-1, :])
    atoms_to_reassign = randperm(length(ensembles[row, :]))[1:num_atoms_to_reassign]
    ensembles[row, atoms_to_reassign] = maxwell_rvs(temps[row], mass_amu, num_atoms_to_reassign)
end

# Array of velocities for PDFs
velocities = collect(range(0, 2000, 100))

# Plot the start and end distributions side-by-side
pdf_start = maxwell_pdf(velocities, temp_1_k, mass_amu)
pdf_end = maxwell_pdf(velocities, temp_2_k, mass_amu)

histogram(ensembles[1,:], bins=100, normalize=true, alpha=0.3, color=:blue, label="First Step")
plot_start = plot!(velocities, pdf_start, title="Distribution at $temp_1_k K", xlabel="v (m/s)", ylabel="P(v)", linewidth=3, color=:blue, alpha=1.0, label="PDF Start")

histogram(ensembles[end,:], bins=100, normalize=true, alpha=0.3, color=:blue, label="End Step")
plot_end = plot!(velocities, pdf_end, title="Distribution at $temp_1_k K", xlabel="v (m/s)", ylabel="P(v)", linewidth=3, color=:blue, alpha=1.0, label="PDF End")

combined_plots = plot(plot_start, plot_end, layout=(1, 2), size=(600, 300), dpi=300)

savefig(combined_plots, "output/stochastic_collision.png")
