import math

# --- Bernoulli's Equation for Horizontal Pipe Flow ---
def bernoulli_pipe(P1, A1, A2, rho):
    """
    Calculate pressure at point 2 in a horizontal pipe with changing diameter
    P1 : float : pressure at point 1 (Pa)
    A1 : float : cross-sectional area at point 1 (m^2)
    A2 : float : cross-sectional area at point 2 (m^2)
    rho : float : fluid density (kg/m^3)
    Returns: P2 : float : pressure at point 2 (Pa)
    """
    # Continuity equation: V1*A1 = V2*A2
    # Assume velocity at point 1 is negligible (or given)
    V1 = 0
    V2 = V1 * (A1 / A2)  # If V1=0, then V2=0, usually V1 nonzero
    # Bernoulli's equation: P1 + 0.5*rho*V1^2 = P2 + 0.5*rho*V2^2 (horizontal, h1=h2)
    P2 = P1 + 0.5 * rho * (V1**2 - V2**2)
    return P2

# Example usage:
rho_water = 1000  # kg/m^3
P1 = 200000       # Pa
A1 = 0.05         # m^2
A2 = 0.02         # m^2

P2 = bernoulli_pipe(P1, A1, A2, rho_water)
print(f"Pressure at smaller diameter: {P2:.2f} Pa")

# --- Bernoulli's Equation for Gravity-fed Beer Keg ---
def beer_keg_velocity(H, g=9.81):
    """
    Calculate velocity of fluid from height H using Bernoulli's equation
    H : float : height of fluid above tap (m)
    g : float : acceleration due to gravity (m/s^2)
    Returns: velocity V (m/s)
    """
    V = math.sqrt(2 * g * H)
    return V

# Example usage:
H_beer = 1.5  # meters
V_beer = beer_keg_velocity(H_beer)
print(f"Velocity of beer out of tap: {V_beer:.2f} m/s")