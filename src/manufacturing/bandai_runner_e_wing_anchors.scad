// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - FLIGHT SURFACE INFRA
// COMPONENT VAULT: BANDAI CAST RUNNER E - WING ANCHORS E1 & E2
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
anchor_total_length = 1120;              // Total longitudinal vertical height (mm)
pivot_bore_diameter = 520;               // Core cycloidal stabilizer pin width (mm)
armor_skin_thickness = 65;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_E_Wing_Anchor_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = anchor_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Internal_Wing_Anchors();
}

module Cast_Internal_Wing_Anchors() {
    // ---- PART E1: INTERNAL LEFT STRUCTURAL UPPER WING BONE ANCHOR ---- [Page 19, Step 11-1]
    translate([-450, 0, 450]) color([0.35, 0.35, 0.38]) { // Inner Frame Dark Spec
        difference() {
            // Main solid heavy-duty core hinge block segment
            cylinder(h = anchor_total_length * 0.45, d = pivot_bore_diameter + (armor_skin_thickness * 2), center = true);
            
            // Central Cycloidal Pivot Track Bore (Houses pre-loaded alignment pins)
            cylinder(h = anchor_total_length * 0.5, d = pivot_bore_diameter, center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-150, 0, 150]) {
                translate([0, (pivot_bore_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, pivot_bore_diameter + 100, anchor_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -pivot_bore_diameter, 0])
                cube([pivot_bore_diameter * 2, pivot_bore_diameter * 2, anchor_total_length * 2], center = true);
        }
    }
    
    // ---- PART E2: INTERNAL RIGHT STRUCTURAL UPPER WING BONE ANCHOR ---- [Page 19, Step 11-1]
    translate([450, 0, -450]) rotate() color([0.35, 0.35, 0.38]) {
        difference() {
            cylinder(h = anchor_total_length * 0.45, d = pivot_bore_diameter + (armor_skin_thickness * 2), center = true);
            cylinder(h = anchor_total_length * 0.5, d = pivot_bore_diameter, center = true);
            
            for (z_offset = [-150, 0, 150]) {
                translate([0, (pivot_bore_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            cube([harness_conduit_width, pivot_bore_diameter + 100, anchor_total_length], center = true);
            translate([0, -pivot_bore_diameter, 0])
                cube([pivot_bore_diameter * 2, pivot_bore_diameter * 2, anchor_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_E_Wing_Anchor_Forge();
