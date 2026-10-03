To route a massive, high-amperage impact pulse into a field generator (like a heavy electromagnetic coil or inductive actuator) while protecting your primary capacitors, you can use asymmetric wire impedance as a passive frequency filter.

Because an impact is an incredibly fast, high-frequency spike of energy, you can design your wiring paths so that the electricity naturally diverts away from the capacitors and forces itself into the field generator if the pulse is too violent.

The Physics: Resistance vs. Inductance
--------------------------------------

To make the electricity "go somewhere else" without switches, your algorithm cannot just look at standard DC resistance (R). It must look at AC Impedance (Z), which is a wire's total opposition to a fast-moving pulse of energy.

1.  The Field Generator Path: An electromagnetic field generator is inherently a massive inductor. Inductors naturally hate fast changes in current. When the robot first lands, the field generator will momentarily look like a solid wall (extremely high impedance), refusing to take the instant spike.
2.  The Capacitor Path: The capacitors have very low initial impedance, so they will drink the initial microsecond shock of the landing.
3.  The "Squeeze" Effect: By using a very thin, higher-gauge wire for the capacitor path, you create a bottleneck. As the capacitor quickly fills, the small wire drops a massive amount of voltage across itself due to its resistance.
4.  The Overflow: Because the small wire chokes the path to the capacitor, the rising voltage on the main line forces the current to overcome the field generator's inductive resistance, pouring the remaining massive bulk of the impact energy into the field.

* * * * *

The Passive Routing Matrix
--------------------------

```
                      [ Shock Absorber / Impact Generator ]
                                        |
                 +----------------------+----------------------+

                 |                                             |
     [ THIN, HIGH-GAUGE WIRE ]                     [ THICK, LOW-GAUGE WIRE ]
       (High Static Resistance)                       (Low Static Resistance)

                 |                                             |
          [ CAPACITORS ]                             [ FIELD GENERATOR ]
    (Drinks initial microsecond spike,             (Absorbs the heavy bulk of the
     then chokes on the thin wire)                  load and projects it as a field)

```

* * * * *

Building the Balancing Algorithm (Impedance Matching)
-----------------------------------------------------

To calculate the exact wire lengths and gauges so the system balances itself perfectly without blowing the capacitors, your algorithm needs to calculate the Time Constant (τ) of the capacitor circuit versus the pulse duration of the impact.

Step 1: Calculate the Capacitor Path Bottleneck
-----------------------------------------------

You want the thin wire's resistance ($R_{\text{wire}}$) to restrict current so that the capacitor cannot exceed its maximum energy threshold ($E_{\max}$) during the impact time (t).\
$$R_{\text{wire}} = \frac{t}{C \cdot \ln\left(\frac{V_{\text{impact}}}{V_{\text{impact}} - V_{\max}}\right)}$$

Where:

-   C = Total Capacitance (Farads)
-   $V_{\max}$ = Maximum safe voltage of your capacitors
-   $V_{\text{impact}}$ = Peak voltage coming out of the shock absorber during a hard landing

Step 2: Determine the Wire Gauge and Length
-------------------------------------------

Once the algorithm knows the required target resistance ($R_{\text{wire}}$) from Step 1, it calculates the gauge and length using standard resistivity:\
$$\text{Length} = \frac{R_{\text{wire}} \cdot \text{Cross-Sectional Area}}{\text{Material Resistivity}}$$

Step 3: Verify the Field Generator Path
---------------------------------------

Because the thick wire leading to the field generator has virtually zero resistance, once the thin wire chokes off the capacitor path, 100% of the remaining impact energy is successfully forced into the field generator.

* * * * *
