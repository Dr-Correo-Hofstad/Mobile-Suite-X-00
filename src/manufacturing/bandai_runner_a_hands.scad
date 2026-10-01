// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - MANIPULATOR CORE DESIGN
// COMPONENT VAULT: BANDAI CAST RUNNER A - HAND PALM BASES A23 & A24
// CIRCUIT CONFIG: SOLID-STATE INDUCTIVE POWER COUPLING RAILS
// REBALANCING SPECS: 5,200 Nm REACTIONARY BACKLASH SUPPRESSION LOCKS
// ============================================================================

$fn = 80; // Geometry segment resolution metric

// Global Manipulator Sizing Variables (1:1 Actual Metric Scale for 16.7m Mecha)
palm_block_width = 480;                  // Total transverse palm span width (mm)
palm_block_length = 520;                 // Longitudinal wrist-to-knuckle length (mm)
hand_armor_thickness = 35;              // Zoned TiAl outer shell thickness (mm)
harness_conduit_width = 80;             // Embedded 4oz copper logic trace track (mm)
inductive_pad_diameter = 140;           // Wireless weapon trigger coupling port (mm)

module Runner_A_Hand_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = palm_block_length * 2.5, d = 38, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 20);
        translate([0, 0, -500]) rotate() cylinder(h = 450, d = 20);
    }
    
    // Instantiate Scaled Part Molds Symmetrically (Left & Right Hands)
    Cast_Skeletal_Palm_Bases();
}

module Cast_Skeletal_Palm_Bases() {
    // ---- PART A23: INTERNAL LEFT PALM STRUCTURAL MAIN BONE ---- [Page 6, Step 4]
    translate([-400, 0, 450]) color([0.4, 0.4, 0.42]) {
        difference() {
            // Main solid heavy-duty core palm block plate
            cube([palm_block_width, palm_block_length, 180], center = true);
            
            // Sub-surface Intended Cavity for the Palm Inductive Power Contact Pad
            translate([0, 50, (180/2 - 10)])
                cylinder(h = 30, d = inductive_pad_diameter, center = true);
                
            // Five-axis finger knuckle pivot mounting sleeve ports (Cycloidal slots)
            for (offset = [-(palm_block_width/2 - 60) : (palm_block_width/4) : (palm_block_width/2 - 60)]) {
                translate([offset, (palm_block_length/2 - 40), 0])
                    rotate() cylinder(h = 200, d = 65, center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, palm_block_length + 10, 200], center = true);
        }
    }
    
    // ---- PART A24: INTERNAL RIGHT PALM STRUCTURAL MAIN BONE ---- [Page 6, Step 3]
    translate([400, 0, -450]) rotate() color([0.4, 0.4, 0.42]) {
        difference() {
            cube([palm_block_width, palm_block_length, 180], center = true);
            translate([0, 50, (180/2 - 10)])
                cylinder(h = 30, d = inductive_pad_diameter, center = true);
            for (offset = [-(palm_block_width/2 - 60) : (palm_block_width/4) : (palm_block_width/2 - 60)]) {
                translate([offset, (palm_block_length/2 - 40), 0])
                    rotate() cylinder(h = 200, d = 65, center = true);
            }
            cube([harness_conduit_width, palm_block_length + 10, 200], center = true);
        }
    }
}

// Render Finished Module Workspace Framework
Runner_A_Hand_Forge();
