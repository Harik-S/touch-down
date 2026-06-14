function newstate = simulator(state, V, k)
% simulates the increase of 1 timestep using Euler's Method.
% INPUTS: Thrust (N) from controller. state - see lander.m for its
% definition
% OUTPUTS: new version of state
% BY HARIK 16/02/2026
    newstate = state;
    k1v = accelde(state);
    k1m = massde(state);
    newstate.targetVelocity=1/2  *  (V(k)+V(k+1));
    newstate.fuelMass = state.dh/2  * k1m + state.fuelMass;
    newstate.v = state.dh/2  *  k1v + state.v;
    k2v = accelde(newstate);
    k2m = massde(newstate);
    newstate.fuelMass = state.dh/2  * k2m + state.fuelMass;
    newstate.v = state.dh/2  *  k2v + state.v;
    k3v = accelde(newstate);
    k3m = massde(newstate);
    newstate.targetVelocity=V(k+1);
    newstate.fuelMass = state.dh  * k3m + state.fuelMass;
    newstate.v = state.dh  *  k3v + state.v;
    k4v = accelde(newstate);
    k4m = massde(newstate);
    newstate.v = state.v + state.dh/6  * (k1v + 2*k2v + 2*k3v + k4v);
    newstate.fuelMass = state.fuelMass + state.dh/6  * (k1m + 2*k2m + 2*k3m + k4m);
    newstate.a = 0.5 * ((newstate.v)^2 - (state.v)^2)/state.dh;
end