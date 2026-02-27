import numpy as np
import matplotlib.pyplot as plt

g = 9.81  # gravity
A = 0.5   # cross section area of tank
a = 0.001 # area of drain hole
h0 = 1.5  # initial height of water

# time count array
t = np.linspace(0, 2000, 1000)

# height function
h = (np.sqrt(h0) - (a/(2*A))*np.sqrt(2*g)*t)**2

# no negative values
h[h < 0] = 0

# plot
plt.figure()
plt.plot(t, h)
plt.xlabel("Time (s)")
plt.ylabel("Water Heigh (m)")
plt.title("Draining of a Water Heater Tank")
plt.grid(True)
plt.show()