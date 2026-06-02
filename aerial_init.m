%% UAUV Initialization Script (aerial_init.m)
% Dual Domain UAUV for Offshore Wind Turbine Inspection
% Run this before every simulation.

%% 1. Environmental Parameters
g       = 9.81;         % Gravity [m/s^2]
rho_air = 1.225;        % Air density [kg/m^3]

%% 2. Vehicle Mass & Inertia
m       = 25.0;         % Total mass [kg]
Ixx     = 1.2;          % Roll inertia [kg*m^2]
Iyy     = 1.2;          % Pitch inertia [kg*m^2]
Izz     = 2.0;          % Yaw inertia [kg*m^2]
Ixz     = 0.0;
I_matrix = diag([Ixx, Iyy, Izz]);

%% 3. Geometry
L_arm   = 0.25;

%% 4. Aerodynamics & Actuators
CT_prop = 0.039;
CQ_prop = 9.8e-4;
D_prop  = 0.80;
tau_m   = 0.06;
Jr      = 6.0e-5;
w_max   = 700.0;
kT      = CT_prop * rho_air * (D_prop^4) / (4 * pi^2);
kQ      = CQ_prop * rho_air * (D_prop^5) / (4 * pi^2);

%% 5. Drag Profile
Cd      = [1.28; 1.28; 1.28];
A_face  = [0.1; 0.1; 0.2];

%% 6. Physical Limits
att_lim       = 0.45;
tau_phi_max   = 12.0;
tau_theta_max = 12.0;
tau_psi_max   = 10.0;

%% 7. Outer Position Loop Gains -- lawnmower_event mode
Kp_r = 0.25;    Ki_r = 0.02;    Kd_r = 1.0;    i_lim_r = 5.0;
Kp_t = 0.30;    Ki_t = 0.02;    Kd_t = 1.1;    i_lim_t = 5.0;
Kp_z = 1.00;    Ki_z = 0.10;    Kd_z = 2.0;    i_lim_z = 10.0;

%% 8. Inner Attitude Loop Gains -- lawnmower_event mode
Kp_phi   = 61.4;    Ki_phi   = 0.3;   Kd_phi   = 18.39;   i_lim_phi   = 10.0;
Kp_theta = 198.1;   Ki_theta = 0.3;   Kd_theta = 45.6;    i_lim_theta = 10.0;
Kp_psi   = 39.14;   Ki_psi   = 0.1;   Kd_psi   = 20.71;   i_lim_psi   = 5.0;

%% 9. Waypoint manager
z_tolerance = 2;   % EVENT_Z_TOL [m]
theta_tolerance = 0.4;   % EVENT_y_TOL [m]
r_tolerance = 2;   % EVENT_x_TOL [m]

%% 10. Hover rotor speed (used by trajectory script for x0)
omega_h = sqrt((m*g) / (4*kT));

disp('UAUV Parameters successfully loaded into Base Workspace.');
