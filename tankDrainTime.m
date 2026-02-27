%% tankDrainTime.m
% Calculates the time for a water tank to drain from High to Low and LowLow levels
% using Bernoulli's principle. Compatible with parameters from a SysML model.

%% --- Input Parameters (from SysML) ---
A_tank = 2.0;        % Tank cross-sectional area [m^2]
a_pipe = 0.05;       % Exit pipe cross-sectional area [m^2]
g = 9.81;            % Gravitational acceleration [m/s^2]

% Tank water level thresholds [m]
h_high = 5.0;        % High Level (pump turns OFF)
h_low = 1.0;         % Low Level (pump turns ON)
h_lowlow = 0.5;      % Low Low Level (fault condition)

%% --- Calculations ---

% Constant factor for Bernoulli equation
k = 2 * A_tank / a_pipe / sqrt(2 * g);

% Time to drain from High to Low
t_high_to_low = k * (sqrt(h_high) - sqrt(h_low));

% Time to drain from High to LowLow (fault)
t_high_to_lowlow = k * (sqrt(h_high) - sqrt(h_lowlow));

%% --- Display Results ---
fprintf('Time to drain from High to Low Level: %.2f seconds\n', t_high_to_low);
fprintf('Time to drain from High to LowLow Level (fault): %.2f seconds\n', t_high_to_lowlow);

%% --- Optional: Suggest sensor sampling interval ---
% Sample at least 10 times during drain
sensor_interval = t_high_to_low / 10;
fprintf('Suggested sensor sampling interval: %.2f seconds\n', sensor_interval);