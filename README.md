# HeatSolver.f95

A simple model for heat diffusion through a soil column.

The model is taken from [1] and is of interest as it gives a good example of *stagnation* when integrated in single (rather than double) precision with round-to-nearest (heat does not diffuse effectively in single precision with the small choice of time-step). 

The effects of rounding error here can be mitigated here by either of (i) increasing the time-step Δt, or (ii) using a stochastic rounding scheme. 

Written in Fortran, the code integrates the 1D heat equation dT/dt = D d^2T/dz^2 using a finite difference scheme (forward-Euler in time, centred finite difference in space).

The default parameters are as follows. 
Boundary conditions T(0,t) = 280 K at soil top, thermal insulation dT/dz(H,t) = 0 at soil bottom. 
Initial condition T(z,0) = 273.3 K. 
Thermal diffusivity D = 7 x 10^-7 m^2s^-1.
Soil depth H = 60 m.
Forecast length T = 60 years. 
Resolution Δt = 1800 s, Δz = 1 m.

# Usage

The integration is contained in one program called `HeatSolve.f95` so (using gfortran as compiler, for example) do
```
> gfortran -o exe32 HeatSolve.f95
```
to compile (note this will compile in single precision by default) and then
```
> ./exe32 > output32.txt
```
to run and print the output to a file called `output32.txt`. The output is a temperature array stored as text.

If you like, you can make a heat-plot of the array using the provided python script `heatplot.py`. Just do
```
> python heatplot.py output.txt heatplot.pdf
```
to plot the array `output32.txt` and save as a pdf `heatplot32.pdf`.

# References

[1] Dawson et al. - *Reliable low precision simulations in land surface models* (Climate Dynamics 51:2657–2666, 2018)
