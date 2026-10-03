// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - WEAPON COMBINATION INFRA
// COMPONENT VAULT: BANDAI CAST RUNNER D - BARREL CLAMPS D5 & D6
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
clamp_total_length = 640;                // Total longitudinal vertical height (mm)
clamp_outer_diameter = 480;              // Transverse weapon spine bounding width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_D_Barrel_Clamp_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = clamp_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Internal_Barrel_Clamps();
}

module Cast_Internal_Barrel_Clamps() {
    // ---- PART D5: INTERNAL LEFT BARREL CROSS-AXIS ALIGNMENT CLAMP ---- [Page 23, Step 14-2]
    translate([-450, 0, 450]) color([0.5, 0.5, 0.55]) { // Weapon Metallic Casing Spec
        difference() {
            // Main solid heavy-duty interlocking block segment
            cube([clamp_outer_diameter * 0.45, 340, clamp_total_length * 0.45], center = true);
            
            // Core structural alignment cutout (Fits securely over the main weapon rail)
            cube([clamp_outer_diameter * 0.35, 360, clamp_total_length * 0.35], center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the anchor wall]
            for (z_offset = [-150, 0, 150]) {
                translate([(clamp_outer_diameter * 0.15 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 360, clamp_total_length], center = true);
        }
    }
    
    // ---- PART D6: INTERNAL RIGHT BARREL CROSS-AXIS ALIGNMENT CLAMP ---- [Page 23, Step 14-2]
    translate([450, 0, -450]) rotate() color([0.5, 0.5, 0.55]) {
        difference() {
            cube([clamp_outer_diameter * 0.45, 340, clamp_total_length * 0.45], center = true);
            cube([clamp_outer_diameter * 0.35, 360, clamp_total_length * 0.35], center = true);
            
            for (z_offset = [-150, 0, 150]) {
                translate([(clamp_outer_diameter * 0.15 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            cube([harness_conduit_width, 360, clamp_total_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_D_Barrel_Clamp_Forge();
