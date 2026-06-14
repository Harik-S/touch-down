function dm = massde(state)
    dm = -(state.B/state.v)*abs(state.kp*(state.targetVelocity-state.v)+state.g*(state.fixedMass+state.fuelMass));
end