using Plots

include("lib/maxwell_boltzman.jl")
using .MaxwellBoltzmann

velocities = collect(range(0, 2000, 100))
ys = maxwell_pdf(velocities, 300.0, 32.0)
rvs = maxwell_rvs(300.0, 32.0, 1000000)
histogram(rvs, bins=100, normalize=true, alpha=0.5, color=:orange, label="Random Values")
pdf_plot = plot!(velocities, ys, title="Maxwell-Boltzmann Distribution", xlabel="v (m/s)", ylabel="P(v)", linewidth=3, color=:blue, label="PDF")
display(pdf_plot)
readline()
