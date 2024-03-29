# chem-5845-jl
Work I do in for CHEM-5845, Julia version.

## Dependencies

This repo requires a few packages. If needed, install then like this:

```
import Pkg
Pkg.add("Distributions")
Pkg.add("Plots")
Pkg.add("FFMPEG")
Pkg.add("ImageMagick")
```

This will download and compile a lot of code, so have a fast connection and be patient!

## Scripts

### Scripts to be executed directly

- `scale_velocity.jl`: Demosntrates warming an ensemble of 1 million O<sub>2</sub> atoms from 50 K to 300 K by applying a scaling multiplier.
- `stochatic_collision.jl`: Demonstrates warming a gas also, but using the stochastic collision method.

### Modules called by other scripts

- `lib/maxwell_boltzman.jl`: PDF and random value generation from a Maxwell-Boltzmann distribution.

## Other Notes

- The molecular weight of the most abundant isotope of diatomic oxygen <sup>16</sup>O<sub>2</sub> is 32.0 amu.
