// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER FRAME DEFENSE MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER F - KNEE COVERS F11 & F12
// MANUFACTURING SPEC: SOLID-STATE INTEGRATED HARNESS INDUCTIVE PLUGS
// DESIGN CRITERIA: PARALLEL LINKAGE BAR CLEARANCE & DLC LOW-FRICTION SLIDERS
// ============================================================================

$fn = 100; // Circular fragment resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
kneecap_total_height = 1150;            // Total longitudinal shield vertical span (mm)
kneecap_outer_width = 720;              // Transverse armor plate envelope width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
linkage_bar_length = 820;               // F11 tracking scissor arm longitudinal axis (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_F_Kneecap_Forge() {
    // Central Distribution Runner Axis (Feeds Molten Alloy from Siphon Forge)
    color([0.24, 0.24, 0.26]) {
        cylinder(h = kneecap_total_height * 2.2, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 0, 500]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
        translate([0, 0, -500]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically
    Cast_Moving_Knee_Shields();
}

module Cast_Moving_Knee_Shields() {
    // ---- PART F11: AUTOMATED MULTI-LINK TRACKING SCISSOR BAR ---- [Page 6, Step 1 & 2]
    translate([-450, 0, 500]) color([0.4, 0.4, 0.42]) {
        difference() {
            // High-tensile strength parallel alignment stabilization arm
            cube([110, 180, linkage_bar_length], center = true);
            
            // Recessed tracking slots for the inductive proximity coupling pins
            translate([0, 0, (linkage_bar_length/2 - 80)])
                rotate([0, 90, 0]) cylinder(h = 200, d = 50, center = true);
            translate([0, 0, -(linkage_bar_length/2 - 80)])
                rotate([0, 90, 0]) cylinder(h = 200, d = 50, center = true);
                
            // Internal conduit track for the cast-in solid-state electrical bus
            cube([40, harness_conduit_width, linkage_bar_length + 10], center = true);
        }
    }
    
    // ---- PART F12: KNEE CAP EXTERNAL PROTECTIVE ARMOR COVER ---- [Page 6, Step 1 & 2]
    // Utilizes sub-surface Diamond-Like Carbon (DLC) tracks to eliminate mechanical binding
    translate([450, -200, -500]) color([0.8, 0.8, 0.85]) {
        difference() {
            // Tapered parabolic protective knee guard shield plate
            scale([1.0, 0.4, 1.0])
                cylinder(h = kneecap_total_height, r1 = kneecap_outer_width * 0.5, r2 = kneecap_outer_width * 0.35, center = true);
            
            // Core internal thickness boring (Isolates the 50mm solid defensive wall)
            scale([1.0, 0.4, 1.0])
                cylinder(h = kneecap_total_height + 20, r1 = (kneecap_outer_width * 0.5) - armor_skin_thickness, r2 = (kneecap_outer_width * 0.35) - armor_skin_thickness, center = true);
            
            // Splitting cutout profile to forge a clean curved half-shell component panel
            translate([0, -kneecap_outer_width, 0])
                cube([kneecap_outer_width * 3, kneecap_outer_width * 2, kneecap_total_height * 2], center = true);
        }
    }
}

// Render Master Component Assembly to Parametric Design Space
Runner_F_Kneecap_Forge();
