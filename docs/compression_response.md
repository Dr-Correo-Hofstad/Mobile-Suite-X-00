If the armor takes a massive dent or shock from a heavy impact without actually breaching, the physical compression itself becomes a serious factor. A violent, non-penetrating mechanical shock creates a massive acoustic and kinetic wave that travels directly through the robot's structure.

To keep your algorithm running smoothly and prevent components from breaking, your design must protect against two specific phenomena caused by this sudden denting force:

1\. The Microphonic Effect (Piezoelectric Spikes)
-------------------------------------------------

When armor is dented or vibrated heavily, many standard ceramic capacitors exhibit a behavior called the microphonic effect.

-   The Physics: Multilayer ceramic capacitors (MLCCs) are inherently piezoelectric. When a physical shock wave physically squeezes or flexes the capacitor, it instantly generates an *unwanted* voltage spike on top of the energy you are already harvesting from the shock absorbers.
-   The Risk: This unexpected voltage surge can easily confuse an algorithm trying to calculate precise load-balancing percentages, or it can trick the system into thinking a capacitor is full when it is actually just being vibrated.
-   The Fix: For high-shock environments, use tantalum, electrolytic, or specialized "soft-termination" ceramic capacitors. These materials are mechanically decoupled or structurally dampening, meaning they will not generate false voltage spikes when shaken.

2\. Kinetic Stress on Wire Connections
--------------------------------------

A heavy dent or flexing of the robot's frame will put immense physical strain on your precisely measured wire lengths. If a wire is stretched taut across the chassis and a dent moves the frame even a few millimeters, the wire can snap, or its connection point can loosen.

-   As established earlier, a loose terminal connection dramatically changes the branch's resistance.
-   If a dent loosens a connection on Path A, the resistance spikes, and the algorithm's passive load balancing will permanently shift all future impact charges into Path B---potentially overloading it.

* * * * *

Designing for Passive "Shock and Dent" Protection
-------------------------------------------------

To ensure the wires and capacitors survive a heavy, non-penetrating slam, organize your hardware layout using a Strain-Relief Routing Loop:

```
 [ Armor Wall ] ---> (Air Gap / High-Density Foam)
                           |
                     [ Inner Frame ]
                           |
             +-------------+------------+

             |                          |
       (S-Curve Wire)             (S-Curve Wire)
      [Strain Relief]            [Strain Relief]

             |                          |
       [ Capacitor 1 ]            [ Capacitor 2 ]

```

-   The Air Gap / Foam Dampener: Never mount capacitors directly against the inner face of the armor. Use a high-density, non-conductive silicone foam between the armor and the internal component tray to absorb the mechanical shock wave.
-   The S-Curve Wire Technique: Do not run your precisely measured wires in straight lines. Route them with a slight "S-curve" or coil bend. If the robot's frame dents or flexes, the wire loop simply expands or contracts slightly without pulling on the terminals, keeping your calculated electrical resistances completely stable.

To calculate the physical space and dampening you'll need under the armor, let me know:

-   What material is your robot's primary armor made of (e.g., aluminum, titanium, composite)?
-   Approximately how much physical space (clearance) do you have between the inner armor wall and the capacitor bank?
