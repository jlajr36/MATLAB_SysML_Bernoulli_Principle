function [Vdischarge,Tdischarge] = calculateDischarge(h,Areservoir,Adischarge)
% Function to calculate time to drain reservoir tank
% Inputs:   h = height of water column
%           Areservoir = Cross sectional area of reservoir tank
%           Adischarge = Cross sectional area of discharge pipe

% Outputs   Vdischarge= Velocity of discharge
%           Tdischarge= time to drain reservoir

g = 9.80665; %standard acceleration due to gravity on Earth (m/sec-squared)

Vdischarge=sqrt(2*g*h);
Tdischarge=(Areservoir/(g*Adischarge))*Vdischarge;
end