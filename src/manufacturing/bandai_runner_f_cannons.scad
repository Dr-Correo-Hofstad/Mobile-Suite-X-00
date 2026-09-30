// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - RETRACTABLE DEFENSE SYSTEMS
// COMPONENT VAULT: BANDAI CAST RUNNER F - TORSO MACHINE CANNON ASSEMBLY
// COOLING PARITY: STRESS-INDUCED THERMOACOUSTIC PIEZO-ELASTIC INTEGRATION
// DESIGN METRIC: SOLID-STATE STEPPING SLIDES FOR SQUARE-WAVE RETROFITTING
// ============================================================================

$fn = 100; // Circular segment fidelity

// Sizing Matrices Scaled 1:1 for a 16.7-Meter Airframe Envelope (mm)
cannon_barrel_length = 1200;            // Total longitudinal firing axis (mm)
slide_cover_width = 650;                // Transverse armor plate width (mm)
structural_collar_wall = 45;            // Internal TiAl bone wall thickness (mm)
harness_conduit_width = 80;             // Embedded 4oz copper logic trace track (mm)
pzt_matrix_depth = 12;                  // Energy-harvesting crystal thickness (mm)

module Runner_F_Cannon_Forge() {
    // Master Material Feed Runner (Feeds molten magma from Siphon Forge)
    color([0.24, 0.24, 0.26]) {
        cylinder(h = cannon_barrel_length * 2.0, d = 42, center = true);
        // Direct injection gates feeding straight to part cavities
        translate([0, 0, 700]) rotate([0, 90, 0]) cylinder(h = 450, d = 20);
        translate([0, 0, -700]) rotate([0, 90, 0]) cylinder(h = 450, d = 20);
    }
    
    // Instantiate Scaled Part Cavities (Replicating Manual Sprues exactly)
    Cast_Torso_Cannon_Components();
}

module Cast_Torso_Cannon_Components() {
    // ---- PART F25: LEFT INTERNAL BARREL MOUNT COLLAR ---- [Page 5, Step 02-5]
    translate([-500, 0, 700]) color([0.45, 0.45, 0.48]) {
        difference() {
            // Rigid internal block securing weapon straight to upper vertebrae
            cube([400, 450, 400], center = true);
            // Core weapon tube clearing the high-velocity firing sleeve
            cylinder(h = 460, d = 260, center = true);
            // Sub-surface cutout zone for the PZT crystal harvesting rings
            cylinder(h = 410, d = 260 + (pzt_matrix_depth * 2), center = true);
        }
    }
    
    // ---- PART F26: RIGHT INTERNAL BARREL MOUNT COLLAR ---- [Page 5, Step 02-5]
    translate([500, 0, 700]) rotate([0, 0, 180]) color([0.45, 0.45, 0.48]) {
        difference() {
            cube([400, 450, 400], center = true);
            cylinder(h = 460, d = 260, center = true);
            cylinder(h = 410, d = 260 + (pzt_matrix_depth * 2), center = true);
        }
    }

    // ---- PART F34: AUTOMATED UPPER COLLAR SLIDE COVER ---- [Page 5, Step 02-5]
    translate([0, -600, -700]) color([0.8, 0.8, 0.85]) {
        difference() {
            // Aerodynamic outer skin panel that sits flush with upper collar
            scale([1.0, 0.35, 1.0])
                cylinder(h = cannon_barrel_length * 0.5, r1 = slide_cover_width, r2 = slide_cover_width * 0.8, center = true);
            
            // Core internal thickness milling (Isolates 25mm outer protective shell)
            scale([1.0, 0.35, 1.0])
                cylinder(h = cannon_barrel_length * 0.6, r1 = slide_cover_width - 25, r2 = (slide_cover_width * 0.8) - 25, center = true);
            
            // Cast-in guide channel for the solid-state harness copper bus tracks
            cube([harness_conduit_width, 800, cannon_barrel_length], center = true);
            
            // Clean splitting cut to generate an asymmetrical sliding half-shell
            translate([0, -slide_cover_width, 0])
                cube([slide_cover_width * 2, slide_cover_width * 2, cannon_barrel_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Cannon_Forge();
