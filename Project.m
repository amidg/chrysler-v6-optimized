%MECHANICALLY DRIVEN FORCED AIR INDUCTION OPTIMIZATION FOR THE GAS ENGINE |
%MSE426 | SPRING 2020
%CODE BY DMITRII GUSEV, ID: 301297008

clear all 
clc

% INITIAL CONDITIONS
% DRIVEN PULLEY (meter), DRIVING PULLEY (meter), ENGINE RPM, TEMPERATURE OF
% THE OUTLET AIR (KELVIN) AND THEORETICAL BOOST (KPA)
xInitial = [0.0762, 0.1778, 6000, 304, 20.6]; %initial guess
lower_boundary = [0.0508, 0.127, 6000, 304, 0]; %lower boundary
upper_boundary = [0.0965, 0.2286, 6600, 363, 55]; %upper boundary

%mathematical model options for FMINCON() and GA()
A = [];
b = [];
optionsFMINCON = optimoptions('fmincon','Algorithm','interior-point','Display','iter', 'MaxFunctionEvaluations', 1000);
optionsGA = optimoptions('ga', 'Display','iter', 'PopulationSize', 1000); 

%fmincon optimization
[x1,fval1] = fmincon(@boostedHorsePowerFunction, xInitial, A, b, [], [], lower_boundary, upper_boundary, @nonLinearBoostConstraint, optionsFMINCON);

x1;
maxedEnginePowerFMINCON = 1/fval1;

%ADDITIONAL CALCULATIONS FOR THE FINAL ENGINE GAINS
pulleyBasedBoostFMINCON = 84.54*(x1(2)/x1(1)) - 101;
temperatureAtOutletBasedOnPulleyRatioFMINCON = 293*(pulleyBasedBoostFMINCON + 101)/101;

boostFMINCON = x1(5);
temperatureAtOutletBasedOnFMINCON = 293*(boostFMINCON + 101)/101;

superchargerUsesKWFMINCON = 0.0000298*x1(3)*(x1(2)/x1(1))*(temperatureAtOutletBasedOnFMINCON - 293);
achievedEnginePowerKWFMINCON = 186.4*((x1(5) + 101)/101)-0.0000298*x1(3)*(x1(2)/x1(1))*(temperatureAtOutletBasedOnFMINCON - 293);
achievedTorqueNMFMINCON = (30000/pi)*achievedEnginePowerKWFMINCON / x1(3);
superchargerRPMFMINCON = x1(3)*(x1(2)/x1(1));
powerLossDueToOverHeatingFMINCON = (0.0000298*x1(3)*(x1(2)/x1(1))*(temperatureAtOutletBasedOnFMINCON - 293)) - 0.0000298*x1(3)*(x1(2)/x1(1))*(x1(4) - 293);

%genetic algorithm optimization
[x2,fval2] = ga(@boostedHorsePowerFunction, 5, A, b, [], [], lower_boundary, upper_boundary, @nonLinearBoostConstraint, [], optionsGA); 

x2;
maxedEnginePowerGA = 1/fval2;

%ADDITIONAL CALCULATIONS FOR THE FINAL ENGINE GAINS
pulleyBasedBoostGA = 84.54*(x2(2)/x2(1)) - 101;
temperatureAtOutletBasedOnPulleyRatioGA = 293*(pulleyBasedBoostGA + 101)/101;

boostGA = x2(5);
temperatureAtOutletBasedOnGA = 293*(boostGA + 101)/101;

superchargerUsesKWGA = 0.0000298*x2(3)*(x2(2)/x2(1))*(temperatureAtOutletBasedOnGA - 293);
achievedEnginePowerKWGA = 186.4*((x2(5) + 101)/101)-0.0000298*x2(3)*(x2(2)/x2(1))*(temperatureAtOutletBasedOnGA - 293);
achievedTorqueNMGA = (30000/pi)*achievedEnginePowerKWGA / x2(3);
superchargerRPMGA = x2(3)*(x2(2)/x2(1));
powerLossDueToOverHeatingGA = (0.0000298*x2(3)*(x2(2)/x2(1))*(temperatureAtOutletBasedOnGA - 293)) - 0.0000298*x2(3)*(x2(2)/x2(1))*(x2(4) - 293);

