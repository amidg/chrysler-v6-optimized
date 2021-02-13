function [f] = boostedHorsePowerFunction(x)
% Calculate objective f
f = 1/(186.4*((x(5) + 101)/101)-0.0000298*x(3)*(x(2)/x(1))*(x(4) - 293));
end