// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER CHASSIS PROTECTION
// COMPONENT VAULT: BANDAI CAST RUNNER F - ANKLE SHIELDS F20 & F21
// MANUFACTURING SPEC: WIRELESS INDUCTIVE HARNESS PROXIMITY TERMINALS
// DESIGN SPECS: 5,200 Nm RECOIL COMPLIANCE & DLC LOW-FRICTION SLIDERS
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
ankle_cap_length = 950;                 // Total longitudinal vertical span (mm)
ankle_outer_width = 680;                // Transverse armor plate envelope width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_F_Ankle_Cap_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.24, 0.24, 0.26]) {
        cylinder(h = ankle_cap_length * 2.2, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 0, -450]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically
    Cast_Outer_Ankle_Armor();
}

module Cast_Outer_Ankle_Armor() {
    // ---- PART F20: OUTER LEFT ANKLE DEFENSE COWL SHELL ---- [Page 6, Step 2]
    translate([-450, 0, 450]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main tapered external protective ankle shield panel
            scale([1.0, 0.45, 1.0])
                cylinder(h = ankle_cap_length * 0.45, r1 = ankle_outer_width * 0.5, r2 = ankle_outer_width * 0.35, center = true);
            
            // Internal pocket excavation (Leaves the rigid 50mm protective wall)
            scale([1.0, 0.45, 1.0])
                cylinder(h = ankle_cap_length * 0.5, r1 = (ankle_outer_width * 0.5) - armor_skin_thickness, r2 = (ankle_outer_width * 0.35) - armor_skin_thickness, center = true);
                
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, ankle_outer_width * 2, ankle_cap_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -ankle_outer_width, 0])
                cube([ankle_outer_width * 2, ankle_outer_width * 2, ankle_cap_length * 2], center = true);
        }
    }
    
    // ---- PART F21: OUTER RIGHT ANKLE DEFENSE COWL SHELL ---- [Page 6, Step 1]
    translate([450, 0, -450]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            scale([1.0, 0.45, 1.0])
                cylinder(h = ankle_cap_length * 0.45, r1 = ankle_outer_width * 0.5, r2 = ankle_outer_width * 0.35, center = true);
            scale([1.0, 0.45, 1.0])
                cylinder(h = ankle_cap_length * 0.5, r1 = (ankle_outer_width * 0.5) - armor_skin_thickness, r2 = (ankle_outer_width * 0.35) - armor_skin_thickness, center = true);
            cube([harness_conduit_width, ankle_outer_width * 2, ankle_cap_length], center = true);
            translate([0, -ankle_outer_width, 0])
                cube([ankle_outer_width * 2, ankle_outer_width * 2, ankle_cap_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Ankle_Cap_Forge();
