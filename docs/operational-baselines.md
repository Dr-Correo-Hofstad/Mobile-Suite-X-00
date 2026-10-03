To supply the wiring engineering team with the precise physical constraints for the **zero-resistor, geometry-based current-dividing matrix** (`capacitor_resistance_math.md`), we establish the operational baselines for the **16.7-meter airframe**.

By applying a pure physics model where **electrical conductance (\(G = 1/R\)) is directly proportional to maximum energy capacity (\(E_{\max }\))**, current will divide automatically down each path based entirely on track dimensions without relying on static hardware resistors.

* * * * *

1. Sub-Armor Capacitor Electrical Specifications

To handle the immense electrical surge profiles generated during heavy **22-G vertical booster rocket launches** or full-destruct weapon discharges, the localized sub-armor capacitor arrays utilize ultra-dense, soft-termination ceramic banks:

-   **Capacitor Operating Base Voltage (\(V\)):** **800 Volts DC** (Matched directly to the upscaled GM automotive propulsion motor backplanes).
-   **Total Limb Array Capacitance (\(C\)):** **0.25 Farads** per primary joint station.
-   **Maximum Energy Capacity (\(E_{n}\)):**\
    \(E_{n}=\frac{1}{2}CV^{2}=\frac{1}{2}(0.25\,\text{F})\times (800\,\text{V})^{2}=80,000\,\text{Joules\ (80\ kJ)}\)
-   **The Electromagnetic Deflector Shield Core Capacity (\(E_{\text{shield}}\)):** To handle high-voltage traumatic ballistic overrides, the outer deflector ring coils function as an infinite-power sink backed by the **Siemens MV framework**, absorbing up to **1,200,000 Joules (1.2 MJ)** of instantaneous overflow energy.

* * * * *

2. Structural Node Routing Distance Metrics

Based on the 1:1 metric manufacturing profiles compiled in your OpenSCAD repository, the exact physical layout lengths (\(L_{n}\)) tracking from the primary joint shock generators to their respective defense loads measure as follows:

1.  **Branch 1: Knee Piston to Upper Thigh Capacitor Recess (\(L_{\text{knee}}\))**
    -   *Physical Distance:* **1.45 meters (1450 mm)** tracking up the internal thigh bone ribs (`Parts F5/F6`).
2.  **Branch 2: Ankle Actuator to Foot Ground Stabilizer Anchors (\(L_{\text{ankle}}\))**
    -   *Physical Distance:* **0.95 meters (950 mm)** tracking inside the heel cowls (`Parts H14/H15`).
3.  **Branch 3: Shoulder Swivel Linkage to Retractable Chest Cannons (\(L_{\text{shoulder}}\))**
    -   *Physical Distance:* **1.85 meters (1850 mm)** tracking through the parallel cross-axis stabilizers (`Parts F18/F19`).
