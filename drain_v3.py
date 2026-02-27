import math

# Constants
g = 9.81  # gravity in m/s^2

# Tank parameters
A_tank = 1.0       # m^2, cross-sectional area of the tank
A_hole = 0.01      # m^2, area of the discharge hole
H = 2.0            # m, initial height of water

# Calculate drain time
T = (2 * A_tank * math.sqrt(H)) / (A_hole * math.sqrt(2 * g))

print(f"Time to drain the tank: {T:.2f} seconds")