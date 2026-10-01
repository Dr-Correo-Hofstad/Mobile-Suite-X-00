// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER airframe INTEGRATION
// COMPONENT VAULT: BANDAI CAST RUNNER H - ANKLE SWIVELS H14 & H15
// MANUFACTURING SPECS: SOLID-STATE CAST-IN INDUCTIVE POWER HARNESS TERMINALS
// DESIGN PARITY: 5,200 Nm TORQUE LOAD COMPLIANCE FOR 16.7M BI-PEDAL AIRFRAME
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
swivel_ring_height = 420;               // Total vertical thickness of swivel block (mm)
cycloidal_bore_diameter = 540;          // Inner cycloidal reduction ring bore (mm)
titanium_armor_wall = 60;               // Solid TiAl protective wall thickness (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_H_Ankle_Swivel_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = swivel_ring_height * 2.8, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 400, d = 22);
        translate([0, 0, -400]) rotate() cylinder(h = 400, d = 22);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically (Left & Right Halves)
    Cast_Ankle_Swivel_Framework();
}

module Cast_Ankle_Swivel_Framework() {
    // ---- PART H14: LOWER LEFT ANKLE ROTATIONAL COUPLING COLLAR ---- [Page 6, Step 2]
    translate([-450, 0, 400]) color([0.45, 0.45, 0.48]) { // Inner Frame Dark Spec
        difference() {
            // Main high-strength structural swivel casing block
            cylinder(h = swivel_ring_height, d = cycloidal_bore_diameter + (titanium_armor_wall * 2), center = true);
            
            // Central Cycloidal Reduction Track Bore (Houses pre-loaded rolling pins)
            cylinder(h = swivel_ring_height + 20, d = cycloidal_bore_diameter, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, cycloidal_bore_diameter + 150, swivel_ring_height + 10], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([cycloidal_bore_diameter, 0, 0])
                cube([cycloidal_bore_diameter * 2, cycloidal_bore_diameter * 2, swivel_ring_height * 2], center = true);
        }
    }
    
    // ---- PART H15: LOWER RIGHT ANKLE ROTATIONAL COUPLING COLLAR ---- [Page 6, Step 1]
    translate([450, 0, -400]) rotate() color([0.45, 0.45, 0.48]) {
        difference() {
            cylinder(h = swivel_ring_height, d = cycloidal_bore_diameter + (titanium_armor_wall * 2), center = true);
            cylinder(h = swivel_ring_height + 20, d = cycloidal_bore_diameter, center = true);
            cube([harness_conduit_width, cycloidal_bore_diameter + 150, swivel_ring_height + 10], center = true);
            translate([cycloidal_bore_diameter, 0, 0])
                cube([cycloidal_bore_diameter * 2, cycloidal_bore_diameter * 2, swivel_ring_height * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_H_Ankle_Swivel_Forge();
