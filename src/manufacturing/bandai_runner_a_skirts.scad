// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER airframe DEFENSE MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER A - WAIST SKIRT SHELLS A9 & A10
// MANUFACTURING SPEC: WIRELESS INDUCTIVE HARNESS PROXIMITY TERMINALS
// DESIGN PARITY: 5,200 Nm HIP TORQUE ARRAYS & DLC LOW-FRICTION SLIDERS
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
skirt_panel_length = 1350;              // Total longitudinal vertical span (mm)
skirt_outer_width = 620;                // Transverse armor plate envelope width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_A_Skirt_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = skirt_panel_length * 2.2, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 0, -500]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically
    Cast_Outer_Skirt_Armor();
}

module Cast_Outer_Skirt_Armor() {
    // ---- PART A9: LEFT SIDE WAIST SKIRT ARMOR SHELL ---- [Page 7, Step 6 / Page 18, Step 09-6]
    translate([-450, 0, 500]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main tapered external protective side skirt shield panel
            scale([1.0, 0.4, 1.0])
                cylinder(h = skirt_panel_length * 0.45, r1 = skirt_outer_width, r2 = skirt_outer_width * 0.7, center = true);
            
            // Internal pocket excavation (Leaves the rigid 50mm protective wall)
            scale([1.0, 0.4, 1.0])
                cylinder(h = skirt_panel_length * 0.5, r1 = skirt_outer_width - armor_skin_thickness, r2 = (skirt_outer_width * 0.7) - armor_skin_thickness, center = true);
                
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, skirt_outer_width * 2, skirt_panel_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -skirt_outer_width, 0])
                cube([skirt_outer_width * 2, skirt_outer_width * 2, skirt_panel_length * 2], center = true);
        }
    }
    
    // ---- PART A10: RIGHT SIDE WAIST SKIRT ARMOR SHELL ---- [Page 7, Step 6 / Page 18, Step 09-6]
    translate([450, 0, -500]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            scale([1.0, 0.4, 1.0])
                cylinder(h = skirt_panel_length * 0.45, r1 = skirt_outer_width, r2 = skirt_outer_width * 0.7, center = true);
            scale([1.0, 0.4, 1.0])
                cylinder(h = skirt_panel_length * 0.5, r1 = skirt_outer_width - armor_skin_thickness, r2 = (skirt_outer_width * 0.7) - armor_skin_thickness, center = true);
            cube([harness_conduit_width, skirt_outer_width * 2, skirt_panel_length], center = true);
            translate([0, -skirt_outer_width, 0])
                cube([skirt_outer_width * 2, skirt_outer_width * 2, skirt_panel_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_A_Skirt_Forge();
