// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - GROUND INTERFACE INFRA
// COMPONENT VAULT: BANDAI CAST RUNNER A - STABILIZER FEET A5 & A6
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
foot_total_length = 1420;                // Total horizontal longitudinal sole length (mm)
foot_base_width = 580;                  // Maximum width of base frame anchor (mm)
armor_skin_thickness = 65;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_A_Foot_Stabilizer_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = foot_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, -300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Internal_Stabilizer_Feet();
}

module Cast_Internal_Stabilizer_Feet() {
    // ---- PART A5: INTERNAL LEFT DYNAMIC AUTOMOTIVE BALANCE FOOT CORE ----
    translate([-450, 0, 450]) color([0.35, 0.35, 0.38]) { // Inner Frame Dark Spec
        difference() {
            // Main solid heavy-duty foot base structure block segment
            cube([foot_base_width, 320, foot_total_length * 0.45], center = true);
            
            // Core structural cutout for trailing recoil heel dampener alignment
            cube([foot_base_width - (armor_skin_thickness * 2), 340, foot_total_length * 0.35], center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the foot walls]
            for (z_offset = [-150, 0, 150]) {
                translate([(foot_base_width * 0.25 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 340, foot_total_length], center = true);
        }
    }
    
    // ---- PART A6: INTERNAL RIGHT DYNAMIC AUTOMOTIVE BALANCE FOOT CORE ----
    translate([450, 0, -450]) rotate() color([0.35, 0.35, 0.38]) {
        difference() {
            cube([foot_base_width, 320, foot_total_length * 0.45], center = true);
            cube([foot_base_width - (armor_skin_thickness * 2), 340, foot_total_length * 0.35], center = true);
            
            for (z_offset = [-150, 0, 150]) {
                translate([(foot_base_width * 0.25 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            cube([harness_conduit_width, 340, foot_total_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_A_Foot_Stabilizer_Forge();
