// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SENSOR CORE ARCHITECTURE
// COMPONENTS: RUNNER A (A18, A19 SKULLS) & RUNNER B (B19, B20, B21 COWL)
// DESIGN SPECS: HEAD SENSOR WEIGHT EXTRADITION FOR AIRFRAME COG BALANCING
// ELECTRICAL PARITY: ZERO-WIRE EMBEDDED CONDUITS FOR SQUARE-WAVE RETROFITTING
// ============================================================================

$fn = 80; // High-fidelity circular resolution segment count

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
head_cowl_height = 920;                 // Total vertical height of head assembly (mm)
sensor_bore_diameter = 340;             // Internal optical camera core width (mm)
antenna_span_length = 1850;             // B21 external tracking crest span (mm)
armor_skin_thickness = 35;              // Zoned TiAl protective shell gauge (mm)
harness_conduit_width = 40;             // Embedded 4oz copper logic rail track (mm)

module Master_Head_Assembly() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = head_cowl_height * 2.2, d = 35, center = true);
        translate([0, 0, 400]) rotate([0, 90, 0]) cylinder(h = 400, d = 18);
        translate([0, 0, -400]) rotate([0, 90, 0]) cylinder(h = 400, d = 18);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically
    Cast_Internal_Skull_Frames();
    Cast_External_Cowl_Armor();
}

module Cast_Internal_Skull_Frames() {
    // ---- PARTS A18 & A19: INTERNAL SKULL FRAMES ---- [Page 7, Step 7]
    color([0.4, 0.4, 0.42]) { // Inner Frame Gunmetal Spec
        // Left Skull Frame Base (A18)
        translate([-300, 0, 400])
            difference() {
                cube([220, 280, head_cowl_height * 0.4], center = true);
                cylinder(h = head_cowl_height, d = sensor_bore_diameter, center = true);
                cube([harness_conduit_width, 400, head_cowl_height], center = true);
            }
            
        // Right Skull Frame Base (A19)
        translate([300, 0, 400]) rotate([0, 0, 180])
            difference() {
                cube([220, 280, head_cowl_height * 0.4], center = true);
                cylinder(h = head_cowl_height, d = sensor_bore_diameter, center = true);
                cube([harness_conduit_width, 400, head_cowl_height], center = true);
            }
    }
}

module Cast_External_Cowl_Armor() {
    // ---- PARTS B19 & B20: EXTERNAL COWL SHELLS ---- [Page 7, Step 7]
    color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        // Left Cowl Plate (B19)
        translate([-350, 0, -400])
            difference() {
                sphere(r = 380);
                sphere(r = 380 - armor_skin_thickness);
                translate([200, 0, 0]) cube([400, 900, 900], center = true);
            }
            
        // Right Cowl Plate (B20)
        translate([350, 0, -400]) rotate([0, 0, 180])
            difference() {
                sphere(r = 380);
                sphere(r = 380 - armor_skin_thickness);
                translate([200, 0, 0]) cube([400, 900, 900], center = true);
            }
    }
    
    // ---- PART B21: LONG RANGE TELEMETRIC SENSOR ANTENNA VANE ---- [Page 7, Step 7]
    translate([0, -250, 0]) color([0.9, 0.8, 0.2]) { // Yellow Crest Spec
        difference() {
            // Tapered forward communications crest array
            scale([0.2, 1.0, 1.0])
                cylinder(h = antenna_span_length, r1 = 150, r2 = 30, center = true);
            // Internal 4oz solid-state copper conduit channel
            cube([10, 400, antenna_span_length + 20], center = true);
        }
    }
}

// Render Master Component to Parametric Workspace
Master_Head_Assembly();
