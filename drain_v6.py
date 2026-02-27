import math
import numpy as np
import matplotlib.pyplot as plt

# --------------------------
# Bernoulli for pipe flow
# --------------------------
def velocity_from_area(A1, A2, V1=1.0):
    """Calculate velocity at smaller area using continuity equation"""
    return V1 * (A1 / A2)

def pressure_from_velocity(P1, rho, V1, V2):
    """Bernoulli: horizontal flow"""
    return P1 + 0.5 * rho * (V1**2 - V2**2)

# Parameters
rho = 1000  # kg/m^3, water
P1 = 200000  # Pa
A1 = 0.05  # m^2
A2_values = np.linspace(0.05, 0.01, 50)  # decreasing pipe areas

# Compute velocities and pressures
V2_values = [velocity_from_area(A1, A2) for A2 in A2_values]
P2_values = [pressure_from_velocity(P1, rho, 1.0, V2) for V2 in V2_values]

# Plot pressure vs velocity
plt.figure(figsize=(10,5))
plt.plot(V2_values, P2_values)
plt.xlabel("Velocity (m/s)")
plt.ylabel("Pressure (Pa)")
plt.title("Bernoulli: Pressure vs Velocity in a Narrowing Pipe")
plt.grid(True)
plt.show()

# --------------------------
# Beer keg velocity vs height
# --------------------------
def beer_velocity(H, g=9.81):
    return np.sqrt(2 * g * H)

H_values = np.linspace(0.1, 2.0, 50)  # height in meters
V_beer = beer_velocity(H_values)

plt.figure(figsize=(10,5))
plt.plot(H_values, V_beer)
plt.xlabel("Height of Beer Above Tap (m)")
plt.ylabel("Velocity (m/s)")
plt.title("Velocity of Beer from Tap vs Height")
plt.grid(True)
plt.show()