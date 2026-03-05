### **EECE5492_WDS_DesignNotes**

**March 3, 2026**

#### **1. Water Distribution Project Design Notes**
**Background:** The water distribution system (WDS) includes a reservoir that contains water from a source and one or more elevated towers that store the water pumped from the reservoir for distribution to communities in need.

The system engineers are tasked with specifying the specification of the water pump so that water is available in the elevated towers for distribution. Sensors are located in towers that provide data on the level of water. Three water levels must be monitored: 
1. **Low level** indicating that the pump needs to be turned on.
2. **High level** indicating that the pump needs to be turned off.
3. **Low-Low level** indicating a fault condition that needs to be managed.

This document summarizes some of the mathematical models that can help design the subsystems involved and their interaction so that the design objective of maintaining water level in the towers is achieved.

**Key design issues to address:**
1. Specify the size of the elevated tower and define the three thresholds to be monitored with respect to the tower dimensions (cross-sectional area and height assuming it is a cylindrical structure).
2. Determine the time taken for the water to decrease from its high to low level and from this information specify the sensing rate of the water level.
3. Specify how the reservoir pump and tower sensors communicate so that the pump is on and off when required.
4. Determine the pump capacity that is sufficient to deliver water from the reservoir to the elevated tower.

#### **1.1 Parameters Specified or to be determined**
The following quantitative information is provided in the project document to guide you in your design:
1. **Flow Rate $Q$:** The WDS shall provide the capability to transfer water from the supply reservoir to the tower at a sustained flow rate of $0.139 \text{ m}^3/\text{sec}$ ($500 \text{ m}^3/\text{hour}$).
2. **Pipe Velocity $v$:** The WDS pipe velocity at the sustained flow rate shall be between $0.9$ and $2.4 \text{ m/s}$.
3. **Electrical Power:** The WDS shall draw less than $120 \text{ kW}$. This limit is roughly $90\%$ of the available $135 \text{ kW}$ service.
4. **Reservoir Level $z_1$:** $5$ meters above reference datum plane.
5. **Discharge Level $z_2$:** $55$ meters above reference datum plane.
6. **Fitting Loss Coefficient $K_f$:** $9.95$.
7. **Pipe roughness $K_r$:** (For schedule 10 steel pipe) $K_r: 0.00005 \text{ m}$.
8. **Pump Efficiency $\eta$:** $0.84$.
9. **Pipe Diameter $D$:** $0.2 \text{ m}$.
10. **Pipe Length $L$:** $300 \text{ m}$.
11. **Pump Power $w_p$:** To be determined: Kilowatts (kW).
12. **Reynolds Number $Re$:** Select value based on type of fluid flow.

#### **Mathematical Models**
The Bernoulli equation modified with loss terms results in the equation given below, which provides the energy matching at the reservoir and the elevated tower. Using indices $1$ and $2$ to represent the surfaces of the reservoir and the discharge level of the tower:

$$\frac{P_1}{\rho g} + \frac{v_1^2}{2g} + z_1 + h_p = \frac{P_2}{\rho g} + \frac{v_2^2}{2g} + z_2 + h_l \quad (1)$$

Where **$h_p$** is the **pump head** that determines the pressure to be exerted by the pump to move water and overcome losses, and **$h_l$** is the **head loss**.

Since $P_1$ and $P_2$ are atmospheric pressures and equal, they cancel out. Additionally, the velocity $v_1$ at the reservoir surface is negligible compared to the discharge velocity $v_2$. This simplifies the equation to provide the **dynamic pump head $h_p$**:

$$h_p = (z_2 - z_1) + \frac{v_2^2}{2g} + h_l \quad (2)$$

The elevation difference $(z_2 - z_1)$ is the **static head**. The **pump power $W_p$** is determined as:

$$W_p = \frac{\rho g Q h_p}{\eta} \text{ Watts} \quad (3)$$

#### **2 Loss Specification**
Head loss $h_l$ consists of **major loss ($h_r$)** from pipe friction and **minor loss ($h_m$)** from bends and valves.

**Major Loss:**
The relation between flow rate $Q$ and velocity $v$ is $Q = vA$, where $A = \frac{\pi D^2}{4}$. For an estimate, if $v = 2.0 \text{ m/sec}$ and $Q = 0.139 \text{ m}^3/\text{s}$, then $A = 0.0695 \text{ m}^2$ and $D = 0.29 \text{ m}$.
The major head loss is calculated using the **Darcy-Weisbach equation**:

$$h_r = \left( \frac{f L}{D} \right) \frac{v^2}{2g} \quad (4)$$

Where **$f$** is the dimensionless friction factor found using the **Reynolds number ($Re$)**:

$$Re = \frac{vD\rho}{\mu} = \frac{vD}{\nu} \quad (5)$$

Using $v = 2.0 \text{ m/s}$, $D = 0.29 \text{ m}$, density $\rho \approx 1000 \text{ kg/m}^3$, and kinematic viscosity $\nu = 1.77 \text{ mm}^2/\text{s}$, the $Re = 336,127$.
The **relative pipe roughness** is $\frac{K_r}{D} = \frac{0.00005}{0.29} = 0.00016$. Using the Moody Chart, $f \approx 0.015$, resulting in $h_r = 3.08$.

**Minor Loss:**
Using the fitting loss coefficient $K_f = 9.95$:

$$h_m = \frac{K_f v^2}{2g} \quad (6)$$

For $v = 2.0 \text{ m/sec}$, $h_m = 2.02 \text{ m}$.

**Total Head Loss and Power Calculation:**
*   **Total head loss ($h_l$):** $3.08 + 2.02 = 5.1 \text{ m}$.
*   **Dynamic head ($H_d$):** $\text{Static Head} + h_l = 50 + 5.1 = 55.1 \text{ m}$.
*   **Pump head ($h_p$):** $55.1 + \frac{v^2}{2g} = 55.1 + 19.62 = 74.73 \text{ m}$.
*   **Pump power ($W_p$):** $121.3 \text{ kWatts}$.