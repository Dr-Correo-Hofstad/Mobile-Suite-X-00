// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AIRFRAME STRUCTURAL CORE
// COMPONENT VAULT: BANDAI CAST RUNNER F - CHEST STABILIZERS F18 & F19
// COOLING SPECS: STRESS-INDUCED THERMOACOUSTIC PIEZO-ELASTIC INTEGRATION
// PARITY INTERFACE: PARALLEL CROSS SLIDES FOR SQUARE-WAVE RETROFITTING
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
stabilizer_beam_length = 1450;          // Total transverse tracking span (mm)
pivot_hinge_diameter = 240;             // Multi-axis attachment pin bore (mm)
titanium_core_wall = 65;                // Solid TiAl structural wall thickness (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
slider_track_stroke = 520;              // F18/F19 lateral slide travel envelope (mm)

module Runner_F_Stabilizer_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.24, 0.24, 0.26]) {
        cylinder(h = stabilizer_beam_length * 1.8, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 0, -450]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically (Left & Right Halves)
    Cast_Internal_Chest_Stabilizers();
}

module Cast_Internal_Chest_Stabilizers() {
    // ---- PART F18: LEFT INTERNAL SHOULDER BLADE TRACKING LINK ---- [Page 5, Step 02-5]
    translate([-400, 0, 450]) color([0.45, 0.45, 0.48]) { // Inner Frame Dark Spec
        difference() {
            // Main solid heavy-duty parallel stabilization slider arm
            cube([260, 340, stabilizer_beam_length * 0.45], center = true);
            
            // Central Multi-Axis Cross-Pivot Attachment Pin Hole
            translate([0, 0, (stabilizer_beam_length * 0.15)])
                rotate()
                    cylinder(h = 200, d = pivot_hinge_diameter, center = true);
            
            // Linear Sliding Guide Track Cutout (DLC Liner Clearance)
            translate([0, (340/2 - 40), 0])
                cube([110, 90, slider_track_stroke], center = true);
                
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 340 + 10, stabilizer_beam_length], center = true);
        }
    }
    
    // ---- PART F19: RIGHT INTERNAL SHOULDER BLADE TRACKING LINK ---- [Page 5, Step 02-5]
    translate([400, 0, -450]) rotate() color([0.45, 0.45, 0.48]) {
        difference() {
            cube([260, 340, stabilizer_beam_length * 0.45], center = true);
            translate([0, 0, (stabilizer_beam_length * 0.15)])
                rotate()
                    cylinder(h = 200, d = pivot_hinge_diameter, center = true);
            translate([0, (340/2 - 40), 0])
                cube([110, 90, slider_track_stroke], center = true);
            cube([harness_conduit_width, 340 + 10, stabilizer_beam_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Stabilizer_Forge();
