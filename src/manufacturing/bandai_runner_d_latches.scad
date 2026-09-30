// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - TACTICAL ENGAGEMENT MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER D - WEAPON COUPLING LATCHES D8 & D9
// CIRCUIT RULES: FULL SQUARE-WAVE RETROFITTING & ALIGNMENT RAILS
// REBOUNCING PARITY: HIGH-STRESS CYCLOIDAL KNEE RECOIL ISOLATION
// ============================================================================

$fn = 100; // Circular segment fidelity resolution count

// Structural Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Envelope (mm)
latch_block_length = 680;               // Total longitudinal coupling block width (mm)
clamp_interface_depth = 120;            // Electromagnetic mating surface depth (mm)
titanium_core_wall = 45;                // Structural reinforcement thickness (mm)
bus_alignment_width = 80;               // 4oz Copper power track link gap (mm)

module Runner_D_Latch_Forge() {
    // Central Supply Injection Runner Bar (Molten Feed from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = latch_block_length * 2.2, d = 40, center = true);
        // Direct injection gates feeding straight into the part mold cavities
        translate([0, 0, 400]) rotate([0, 90, 0]) cylinder(h = 450, d = 20);
        translate([0, 0, -400]) rotate([0, 90, 0]) cylinder(h = 450, d = 20);
    }
    
    // Instantiate Scaled Part Molds Symmetrically
    Cast_Interlocking_Weapon_Latches();
}

module Cast_Interlocking_Weapon_Latches() {
    // ---- PART D8: MALE COMBINED LOCKING LATCH COMPONENT ---- [Page 27, Step 20-1]
    translate([450, 0, 400]) color([0.5, 0.5, 0.52]) {
        difference() {
            // High-durability titanium alignment block
            cube([280, 320, latch_block_length * 0.5], center = true);
            
            // Central male alignment peg cutout track
            translate([0, (320/2 - clamp_interface_depth/2), 0])
                cube([140, clamp_interface_depth + 10, latch_block_length * 0.25], center = true);
                
            // Cast-in guide slots to align the high-voltage telemetric power rails
            cube([bus_alignment_width, 400, latch_block_length], center = true);
        }
    }
    
    // ---- PART D9: FEMALE COMBINED LOCKING LATCH COMPONENT ---- [Page 27, Step 20-1]
    translate([450, 0, -400]) color([0.5, 0.5, 0.52]) {
        difference() {
            // High-durability titanium receptacle mating block
            cube([280, 320, latch_block_length * 0.5], center = true);
            
            // Matching female interlocking pocket cutout slot
            translate([0, (320/2 - clamp_interface_depth/2), 0])
                cube([145, clamp_interface_depth + 5, latch_block_length * 0.26], center = true);
                
            cube([bus_alignment_width, 400, latch_block_length], center = true);
        }
    }
}

// Render Master Module Array for Parametric Engineering Compilation
Runner_D_Latch_Forge();
