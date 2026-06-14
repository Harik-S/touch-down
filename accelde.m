function dv = accelde(state)
    dv = (1/((state.fixedMass + state.fuelMass)*state.v)) * (state.kp*(state.targetVelocity ...
        -state.v)+state.k*(state.v)^2);
end