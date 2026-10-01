// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - UPPER AIRFRAME matrix
// COMPONENT VAULT: BANDAI CAST RUNNER B - SHOULDER LINKS B5 & B6
// MANUFACTURING SPECS: SOLID-STATE CAST-IN INDUCTIVE POWER HARNESS TERMINALS
// DESIGN PARITY: 4,500 Nm RECOIL COMPLIANCE FOR 16.7M BI-PEDAL AIRFRAME
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
shoulder_joint_height = 620;            // Total longitudinal joint height (mm)
cycloidal_bore_diameter = 420;          // Inner cycloidal reduction ring bore (mm)
titanium_bone_wall = 55;                // Solid TiAl outer skeletal joint casing (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_B_Shoulder_Link_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = shoulder_joint_height * 2.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 0, -450]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically (Left & Right Halves)
    Cast_Internal_Shoulder_Mechanisms();
}

module Cast_Internal_Shoulder_Mechanisms() {
    // ---- PART B5: INTERNAL LEFT UPPER SHOULDER COUPLING SLEEVE ---- [Page 6, Step 4]
    translate([-450, 0, 450]) color([0.4, 0.4, 0.42]) { // Inner Frame Dark Spec
        difference() {
            // Main high-strength structural swivel casing yoke block
            cylinder(h = shoulder_joint_height * 0.45, d = cycloidal_bore_diameter + (titanium_bone_wall * 2), center = true);
            
            // Core Internal Boring for the Cycloidal Pin Rolling Tracks
            cylinder(h = shoulder_joint_height * 0.5, d = cycloidal_bore_diameter, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, cycloidal_bore_diameter + 120, shoulder_joint_height], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([cycloidal_bore_diameter, 0, 0])
                cube([cycloidal_bore_diameter * 2, cycloidal_bore_diameter * 2, shoulder_joint_height * 2], center = true);
        }
    }
    
    // ---- PART B6: INTERNAL RIGHT UPPER SHOULDER COUPLING SLEEVE ---- [Page 6, Step 3]
    translate([450, 0, -450]) rotate() color([0.4, 0.4, 0.42]) {
        difference() {
            cylinder(h = shoulder_joint_height * 0.45, d = cycloidal_bore_diameter + (titanium_bone_wall * 2), center = true);
            cylinder(h = shoulder_joint_height * 0.5, d = cycloidal_bore_diameter, center = true);
            cube([harness_conduit_width, cycloidal_bore_diameter + 120, shoulder_joint_height], center = true);
            translate([cycloidal_bore_diameter, 0, 0])
                cube([cycloidal_bore_diameter * 2, cycloidal_bore_diameter * 2, shoulder_joint_height * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_B_Shoulder_Link_Forge();
