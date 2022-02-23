# Masters Year Proj
Masters year project on Active Sound Field Design for Car Interiors where this is automation and simulation of Nth order Butterworth filters

FilterPoles.m uses other files as modules

Inputs:
- Desired order (n)
- Desired cut off frequency (fc)

Outputs:
Saves figures
- Figures 1-4
  - Show response of filtered and unfiltered signals at 200Hz, 500Hz, 800Hz, and 5000Hz
  - Values are chosen as less than fc, at fc, over fc, and 10x fx
- Figure 20
  - Shows bode plot of simulated system
- Figure 21
  - Shows the response of the system in terms of frequency in Hz and magnitude in dB
- Figure 22
  - Shows the response in terms of absolute magnitude and frequency in Hz
- Figure 23
  - Shows the group delay vs normalised frequency
Saves as individual spreadsheets:
- Componenets required for 3 methods of building filter
- The equation coefficients for simulating the filter

