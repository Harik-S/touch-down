# Touch Down — Rocket Landing Control & Optimisation

A MATLAB simulation and optimisation framework for autonomously landing a variable-mass rocket subject to fuel, acceleration and trajectory constraints.

The project models the dynamics of a descending rocket, applies feedback control to track a target velocity profile, tests the controller under perturbed initial conditions, and optimises the descent trajectory for improved fuel efficiency.

## Model

The simulated lander begins at altitude with a specified downward velocity and finite fuel supply.

Its state includes:

* altitude and velocity;
* dry mass and remaining fuel mass;
* gravitational acceleration;
* aerodynamic drag;
* thrust and acceleration;
* target descent velocity.

As fuel is consumed, the vehicle mass changes, coupling the propulsion and trajectory dynamics.

The model also imposes practical constraints including limited fuel, bounded acceleration and a requirement to reach the ground without reversing direction.

## Feedback Control

The lander tracks a target velocity trajectory using proportional feedback control.

At each simulation step, the controller compares the current velocity with the desired velocity and determines the required thrust subject to the model constraints.

Rather than prescribing a single constant descent velocity, the target velocity is represented as a function of altitude, allowing the descent profile itself to be optimised.

## Numerical Simulation

The vehicle dynamics are propagated numerically using a multi-stage integration scheme implemented in `simulator.m`.

The simulation updates:

1. acceleration;
2. fuel consumption;
3. velocity;
4. target velocity;

throughout the descent.

Separate functions define the acceleration and mass-flow dynamics:

* `accelde.m` — acceleration dynamics;
* `massde.m` — fuel-mass dynamics;
* `simulator.m` — numerical state propagation;
* `Lander.m` — controller and landing simulation.

## Trajectory Optimisation

`LanderOptimiser.m` treats the target velocity profile as the optimisation variable.

The objective is evaluated through repeated landing simulations and robustness tests, allowing the trajectory to be adjusted to improve performance while satisfying landing constraints.

MATLAB's numerical optimisation tools are used to search over candidate velocity profiles.

## Robustness Testing

A controller that succeeds for one exact initial condition may fail when the initial state changes.

`robustTest.m` therefore evaluates candidate trajectories across perturbed initial conditions, testing whether the controller can continue to land successfully while respecting fuel and acceleration constraints.

This makes the optimisation problem one of finding a trajectory that is not only fuel-efficient but also robust to uncertainty in the initial state.

## Repository Structure

```text
touch-down/
├── Lander.m
├── LanderOptimiser.m
├── simulator.m
├── accelde.m
├── massde.m
└── robustTest.m
```

### `Lander.m`

Runs the landing controller and checks trajectory constraints.

### `simulator.m`

Numerically propagates the rocket state through the descent.

### `accelde.m`

Defines the rocket's acceleration dynamics.

### `massde.m`

Models fuel consumption.

### `robustTest.m`

Evaluates candidate trajectories over variations in initial conditions.

### `LanderOptimiser.m`

Optimises the target velocity trajectory using repeated simulations.

## Key Concepts

The project combines:

* feedback control;
* nonlinear physical modelling;
* variable-mass dynamics;
* numerical integration;
* constrained optimisation;
* robustness testing;
* MATLAB scientific computing.

## Possible Extensions

Natural extensions include:

* replacing proportional control with LQR or model predictive control;
* explicitly modelling actuator/thrust limits;
* introducing stochastic sensor and state-estimation errors;
* optimising thrust directly rather than a target-velocity trajectory;
* comparing integration schemes and numerical stability;
* extending the dynamics to two or three dimensions;
* incorporating trajectory constraints and obstacle avoidance.
