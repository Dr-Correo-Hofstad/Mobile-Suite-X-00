// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AIRFRAME STRUCTURAL BACKBONE
// COMPONENT VAULT: BANDAI CAST RUNNER G - SPINAL CONNECTORS G14 & G15
// MANUFACTURING SPECS: SOLID-STATE CAST-IN POWER RAILS FOR SQUARE-WAVE BUS
// ENGINEERING PARITY: SHIELDING CORES FOR 22-G VERTICAL BOOSTER ROCKET LAUNCH
// ============================================================================

$fn = 100; // Circular segment resolution calculation count

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
spinal_bar_height = 1650;               // Total vertical backbone length (mm)
mounting_bracket_bore = 380;            // Main core pivot fastener diameter (mm)
armor_shield_wall = 85;                 // Heavy solid TiAl reinforcing plate thickness (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_G_Spine_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = spinal_bar_height * 2.2, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 0, 600]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
        translate([0, 0, -600]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically (Left & Right Halves)
    Cast_Spinal_Backbone_Components();
}

module Cast_Spinal_Backbone_Components() {
    // ---- PART G14: INTERNAL LEFT SPINAL CONNECTOR BAR ---- [Page 18, Step 10-5]
    translate([-400, 0, 450]) color([0.35, 0.35, 0.38]) { // Inner Frame Gunmetal Spec
        difference() {
            // Main solid high-strength upper back spinal brace block
            cube([280, 420, spinal_bar_height * 0.45], center = true);
            
            // Integrated Multi-Axis Core Tracking Linkage Pivot Bore
            translate([0, 0, (spinal_bar_height * 0.15)])
                rotate([0, 90, 0])
                    cylinder(h = 300, d = mounting_bracket_bore, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 420 + 10, spinal_bar_height], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell mating part
            translate([200, 0, 0])
                cube([400, 500, spinal_bar_height], center = true);
        }
    }
    
    // ---- PART G15: INTERNAL RIGHT SPINAL CONNECTOR BAR ---- [Page 18, Step 10-5]
    translate([400, 0, -450]) rotate([0, 0, 180]) color([0.35, 0.35, 0.38]) {
        difference() {
            cube([280, 420, spinal_bar_height * 0.45], center = true);
            translate([0, 0, (spinal_bar_height * 0.15)])
                rotate([0, 90, 0])
                    cylinder(h = 300, d = mounting_bracket_bore, center = true);
            cube([harness_conduit_width, 420 + 10, spinal_bar_height], center = true);
            translate([200, 0, 0])
                cube([400, 500, spinal_bar_height], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_G_Spine_Forge();
