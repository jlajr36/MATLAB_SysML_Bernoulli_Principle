# **EECE5492 – Water Distribution System (WDS) Design Notes**

**Date:** March 3, 2026

---

# **1. Water Distribution System Overview**

## 1.1 Background

The Water Distribution System (WDS) consists of:

* A **reservoir** supplying water
* A **pump** transferring water
* An **elevated cylindrical tower** for storage and distribution
* **Level sensors** installed in the tower

The objective is to maintain adequate water level in the tower while satisfying hydraulic and electrical constraints.

---

# **2. Control Levels in the Tower**

Three water levels must be monitored:

1. **Low Level (LL)** – Pump turns ON
2. **High Level (HL)** – Pump turns OFF
3. **Low-Low Level (LLL)** – Fault condition (critical low level)

These thresholds are defined relative to the tower height ( H ) and cross-sectional area ( A_t ).

For a cylindrical tower:

[
V = A_t h = \frac{\pi D_t^2}{4} h
]

Where:

* ( D_t ) = tower diameter
* ( h ) = water height

---

# **3. System Design Specifications**

| Parameter                         | Value                                       |
| --------------------------------- | ------------------------------------------- |
| Flow rate ( Q )                   | 0.139 m³/s (500 m³/hr)                      |
| Pipe velocity range               | 0.9 – 2.4 m/s                               |
| Electrical limit                  | 120 kW                                      |
| Reservoir elevation ( z_1 )       | 5 m                                         |
| Tower discharge elevation ( z_2 ) | 55 m                                        |
| Elevation difference              | 50 m                                        |
| Pipe length ( L )                 | 300 m                                       |
| Pipe diameter ( D )               | 0.29 m (selected to satisfy velocity limit) |
| Pipe roughness ( K_r )            | 0.00005 m                                   |
| Fitting loss coefficient ( K_f )  | 9.95                                        |
| Pump efficiency ( \eta )          | 0.84                                        |
| Water density ( \rho )            | 1000 kg/m³                                  |
| Kinematic viscosity ( \nu )       | 1.77×10⁻⁶ m²/s                              |

---

# **4. Hydraulic Analysis**

## 4.1 Flow Velocity

[
A = \frac{\pi D^2}{4}
]

[
A = \frac{\pi (0.29)^2}{4} = 0.066 \text{ m}^2
]

[
v = \frac{Q}{A} = \frac{0.139}{0.066}
]

[
v \approx 2.1 \text{ m/s}
]

This satisfies the required velocity range.

---

## 4.2 Reynolds Number

[
Re = \frac{vD}{\nu}
]

[
Re = \frac{(2.1)(0.29)}{1.77\times10^{-6}}
]

[
Re \approx 344,000
]

Flow is **fully turbulent**.

Relative roughness:

[
\frac{K_r}{D} = \frac{0.00005}{0.29} = 0.00017
]

From the Moody chart:

[
f \approx 0.015
]

---

## 4.3 Major Head Loss (Darcy–Weisbach)

[
h_r = \left(\frac{fL}{D}\right)\frac{v^2}{2g}
]

[
h_r = \left(\frac{0.015 \times 300}{0.29}\right)\frac{(2.1)^2}{2(9.81)}
]

[
h_r \approx 3.1 \text{ m}
]

---

## 4.4 Minor Loss

[
h_m = \frac{K_f v^2}{2g}
]

[
h_m = \frac{9.95 (2.1)^2}{2(9.81)}
]

[
h_m \approx 2.2 \text{ m}
]

---

## 4.5 Total Head Loss

[
h_l = h_r + h_m
]

[
h_l = 3.1 + 2.2
]

[
h_l = 5.3 \text{ m}
]

---

# **5. Pump Head Requirement**

Using the modified Bernoulli equation:

[
h_p = (z_2 - z_1) + \frac{v^2}{2g} + h_l
]

Velocity head:

[
\frac{v^2}{2g} = \frac{(2.1)^2}{2(9.81)} \approx 0.22 \text{ m}
]

Thus:

[
h_p = 50 + 0.22 + 5.3
]

[
h_p = 55.52 \text{ m}
]

---

# **6. Pump Power Requirement**

[
W_p = \frac{\rho g Q h_p}{\eta}
]

[
W_p = \frac{(1000)(9.81)(0.139)(55.52)}{0.84}
]

[
W_p \approx 90 \text{ kW}
]

---

# **7. Electrical Constraint Verification**

Electrical limit: **120 kW**

Calculated requirement:

[
90 \text{ kW} < 120 \text{ kW}
]

✅ **Design satisfies electrical power constraint**
Margin ≈ 30 kW

---

# **8. Operational Considerations**

### 8.1 Tower Level Dynamics

Water volume change rate:

[
\frac{dV}{dt} = Q
]

Time to drop between High and Low levels:

[
t = \frac{A_t (h_H - h_L)}{Q}
]

This determines:

* Required sensor sampling rate
* Pump cycling frequency

---

### 8.2 Control Logic

* If level ≤ Low → Pump ON
* If level ≥ High → Pump OFF
* If level ≤ Low-Low → Fault alarm + emergency protocol

Communication between sensors and pump controller may use:

* Hardwired relay logic
* PLC-based control system
* SCADA integration

---

# **9. Final Design Summary**

| Item                | Result       |
| ------------------- | ------------ |
| Static Head         | 50 m         |
| Total Loss          | 5.3 m        |
| Pump Head Required  | 55.5 m       |
| Pump Power Required | 90 kW        |
| Electrical Limit    | 120 kW       |
| Status              | ✅ Acceptable |

---

# **Conclusion**

The WDS design:

* Meets hydraulic requirements
* Maintains pipe velocity within specification
* Satisfies electrical power constraint
* Provides adequate head to deliver water to 55 m elevation

The system is feasible and operationally robust under the stated parameters.