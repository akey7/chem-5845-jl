using Plots

include("lib/maxwell_boltzman.jl")
using .MaxwellBoltzmann

temp_k_01 = 50.0
temp_k_02 = 300.0
o2_mass_amu = 32.0
velocities = collect(range(0, 2000, 100))

pdf_01 = maxwell_pdf(velocities, temp_k_01, o2_mass_amu)
rvs_01 = maxwell_rvs(temp_k_01, o2_mass_amu, 1000000)

lambda = sqrt(temp_k_02 / temp_k_01)
pdf_02 = maxwell_pdf(velocities, temp_k_02, o2_mass_amu)
rvs_02 = lambda .* rvs_01

histogram(rvs_01, bins=100, normalize=true, alpha=0.3, color=:blue, label="Random Velocities")
plot_01 = plot!(velocities, pdf_01, title="Distribution at $temp_k_01 K", xlabel="v (m/s)", ylabel="P(v)", linewidth=3, color=:blue, alpha=1.0, label="PDF")

histogram(rvs_02, bins=100, normalize=true, alpha=0.3, color=:orange, label="Random Velocities")
plot_02 = plot!(velocities, pdf_02, title="Distribution at $temp_k_02 K", xlabel="v (m/s)", ylabel="P(v)", linewidth=3, color=:orange, alpha=1.0, label="PDF")

combined_plots = plot(plot_01, plot_02, layout=(1, 2), size=(600, 300), dpi=300)

savefig(combined_plots, "output/scaled_velocity.png")
