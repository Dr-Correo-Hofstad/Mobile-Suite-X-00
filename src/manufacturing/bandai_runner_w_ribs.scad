// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - FLIGHT SURFACE INFRA
// COMPONENT VAULT: BANDAI CAST RUNNER W - SUB-FRAME RIBS W1 & W2
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
rib_total_length = 1580;                 // Total longitudinal cantilever length (mm)
rib_base_depth = 480;                   // Maximum depth of base frame anchor (mm)
armor_skin_thickness = 60;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_W_Wing_Rib_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = rib_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, -300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Internal_Subframe_Ribs();
}

module Cast_Internal_Subframe_Ribs() {
    // ---- PART W1: INTERNAL LEFT MAIN WING UPPER SUB-FRAME RIB ----
    translate([-450, 0, 450]) color([0.35, 0.35, 0.38]) { // Inner Frame Dark Spec
        difference() {
            // Main solid heavy-duty cantilever rib plate segment
            cube([rib_base_depth, 280, rib_total_length * 0.45], center = true);
            
            // Core structural cutout for trailing edge plumage track alignment
            cube([rib_base_depth - (armor_skin_thickness * 2), 300, rib_total_length * 0.35], center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the frame walls]
            for (z_offset = [-200, 0, 200]) {
                translate([(rib_base_depth * 0.25 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 300, rib_total_length], center = true);
        }
    }
    
    // ---- PART W2: INTERNAL RIGHT MAIN WING UPPER SUB-FRAME RIB ----
    translate([450, 0, -450]) rotate() color([0.35, 0.35, 0.38]) {
        difference() {
            cube([rib_base_depth, 280, rib_total_length * 0.45], center = true);
            cube([rib_base_depth - (armor_skin_thickness * 2), 300, rib_total_length * 0.35], center = true);
            
            for (z_offset = [-200, 0, 200]) {
                translate([(rib_base_depth * 0.25 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            cube([harness_conduit_width, 300, rib_total_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_W_Wing_Rib_Forge();
