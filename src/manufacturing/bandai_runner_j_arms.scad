// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - UPPER LIMB COUPLING MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER J - HIGH-GRADE COMPLIANT RETROFIT
// INTEGRATION BOUND: FOREARM LOCKING COUPLERS & DUAL-MOTION SERVO INTERFACES
// DESIGN METRIC: FULL SQUARE-WAVE FORCE ISOLATION FOR TWIN RIFLE MOUNTS
// ============================================================================

$fn = 100; // Circular segment fidelity

// Arm Mechanical Constraints & Geometric Variables
arm_structural_thickness = 45;         // Solid internal TiAl skeletal core wall (mm)
forearm_track_length = 1850;            // Total longitudinal lower arm axis (mm)
rifle_coupling_width = 160;             // Heavy weapon male-to-female joint gap (mm)
servo_bore_diameter = 280;              // Internal electromagnetic actuator width (mm)

module Runner_J_Arm_Casts() {
    // Master Sprue Supply Bar (Feeds Molten Alloy from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = forearm_track_length + 400, d = 40, center = true);
        // Feeding Gates linking directly to the mold cavities
        translate([0, 0, 400]) rotate([0, 90, 0]) cylinder(h = 450, d = 20);
        translate([0, 0, -400]) rotate([0, 90, 0]) cylinder(h = 450, d = 20);
    }
    
    // Instantiate Scaled Part Cavities
    Cast_Arm_Internal_Sections();
}

module Cast_Arm_Internal_Sections() {
    // ---- PART J10: DUAL-MOTION ELBOW SERVO ENCLOSURE ---- [From Page 6, Step 3 & 4]
    translate([450, 0, 400]) color([0.45, 0.45, 0.48]) {
        difference() {
            // High-durability cylindrical shoulder-to-elbow rotational collar
            cylinder(h = 420, d = servo_bore_diameter + (arm_structural_thickness * 2), center = true);
            // Core boolean subtraction cavity for the dual-motion EMA coils
            cylinder(h = 430, d = servo_bore_diameter, center = true);
            // Lateral hinge path for the 120-degree pivot bracket pins
            rotate([90, 0, 0]) cylinder(h = 600, d = 90, center = true);
        }
    }
    
    // ---- PART J14: FOREARM RIFLE LOCKING COUPLER ---- [From Page 13]
    translate([450, 0, -400]) color([0.5, 0.5, 0.55]) {
        difference() {
            // Solid internal forearm skeletal block
            cube([360, 360, forearm_track_length * 0.4], center = true);
            // Sliding channel slot to reveal the Twin Buster Rifle mounting key
            translate([0, 0, 10])
                cube([rifle_coupling_width, 400, forearm_track_length * 0.25], center = true);
            // Cast-in conduit path for the 4oz copper power delivery harness
            cube([70, 70, forearm_track_length], center = true);
        }
    }
}

// Render Runner J Assembly to Parametric Workspace
Runner_J_Arm_Casts();
