function [c ,ceq]= nonLinearBoostConstraint(x) 
boostObtainedFromPulleyRatio = 84.54*x(2)/x(1); %absolute pressure boost 
superchargerRPM = x(3)*(x(2)/x(1)); % belt drive ratio * engine RPM

c = [boostObtainedFromPulleyRatio - 156; superchargerRPM - 12000]; 

ceq =[];
end