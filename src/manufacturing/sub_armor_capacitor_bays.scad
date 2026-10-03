// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AIRFRAME STRUCTURAL RE-ZONING
// COMPONENT VAULT: RUNNER F (PARTS F5 & F6) - THIGH FRAME INNER REINFORCEMENTS
// PACKAGING CONFIG: MULTI-LEVEL SUB-ARMOR CAPACITOR STORAGE RECESS SLOTS
// ELECTRICAL PARITY: ZERO-RESISTOR REGENERATIVE DISCHARGE TAKEOFF RETROFITS
// ============================================================================

$fn = 100; // Circular fragment rendering resolution count

// Structural Scaling Parameters (1:1 Dimensions for a 16.7m Mecha Architecture)
thigh_rib_length = 2850;                // Total longitudinal thigh core height (mm)
thigh_inner_diameter = 640;             // Internal skeletal framework core bore (mm)
titanium_bone_wall = 55;                // Solid TiAl interior structural wall gauge (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_F_Thigh_Rib_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = thigh_rib_length * 1.5, d = 42, center = true);
        translate() rotate() cylinder(h = 500, d = 22);
        translate([0, 0, -800]) rotate() cylinder(h = 500, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically
    Cast_Internal_Thigh_Ribs();
}

module Cast_Internal_Thigh_Ribs() {
    // ---- PART F5: INTERNAL LEFT THIGH STRUCTURAL REINFORCEMENT RIB ---- [Page 13, Step 6-1]
    translate([-450, 0, 600]) color([0.45, 0.45, 0.48]) { // Inner Frame Dark Spec
        difference() {
            // Main solid internal bone backbone column
            cube([340, 340, thigh_rib_length * 0.45], center = true);
            
            // Core Internal Structural Clearance (Bores out weight while leaving 55mm walls)
            cylinder(h = thigh_rib_length, d = thigh_inner_diameter, center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKET MOUNTS [Segmented rows cut inside the frame walls]
            for (z_offset = [-400, 0, 400]) {
                translate([0, (thigh_inner_diameter/2 - titanium_bone_wall + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 140], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 360, thigh_rib_length], center = true);
        }
    }
    
    // ---- PART F6: INTERNAL RIGHT THIGH STRUCTURAL REINFORCEMENT RIB ---- [Page 13, Step 6-1]
    translate([450, 0, -600]) rotate() color([0.45, 0.45, 0.48]) {
        difference() {
            cube([340, 340, thigh_rib_length * 0.45], center = true);
            cylinder(h = thigh_rib_length, d = thigh_inner_diameter, center = true);
            
            for (z_offset = [-400, 0, 400]) {
                translate([0, (thigh_inner_diameter/2 - titanium_bone_wall + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 140], center = true);
            }
            
            cube([harness_conduit_width, 360, thigh_rib_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Thigh_Rib_Forge();
