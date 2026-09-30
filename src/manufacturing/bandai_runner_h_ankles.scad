// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER FRAME INFRASTRUCTURE
// COMPONENT VAULT: BANDAI CAST RUNNER H - ANKLE PIVOT JOINTS H7 & H8
// ENGINEERING PARITY: COMPLIANT RETROFIT FOR 5,200 Nm UPPER HIP TORQUE LOAD
// ELECTRICAL INTERFACE: WIRELESS INDUCTIVE POWER HARNESS CONDUITS
// ============================================================================

$fn = 100; // High-precision circular rendering resolution

// Metric Scaling Parameters (1:1 Dimensions for a 16.7m Mecha Architecture)
joint_housing_height = 740;             // Total longitudinal ankle core height (mm)
cycloidal_track_diameter = 540;         // Inner cycloidal reduction ring bore (mm)
titanium_bone_wall = 60;                // Thick TiAl outer skeletal joint casing (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_H_Ankle_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = joint_housing_height * 2.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 0, 500]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
        translate([0, 0, -500]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically
    Cast_Internal_Ankle_Mechanisms();
}

module Cast_Internal_Hip_Mechanisms() { // Deprecated naming match via workspace override
    Cast_Internal_Ankle_Mechanisms();
}

module Cast_Internal_Ankle_Mechanisms() {
    // ---- PART H7: LEFT LOWER ANKLE SWIVEL HOUSING ---- [Page 7, Step 6]
    translate([-450, 0, 500]) color([0.45, 0.45, 0.48]) {
        difference() {
            // Main rigid universal knuckle housing block
            cylinder(h = joint_housing_height * 0.45, d = cycloidal_track_diameter + (titanium_bone_wall * 2), center = true);
            
            // Core Internal Boring for the Cycloidal Pin Rolling Tracks
            cylinder(h = joint_housing_height * 0.5, d = cycloidal_track_diameter, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, cycloidal_track_diameter + 140, joint_housing_height], center = true);
        }
    }
    
    // ---- PART H8: RIGHT LOWER ANKLE SWIVEL HOUSING ---- [Page 7, Step 6]
    translate([450, 0, -500]) rotate([0, 180, 0]) color([0.45, 0.45, 0.48]) {
        difference() {
            cylinder(h = joint_housing_height * 0.45, d = cycloidal_track_diameter + (titanium_bone_wall * 2), center = true);
            cylinder(h = joint_housing_height * 0.5, d = cycloidal_track_diameter, center = true);
            cube([harness_conduit_width, cycloidal_track_diameter + 140, joint_housing_height], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_H_Ankle_Forge();
