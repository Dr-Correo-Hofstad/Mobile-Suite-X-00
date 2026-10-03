// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - MANIPULATOR ARTICULATION CORE
// COMPONENT VAULT: BANDAI CAST RUNNER J - FINGER KNUCKLES J1 THROUGH J4
// MANUFACTURING SPECS: SOLID-STATE CAST-IN INDUCTIVE POWER HARNESS TERMINALS
// DESIGN PARITY: THREE-PHALANX PARALLEL BONES & MICRO-CYCLOIDAL BORES
// ============================================================================

$fn = 80; // High-precision circular rendering resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
knuckle_axis_length = 320;              // Total vertical thickness of knuckle (mm)
cycloidal_bore_diameter = 65;           // Inner cycloidal reduction ring bore (mm)
bone_wall_thickness = 40;               // Solid TiAl structural core thickness (mm)
harness_conduit_width = 40;             // Cast-in 4oz copper logic trace track (mm)
inductive_recess_diameter = 110;         // Mounting slot for wireless palm pads (mm)

module Runner_J_Knuckle_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = knuckle_axis_length * 2.8, d = 35, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 350, d = 18);
        translate([0, 0, -350]) rotate() cylinder(h = 350, d = 18);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically (Left & Right Halves)
    Cast_Internal_Knuckle_Bones();
}

module Cast_Internal_Knuckle_Bones() {
    // ---- PARTS J1 & J2: PROXIMAL PHALANX KNUCKLE JOINTS ---- [Page 6, Step 3 & 4]
    color([0.4, 0.4, 0.42]) { // Inner Frame Gunmetal Spec
        // Left Proximal Knuckle Bone (J1)
        translate([-300, 0, 400])
            difference() {
                // Main solid bone knuckle mounting block segment
                cylinder(h = knuckle_axis_length, d = cycloidal_bore_diameter + (bone_wall_thickness * 2), center = true);
                
                // Central Cycloidal Reduction Track Bore (Houses pre-loaded rolling pins)
                cylinder(h = knuckle_axis_length + 20, d = cycloidal_bore_diameter, center = true);
                
                // Recess Pocket for the Inductive Palm Power Interface Contact Pad
                translate([0, (cycloidal_bore_diameter/2 + 10), 0])
                    rotate([0, 90, 0])
                        cylinder(h = 40, d = inductive_recess_diameter, center = true);
                        
                // Continuous cast-in routing track for the 4oz solid-state wiring rails
                cube([harness_conduit_width, cycloidal_bore_diameter + 100, knuckle_axis_length + 10], center = true);
            }
            
        // Right Proximal Knuckle Bone (J2)
        translate([300, 0, 400]) rotate()
            difference() {
                cylinder(h = knuckle_axis_length, d = cycloidal_bore_diameter + (bone_wall_thickness * 2), center = true);
                cylinder(h = knuckle_axis_length + 20, d = cycloidal_bore_diameter, center = true);
                translate([0, (cycloidal_bore_diameter/2 + 10), 0])
                    rotate([0, 90, 0])
                        cylinder(h = 40, d = inductive_recess_diameter, center = true);
                cube([harness_conduit_width, cycloidal_bore_diameter + 100, knuckle_axis_length + 10], center = true);
            }
    }
    
    // ---- PARTS J3 & J4: MIDDLE PHALANX ACTUATOR ARMS ---- [Page 6, Step 3 & 4]
    color([0.45, 0.45, 0.48]) {
        // Left Middle Actuator Arm (J3)
        translate([-300, 0, -400])
            difference() {
                cube([90, 140, knuckle_axis_length * 1.2], center = true);
                rotate() cylinder(h = 160, d = 45, center = true);
                cube([harness_conduit_width, 160, knuckle_axis_length * 1.5], center = true);
            }
            
        // Right Middle Actuator Arm (J4)
        translate([300, 0, -400]) rotate()
            difference() {
                cube([90, 140, knuckle_axis_length * 1.2], center = true);
                rotate() cylinder(h = 160, d = 45, center = true);
                cube([harness_conduit_width, 160, knuckle_axis_length * 1.5], center = true);
            }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_J_Knuckle_Forge();
