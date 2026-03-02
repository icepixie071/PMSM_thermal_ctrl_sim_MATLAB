%% PMSM with Thermal Model - Create Example Flux Linkage Data
% This script creates example PMSM flux linkage data for use with the
% model PMSMWithThermal. 

% Copyright 2016-2023 The MathWorks, Inc.   

% Simulation parameters
dt = 0.5e-4;
dt_speed_control = 0.001;

% Motor controller parameters
max_torque = 220;
max_power = 50e3;
w_max_power = max_power/max_torque;

% Generate representative tabulated flux data. This data is linear with
% current and rotor angle, but block supports any nonlinear flux
% distribution.
N = 6;
PM = 0.1;
Ls = 0.0002;
Lm = 0.00002;
Ms = 0.00002;
Rs = 0.013;
iVec_th = [-250 0 250];         % Current vector, i
xVec_th = linspace(0,360/N,61); % Rotor angle vector, theta
xVecRad = pi/180*xVec_th;
ni = length(iVec_th);
nx = length(xVecRad);
row = Ls + Lm*cos(2*N*xVecRad);
dfluxdiMatrix = [row;row;row]; % Flux linkage partial derivative wrt current, dPhi(i,theta)/di
row_PM = -N*PM*sin(N*xVecRad);
row_RM = -2*N*Lm*sin(2*N*xVecRad);
dfluxdxMatrix = [row_PM+row_RM*iVec_th(1);row_PM;row_PM+row_RM*iVec_th(3)]; % Flux linkage partial derivative wrt angle, dPhi(i,theta)/dtheta
