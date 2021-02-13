# chrysler-v6-optimized
My Genetic Algorithm implementation for the Chrysler V6 3.5L forced air induction using MATLAB. My independent school project from 2020.

This MATLAB algorithm allows to use fmincon() or genetic algorith to optimize any kind of ICE (Internal Combustion Engine) for the forced air induction application using Roots supercharger. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PREREQUISITES:
Optimization toolbox (needed for fmincon)
Global Optimization toolbox (needed for genetic algorith)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
HOW TO USE?
User needs to specify the following parameters for the initial conditions for both upper and lower boundaries:
1. Driven pulley on the supercharger side (meters)
2. Driving pulley on the engine side (meters)
3. Enginer RPM 
4. Temperature of the air (Kelvin)
5. Theoretical boost (kPA) that is safe for your engine block.

Example:
xInitial = [0.0762, 0.1778, 6000, 304, 20.6]; %initial guess
lower_boundary = [0.0508, 0.127, 6000, 304, 0]; %lower boundary
upper_boundary = [0.0965, 0.2286, 6600, 363, 55]; %upper boundary

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
WHAT DOES IT CALCULATE?
1. Desired driving pulley size in meters
2. Desired driven pulley size in meters
3. Engine RPM with highest achived horsepower
4. Supercharger outlet temperature achieved during optimization (true only in ideal conditions, must be recalculated manually using thermodynamics, see report for details)
5. Maximum achieved boost during simulation (kPA)
6. Maximum achieved horsepower (in kW)