% Code to plot simulation results from PMSMWithThermal
%% Plot Description:
%
% The plot below shows motor speed and winding currents as the control
% system attempts to track a reference signal.  A load torque is applied to
% the shaft, and the effect on the system is shown in the winding currents.

% Copyright 2016-2023 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
if ~exist('simlog_PMSMWithThermal', 'var') || ...
        simlogNeedsUpdate(simlog_PMSMWithThermal, 'PMSMWithThermal') 
    sim('PMSMWithThermal')
    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_PMSMWithThermal', 'var') || ...
        ~isgraphics(h1_PMSMWithThermal, 'figure')
    h1_PMSMWithThermal = figure('Name', 'PMSMWithThermal');
end
figure(h1_PMSMWithThermal)
clf(h1_PMSMWithThermal)

% Get simulation results
simlog_t = simlog_PMSMWithThermal.FEM_Parameterized_PMSM.R.w.series.time;
simlog_wMotor = simlog_PMSMWithThermal.FEM_Parameterized_PMSM.R.w.series.values('rpm');
simlog_loadTrq = simlog_PMSMWithThermal.Load.Torque_Source.t.series.values('N*m');

simlog_iaMotor = simlog_PMSMWithThermal.FEM_Parameterized_PMSM.i_a.series.values('A');
simlog_ibMotor = simlog_PMSMWithThermal.FEM_Parameterized_PMSM.i_b.series.values('A');
simlog_icMotor = simlog_PMSMWithThermal.FEM_Parameterized_PMSM.i_c.series.values('A');

simlog_wRef = logsout_PMSMWithThermal.get('wRef');

temp_colororder = get(gca,'defaultAxesColorOrder');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
yyaxis left
plot(simlog_t, simlog_wMotor, 'LineWidth', 1)
hold on
plot(simlog_wRef.Values.Time, simlog_wRef.Values.Data*60/(2*pi),'k--', 'LineWidth', 1)
hold off
grid on
ylabel('Speed (RPM)')
yyaxis right
plot(simlog_t, simlog_loadTrq, 'LineWidth', 1);
temp_rangeTrq = max(simlog_loadTrq)-min(simlog_loadTrq);
set(gca,'YLim',[min(simlog_loadTrq)-0.1*temp_rangeTrq max(simlog_loadTrq)+0.1*temp_rangeTrq]);
ylabel('Torque (N*m)')
title('Motor Speed')
legend({'Measured Speed','Commanded Speed','Load Torque'},'Location','East');

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_iaMotor, 'LineWidth', 1,'Color',temp_colororder(3,:))
hold on
plot(simlog_t, simlog_ibMotor, 'LineWidth', 1,'Color',temp_colororder(4,:))
plot(simlog_t, simlog_icMotor, 'LineWidth', 1,'Color',temp_colororder(5,:))
hold off
grid on
title('Winding Currents')
ylabel('Current (A)')
xlabel('Time (s)')
legend({'Winding A','Winding B','Winding C'},'Location','Best');

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_wMotor simlog_wRef simlog_loadTrq temp_rangeTrq
clear simlog_iaMotor simlog_ibMotor simlog_icMotor
