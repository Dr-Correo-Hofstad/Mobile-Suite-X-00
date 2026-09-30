// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER AIRFRAME INTEGRATION
// COMPONENT VAULT: BANDAI CAST RUNNER F - LOWER KNEE FRAME BONES F1, F2 & F10
// RETROFIT MECHANISM: TELEMETRIC MAGLEV RECOIL SHIELD & DAMPING BALANCERS
// REBALANCING VARIABLE: HIGH-AMPERAGE CAPACITOR CURRENT STORAGE HOUSINGS
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
knee_joint_diameter = 640;              // Total width of internal bone cap (mm)
magnetic_gap_width = 45;                // Active electromagnetic cushion path (mm)
bone_wall_thickness = 55;               // Thick TiAl interior structural wall (mm)
harness_conduit_width = 80;             // Embedded 4oz copper logic trace track (mm)
linkage_track_length = 920;             // F10 Low-friction slider stroke (mm)

module Runner_F_Knee_Forge() {
    // Central Supply Injection Runner Axis (Siphon Forge Magma Line)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = linkage_track_length * 2.5, d = 42, center = center);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 500, d = 22);
        translate([0, 0, -800]) rotate() cylinder(h = 500, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically
    Cast_Magnet_Knee_Cores();
}

module Cast_Magnet_Knee_Cores() {
    // ---- PART F1: INTERNAL LEFT KNEE STRUCTURAL BONE CAP ---- [Page 6, Step 2]
    translate([-450, 0, 600]) color([0.45, 0.45, 0.48]) {
        difference() {
            // High-durability titanium joint knuckle housing
            cylinder(h = 480, d = knee_joint_diameter, center = true);
            
            // Concentric Internal Pocket for the Maglev Repulsion Coils
            cylinder(h = 490, d = knee_joint_diameter - (bone_wall_thickness * 2), center = true);
            
            // Cast-in guide channel for the solid-state harness copper bus tracks
            cube([harness_conduit_width, knee_joint_diameter + 10, 500], center = true);
        }
    }
    
    // ---- PART F2: INTERNAL RIGHT KNEE STRUCTURAL BONE CAP ---- [Page 6, Step 1]
    translate([450, 0, 600]) rotate() color([0.45, 0.45, 0.48]) {
        difference() {
            cylinder(h = 480, d = knee_joint_diameter, center = true);
            cylinder(h = 490, d = knee_joint_diameter - (bone_wall_thickness * 2), center = true);
            cube([harness_conduit_width, knee_joint_diameter + 10, 500], center = true);
        }
    }

    // ---- PART F10: LOW-FRICTION SLIDING ARMOR LINKAGE ---- [Page 6, Step 1 & 2]
    // Utilizes a Diamond-Like Carbon (DLC) layer to eliminate physical mechanical friction
    translate([0, -450, -800]) color([0.3, 0.3, 0.32]) {
        difference() {
            // Flat sliding armor guide block segment
            cube([220, 380, linkage_track_length], center = true);
            
            // Internal sliding pin track slot (Maintains armor panel sync limits)
            cube([80, 260, linkage_track_length - 120], center = true);
            
            // Sub-surface conduit cutout routing the telemetric logic tracks
            cube([harness_conduit_width, 400, linkage_track_length + 10], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Knee_Forge();
