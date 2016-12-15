% veh_model_params.m

%%%clear

% Vehicle specs
L1 = 1.6; % (m) front to rear axle length
L2 = 0.8; % (m) ratio of length from rear axle to center versus overall length, L.
R = 1/5;  % steering ratio input to wheel steer angle, alpha
Ak = 100; % (N-mm)/(m-rad/s)  
m = 2000; % (Kg) mass
b = 100;  % (N-s)/m 


% ACC control parameters
V_Ki = 50;
V_Kp = 5000;

P_Kp = 3000;
P_Kd = 5000;
dT = 0.01;

Kd_PD = 0.03;   % 0-0.1
Kp_PD = 0.4;    % 0-1
Kd_PID = 75;    % 0-100
Ki_PID = 0.002;     % very small
Kp_PID = 550;   % >400

% Chase car controller
% essentially a PI controller
% One integrator is our chase car and the other integrator 
% is added so that we get 0 tracking error for a ramp input
p = [-10,-15];  % damped poles
K = acker([0,1;0,0], [0;1], p);
C = tf([K(1) K(2)],[1 0]);
[A,B,C,D] = tf2ss(C.num{1}, C.den{1});

Chase_Ctrl = c2d(ss(A,B,C,D), dT, 'matched');
Chase_Ctrl_x0 = 0;

v0 = 0;