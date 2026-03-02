%% PMSM with Thermal Model
% 
% This example shows a nonlinear model of a PMSM with thermal dependency.
% The PMSM behavior is defined by tabulated nonlinear flux linkage data.
% Motor losses are turned into heat in the stator winding and rotor thermal
% ports.
% 

% Copyright 2008-2023 The MathWorks, Inc.



%% Model

open_system('PMSMWithThermal')

set_param(find_system('PMSMWithThermal','FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Thermal Model Subsystem

open_system('PMSMWithThermal/Thermal Model','force')

%% Simulation Results from Simscape Logging
%%
%
% The plot below shows motor speed and winding currents as the control
% system attempts to track a reference signal.  A load torque is applied to
% the shaft, and the effect on the system is shown in the winding currents.
%


PMSMWithThermalPlotSpeed;
%%
%
% The plot below shows motor speed, torque, and temperature of motor
% components.  The thermal model of the motor models heat transfer between
% the three windings and the rotor.
%


PMSMWithThermalPlotThermal;

%% Results from Real-Time Simulation
%%
%
% This example has been tested on a Speedgoat Performance real-time target 
% machine with an Intel(R) 3.5 GHz i7 multi-core CPU. This model can run 
% in real time with a step size of 50 microseconds.

%%

