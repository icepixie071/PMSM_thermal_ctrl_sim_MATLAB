% Code to plot simulation results from PMSMWithThermal
%% Plot Description:
%
% The plot below shows motor speed, torque, and temperature of motor
% components.  The thermal model of the motor models heat transfer between
% the three windings and the rotor.

% Copyright 2016-2023 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
if ~exist('simlog_PMSMWithThermal', 'var') || ...
        simlogNeedsUpdate(simlog_PMSMWithThermal, 'PMSMWithThermal') 
    sim('PMSMWithThermal')
    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
end

% Reuse figure if it exists, else create new figure
if ~exist('h2_PMSMWithThermal', 'var') || ...
        ~isgraphics(h2_PMSMWithThermal, 'figure')
    h2_PMSMWithThermal = figure('Name', 'PMSMWithThermal');
end
figure(h2_PMSMWithThermal)
clf(h2_PMSMWithThermal)

% Get simulation results
simlog_t = simlog_PMSMWithThermal.FEM_Parameterized_PMSM.R.w.series.time;
simlog_wMotor = simlog_PMSMWithThermal.FEM_Parameterized_PMSM.R.w.series.values('rpm');
simlog_trqMotor = simlog_PMSMWithThermal.FEM_Parameterized_PMSM.torque.series.values('N*m');

simlog_waTemp = simlog_PMSMWithThermal.FEM_Parameterized_PMSM.HA.T.series.values('degC');
simlog_wbTemp = simlog_PMSMWithThermal.FEM_Parameterized_PMSM.HB.T.series.values('degC');
simlog_wcTemp = simlog_PMSMWithThermal.FEM_Parameterized_PMSM.HC.T.series.values('degC');
simlog_roTemp = simlog_PMSMWithThermal.FEM_Parameterized_PMSM.HR.T.series.values('degC');

temp_colororder = get(gca,'defaultAxesColorOrder');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
yyaxis left
plot(simlog_t, simlog_wMotor, 'LineWidth', 1)
grid on
ylabel('Speed (RPM)')
yyaxis right
plot(simlog_t, simlog_trqMotor, 'LineWidth', 1);
ylabel('Torque (N*m)')
title('Motor Speed and Torque')
legend({'Speed','Torque'},'Location','East');

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_waTemp, 'LineWidth', 1,'Color',temp_colororder(3,:))
hold on
plot(simlog_t, simlog_wbTemp, 'LineWidth', 1,'Color',temp_colororder(4,:))
plot(simlog_t, simlog_wcTemp, 'LineWidth', 1,'Color',temp_colororder(5,:))
plot(simlog_t, simlog_roTemp, 'LineWidth', 1,'Color',temp_colororder(6,:))
hold off
grid on
title('Temperature of Motor Components')
ylabel('Temperature (degC)')
xlabel('Time (s)')
legend({'Winding A','Winding B','Winding C','Rotor'},'Location','Best');

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_wMotor simlog_trqMotor
clear simlog_waTemp simlog_wbTemp simlog_wcTemp simlog_roTemp
