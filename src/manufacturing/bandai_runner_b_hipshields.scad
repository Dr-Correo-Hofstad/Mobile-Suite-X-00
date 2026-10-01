// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER airframe DEFENSE MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER B - HIP SHIELDS B26 & B27
// MANUFACTURING SPEC: WIRELESS INDUCTIVE HARNESS PROXIMITY TERMINALS
// DESIGN SPECS: 5,200 Nm HIP TORQUE LOOPS & DLC LOW-FRICTION SLIDERS
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
hip_shield_length = 950;                // Total longitudinal vertical height (mm)
hip_outer_diameter = 680;               // Transverse shell casing envelope width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_B_Hip_Shield_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = hip_shield_length * 2.2, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 0, -450]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically
    Cast_Outer_Hip_Armor_Shells();
}

module Cast_Outer_Hip_Armor_Shells() {
    // ---- PART B26: LEFT THIGH EXTERIOR ADAPTER SHIELD ---- [Page 6, Step 2 / Page 6, Step 05-2]
    translate([-450, 0, 450]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main cylindrical contoured hip protective panel casing
            cylinder(h = hip_shield_length * 0.45, d1 = hip_outer_diameter + 60, d2 = hip_outer_diameter, center = true);
            
            // Internal pocket excavation (Leaves the rigid 50mm protective boundary)
            cylinder(h = hip_shield_length * 0.5, d1 = hip_outer_diameter + 60 - (armor_skin_thickness*2), d2 = hip_outer_diameter - (armor_skin_thickness*2), center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, hip_outer_diameter + 80, hip_shield_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -hip_outer_diameter, 0])
                cube([hip_outer_diameter * 2, hip_outer_diameter * 2, hip_shield_length * 2], center = true);
        }
    }
    
    // ---- PART B27: RIGHT THIGH EXTERIOR ADAPTER SHIELD ---- [Page 6, Step 1 / Page 6, Step 05-2]
    translate([450, 0, -450]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            cylinder(h = hip_shield_length * 0.45, d1 = hip_outer_diameter + 60, d2 = hip_outer_diameter, center = true);
            cylinder(h = hip_shield_length * 0.5, d1 = hip_outer_diameter + 60 - (armor_skin_thickness*2), d2 = hip_outer_diameter - (armor_skin_thickness*2), center = true);
            cube([harness_conduit_width, hip_outer_diameter + 80, hip_shield_length], center = true);
            translate([0, -hip_outer_diameter, 0])
                cube([hip_outer_diameter * 2, hip_outer_diameter * 2, hip_shield_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_B_Hip_Shield_Forge();
