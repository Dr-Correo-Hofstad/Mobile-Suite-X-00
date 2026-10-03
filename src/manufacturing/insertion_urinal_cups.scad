// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LIFE SUPPORT EXTRACTION VAULT
// COMPONENT: DIRECT-INSERTION ANATOMICAL SUCTION CUPS (MALE & FEMALE)
// ARCHITECTURE SPEC: AC DELCO ZERO-LEAK CONDUIT FLANGE EXTENSIONS
// CONFIG METRIC: SCALED MEDICAL-GRADE PLIABLE SILICONE CASTS (1:1 ACTUAL METRIC)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Component Constants (mm actual metric scale)
conduit_diameter = 18;                   // Outer transfer tube line width (mm)
inner_lumen_diameter = 12;               // Clear fluid flow tracking lane width (mm)
female_nozzle_extension = 25;            // Length of internal tube extending past flange (mm)
female_outer_rim = 90;                   // Total width of exterior anatomical sealing shield (mm)
male_sleeve_depth = 80;                  // Deep-recess inner sleeve containment length (mm)

module Master_Insertion_Cup_Forge() {
    // ---- MODULE 1: FEMALE INTRA-INTROITUS DIRECT INSERTION OPTION ----
    translate([-120, 0, 0]) color([0.15, 0.55, 0.85, 0.8]) { // Clear Medical Blue Spec
        difference() {
            union() {
                // Wide flanged outer protective shield (Sits flush against outer anatomy)
                cylinder(h = 60, d1 = conduit_diameter, d2 = female_outer_rim, center = false);
                
                // EXTENDED INTRA-CUP SUCTION TUBE (Extends past the outer flange face)
                translate([0, 0, 60])
                    cylinder(h = female_nozzle_extension, d = conduit_diameter, center = false);
            }
            
            // Core continuous fluid lumen excavation cutting straight through the entire part
            cylinder(h = 100, d = inner_lumen_diameter, center = false);
            
            // Recessed step for the inline spring-loaded Viton flapper check valve
            translate([0, 0, 5])
                cylinder(h = 10, d = conduit_diameter - 2, center = true);
        }
    }
    
    // ---- MODULE 2: MALE DEEP-RECESS CONTRAINT CATHETER CUP OPTION ----
    translate([120, 0, 0]) color([0.15, 0.75, 0.55, 0.8]) { // Clear Teal Safety Spec
        difference() {
            // Heavy outer containment hull housing block
            cylinder(h = male_sleeve_depth + 40, d = 75, center = false);
            
            // DEEP INTERNAL INSERTION SLEEVE CHANNEL (Carved down into the core matrix)
            translate([0, 0, 30])
                cylinder(h = male_sleeve_depth + 20, d = 45, center = false);
                
            // Siphon suction drain track connecting the deep sleeve base to the transfer tube
            cylinder(h = 40, d = inner_lumen_diameter, center = false);
            
            // Lower mounting nozzle seat for the outbound Viton check valve housing
            translate([0, 0, 10])
                cylinder(h = 15, d = conduit_diameter - 2, center = true);
        }
    }
}

// Render Master Assembly Workspace Parameters
Master_Insertion_Cup_Forge();
