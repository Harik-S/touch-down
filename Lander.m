function [pass_test,FuelLeft] = Lander(H_t, V_t, h_i, v_i)
% A design for a simulated rocket landing. 
% Simulation uses Euler's Method to predict next steps. 
% Lander starts at 3000 metres high, and hopes to land gently by use of a controller.
% VERSION 8 - FUNCTION
% INPUT - table of values for H at certain values of V
% OUTPUT - landing velocity, fuel and acceleration
% by harik 4/5/2026
 
% **** Main Script *****
% 0. Clear workspace etc for new run

% 1. Initialise the values.
% 
%    1.1 Set the Model Parameters.
% use the structure state to store mass with no fuel, mass with fuel,
% gravitational acceleration, velocity, height, time and the step size.
state.fixedMass = 500; % kg Rocket mass with no fuel
state.fuelMass = 1500; % kg Mass of fuel (changing)
state.g = 9.81; % Acceleration due to gravity m s^-2
state.a = -state.g; % Acceleration of rocket, constantly changing but initialised to -g, m s^-2
state.v = v_i; % Velocity of rocket, initialised to -300, m s^-1
state.h = h_i; % Height of rocket, initialised to initial height of 3000, m
state.B = 0.001; % burn rate, kg N^-1 s^-1
state.k = 1/3; % drag coefficient, N m^-2 s^2
state.dh = (H_t(2)-H_t(1));
state.kp = 1000;
state.targetVelocity=-300;
%    1.2 Initialise vectors to store the data to plot
H = H_t; % initialise H, using nan ensures that the data points that weren't used won't be plotted, storing height
k=1;
pass_test=true;
A = H_t;
V = H_t;
for h_i = H(1:(end-1)) % there is a limit on k to ensure that the program does terminate
% 2. Repeat for each time step while the lander is above the ground.
    state.targetVelocity = V_t(k);
    A(k)=state.a;
    V(k)=state.v;
% 2.3 Run the simulator to predict what will happen over the next time step.
    state = simulator(state, V_t, k);
    if (abs(state.a)>6*state.g)
        pass_test=false;
        FuelLeft = 0;
        return
    end
    if (state.fuelMass<=0)
        pass_test=false;
        FuelLeft = 0;
        return
    end
    if (state.v>0)
        pass_test=false;
        FuelLeft = 0;
        return
    end
% 2.4 incrememnt k
    k=k+1;
end

if (state.v>2)
    pass_test=false;
end
FuelLeft = state.fuelMass;
% PlotGraphs(A,V,TV,H,M,T)
end