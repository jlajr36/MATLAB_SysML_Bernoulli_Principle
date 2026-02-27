import math
import matplotlib.pyplot as plt

# Constants
g = 9.81  # gravity in m/s^2

# Tank parameters
A_tank = 1.0    # m^2, cross-sectional area of the tank
A_hole = 0.01   # m^2, area of the discharge hole
H0 = 2.0        # m, initial water height

# Simulation parameters
dt = 0.01       # seconds, time step
H = H0          # current water height
t = 0.0         # current time

# Lists to store results for plotting
time_list = [t]
height_list = [H]

# Simulation loop
while H > 0:
    v = math.sqrt(2 * g * H)          # velocity from Torricelli's law
    dH = -(A_hole / A_tank) * v * dt  # change in water height
    H += dH
    t += dt
    
    # Store results
    time_list.append(t)
    height_list.append(H if H > 0 else 0)  # avoid negative height

# Plot results
plt.plot(time_list, height_list)
plt.xlabel('Time (s)')
plt.ylabel('Water Height (m)')
plt.title('Tank Draining Simulation')
plt.grid(True)
plt.show()

print(f"Total drain time: {t:.2f} seconds")