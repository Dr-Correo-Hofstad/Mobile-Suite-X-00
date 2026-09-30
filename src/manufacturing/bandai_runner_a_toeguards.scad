// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - GROUND FOOTPRINT VAULT
// COMPONENT VAULT: BANDAI CAST RUNNER A - DISTAL TOE GUARDS A25 & A26
// ENGINEERING STANDARD: DOTE COMPLIANCE WITH 5,200 Nm HIP TORQUE ARRAYS
// STRUCTURAL MATRIX: BIOCHEM-5000 NON-LINEAR LOAD DISSIPATION ANCHORS
// ============================================================================

$fn = 100; // Circular segment fidelity segment count

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Envelope (mm)
toe_guard_length = 980;                 // Total longitudinal toe block forward axis (mm)
toe_guard_width = 850;                  // Total transverse ground anchor footing width (mm)
armor_skin_thickness = 60;              // Variable TiAl defensive plating wall (mm)
harness_conduit_width = 80;             // Embedded 4oz copper logic rail track (mm)
anchor_tooth_depth = 110;               // Non-linear torque stabilization teeth (mm)

module Runner_A_Toe_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = toe_guard_length * 2.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 0, 600]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
        translate([0, 0, -600]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
    }
    
    // Instantiate Scaled Part Cavities (Replicating Manual Sprues exactly)
    Cast_Distal_Toe_Stabilizers();
}

module Cast_Distal_Toe_Stabilizers() {
    // ---- PART A25: DISTAL LEFT TOE GUARD ARMOR SHELL ---- [Page 8, Step 9]
    translate([450, 0, 600]) color([0.8, 0.8, 0.85]) {
        difference() {
            // Main solid heavy-duty toe claw grounding housing block
            cube([toe_guard_width, toe_guard_length, 400], center = true);
            
            // Internal pocket clearance (Enforces the 60mm solid defensive wall)
            translate([0, 0, -armor_skin_thickness])
                cube([toe_guard_width - (armor_skin_thickness*2), toe_guard_length + 10, 400], center = true);
            
            // Sub-surface non-linear torque dissipation anchoring teeth
            for (offset = [-(toe_guard_width/3) : toe_guard_width/3 : toe_guard_width/3]) {
                translate([offset, (toe_guard_length/2 - anchor_tooth_depth/2), -150])
                    cube([70, anchor_tooth_depth + 10, 200], center = true);
            }
            
            // Cast-in guide slots to align the zero-wire copper harness logic rails
            cube([harness_conduit_width, toe_guard_length + 10, 500], center = true);
        }
    }
    
    // ---- PART A26: DISTAL RIGHT TOE GUARD ARMOR SHELL ---- [Page 8, Step 9]
    translate([-450, 0, -600]) rotate([0, 0, 180]) color([0.8, 0.8, 0.85]) {
        difference() {
            cube([toe_guard_width, toe_guard_length, 400], center = true);
            translate([0, 0, -armor_skin_thickness])
                cube([toe_guard_width - (armor_skin_thickness*2), toe_guard_length + 10, 400], center = true);
            for (offset = [-(toe_guard_width/3) : toe_guard_width/3 : toe_guard_width/3]) {
                translate([offset, (toe_guard_length/2 - anchor_tooth_depth/2), -150])
                    cube([70, anchor_tooth_depth + 10, 200], center = true);
            }
            cube([harness_conduit_width, toe_guard_length + 10, 500], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_A_Toe_Forge();
