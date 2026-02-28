function [t, k] = tankDrainTime(A_tank, a_pipe, g, h_start, h_end)
% tankDrainTime
% ------------------------------------------------------------
% Calculates the time required for a tank to drain between two
% water levels using Bernoulli's equation (Torricelli’s Law).
%
% Governing equation:
%   dh/dt = -(a_pipe/A_tank)*sqrt(2*g*h)
%
% Integrated solution:
%   t = (2*A_tank)/(a_pipe*sqrt(2*g)) *
%       ( sqrt(h_start) - sqrt(h_end) )
%
% Inputs:
%   A_tank   - Cross-sectional area of tank [m^2]
%   a_pipe   - Cross-sectional area of discharge pipe [m^2]
%   g        - Gravitational acceleration [m/s^2]
%   h_start  - Initial water height [m]
%   h_end    - Final water height [m]
%
% Outputs:
%   t        - Drain time between levels [s]
%   k        - Constant coefficient used in solution
%
% Assumptions:
%   - Incompressible fluid
%   - Inviscid (no friction losses)
%   - Steady discharge
%   - Uniform tank cross-section
%
% ------------------------------------------------------------

    %% --- Input Validation ---
    if A_tank <= 0 || a_pipe <= 0
        error('Areas must be positive.');
    end

    if g <= 0
        error('Gravity must be positive.');
    end

    if h_start < 0 || h_end < 0
        error('Heights must be non-negative.');
    end

    if h_start < h_end
        error('h_start must be greater than or equal to h_end.');
    end

    %% --- Compute Constant Coefficient ---
    k = (2 * A_tank) / (a_pipe * sqrt(2 * g));

    %% --- Compute Drain Time ---
    t = k * (sqrt(h_start) - sqrt(h_end));

end