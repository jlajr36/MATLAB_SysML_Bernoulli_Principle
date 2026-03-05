clc;
clear;
close all;

%% ==============================
%  WATER DISTRIBUTION SYSTEM
%  Dynamic Tank + Pump Model
% ===============================

%% Physical Parameters
rho = 1000;          % Water density (kg/m^3)
g   = 9.81;          % Gravity (m/s^2)

%% Tank Parameters
Dt = 10;                             % Tank diameter (m)
At = pi*Dt^2/4;                      % Cross-sectional area (m^2)

HL  = 20;                            % High Level (m)
LL  = 10;                            % Low Level (m)
LLL = 5;                             % Low-Low Level (m)

%% Pump Parameters
Qin_max = 0.139;                     % Pump flow when ON (m^3/s)
Hp = 55.52;                          % Required pump head (m)
eta = 0.84;                          % Efficiency
PumpPower = rho*g*Qin_max*Hp/eta;    % Hydraulic power (W)

%% Demand
Qout = 0.05;                         % Constant demand (m^3/s)

%% Simulation Parameters
dt = 1;                              % Time step (s)
T  = 20000;                          % Total time (s)
time = 0:dt:T;

%% Initialization
h = zeros(size(time));               % Tank level (m)
pump = zeros(size(time));            % Pump state (1=ON,0=OFF)
energy = 0;                          % Energy consumption (J)

h(1) = 15;                           % Initial level (m)

%% ==============================
%        SIMULATION LOOP
% ===============================
for k = 1:length(time)-1
    
    % ----- Controller (Hysteresis ON/OFF) -----
    if h(k) <= LL
        pump(k) = 1;
    elseif h(k) >= HL
        pump(k) = 0;
    else
        pump(k) = pump(max(k-1,1));
    end
    
    % ----- Fault Detection -----
    if h(k) <= LLL
        warning('Low-Low Level Fault Triggered');
    end
    
    % ----- Flow Balance -----
    Qin = pump(k) * Qin_max;
    dhdt = (Qin - Qout) / At;
    
    % ----- Euler Integration -----
    h(k+1) = h(k) + dhdt*dt;
    
    % Prevent negative level
    if h(k+1) < 0
        h(k+1) = 0;
    end
    
    % ----- Energy Calculation -----
    energy = energy + pump(k)*PumpPower*dt;
end

%% Final Pump State
pump(end) = pump(end-1);

%% ==============================
%        RESULTS
% ===============================

% Convert energy to kWh
energy_kWh = energy / (1000*3600);

% Count pump cycles
cycles = sum(diff(pump)==1);

fprintf('Total Energy Used: %.2f kWh\n', energy_kWh);
fprintf('Number of Pump Cycles: %d\n', cycles);

%% ==============================
%            PLOTS
% ===============================

figure('Color','w');

subplot(3,1,1)
plot(time,h,'b','LineWidth',2)
hold on
yline(HL,'r--','High Level')
yline(LL,'g--','Low Level')
yline(LLL,'k--','Low-Low')
ylabel('Water Level (m)')
title('Tank Level vs Time')
grid on

subplot(3,1,2)
plot(time,pump,'LineWidth',2)
ylabel('Pump State')
ylim([-0.1 1.1])
yticks([0 1])
yticklabels({'OFF','ON'})
title('Pump ON/OFF Status')
grid on

subplot(3,1,3)
plot(time, pump*PumpPower/1000,'LineWidth',2)
ylabel('Power (kW)')
xlabel('Time (s)')
title('Instantaneous Pump Power')
grid on