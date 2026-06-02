%% UAUV Underwater Phase Initialization (init_uw.m)
% Run this to populate the Base Workspace for the 20-state UW Plant

% 1. Environmental Parameters
g         = 9.81;       % Gravity (m/s^2)
rho_water = 1025.0;     % Density of seawater (kg/m^3)

% 2. Geometry & Volume
L_box = 0.50;           % Length (m)
W_box = 0.50;           % Width (m)
H_box = 0.30;           % Height (m)

% Dynamically calculate submerged volume and buoyancy
V_sub = L_box * W_box * H_box;
F_buoyancy = rho_water * V_sub * g; % Upward buoyant force (N)

% Frontal Areas for Hydrodynamic Drag [x; y; z]
A_face = [W_box * H_box; 
    L_box * H_box; 
    L_box * W_box];
Cd = [1.2; 1.2; 1.5];   % Bluff-body drag coefficients

% 3. Mass & Added Mass (Translational)
m = 25.0;               % Dry mass (kg)
mass_displaced = rho_water * V_sub;

% Added mass fractions (10% in X, 40% in Y, 25% in Z for a typical box)
m_added = [0.10; 0.40; 0.25] * mass_displaced;

% Pre-compute the Effective Total Mass vector for the ODE
M_total = m + m_added;  

% 4. Inertia & Added Inertia (Rotational)
Ixx = 1.2; Iyy = 1.2; Izz = 2.0; % Dry inertias (kg*m^2)

% Added inertia (approx 20% to rotate the surrounding water envelope)
I_added = [0.2 * Ixx; 0.2 * Iyy; 0.2 * Izz];

% Pre-compute the Effective Total Inertia Matrix for the ODE
I_matrix_total = diag([Ixx + I_added(1), Iyy + I_added(2), Izz + I_added(3)]);

% 5. Actuators (Propellers & Servos)
gamma_deg = 45.0;       
gamma = deg2rad(gamma_deg); % Inward tilt from walls
tau_m = 0.06;           % Motor spool time constant (s)
tau_servo = 0.15;       % Servo rotation time constant (s)

% Bi-directional propeller constants
kT_fwd = 5.0e-4;        % Thrust coeff forward (N*s^2/rad^2)
kT_rev = 4.0e-4;        % Thrust coeff reverse (less efficient)
kQ_fwd = 1.0e-5;        % Torque coeff forward (N*m*s^2/rad^2)
kQ_rev = 0.8e-5;        % Torque coeff reverse 

disp('Underwater Physical Parameters Loaded Successfully.');