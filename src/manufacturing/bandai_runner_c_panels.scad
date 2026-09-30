// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - FLIGHT SURFACE OUTER HULL
// COMPONENT VAULT: BANDAI CAST RUNNER C - WING BINDER PANELS C4 & C5
// MANUFACTURING PROTOCOL: SOLID-STATE CONDUIT HARNESSING HOUSINGS
// ENGINEERING STANDARD: STRESS-INDUCED THERMOACOUSTIC MATRIX COMPATIBILITY
// ============================================================================

$fn = 120; // High-precision circular segment generation count

// Global Flight-Skin Metrics (1:1 Scaling Factor for a 16.7m Mecha Architecture)
panel_span_length = 5200;                // Total longitudinal panel axis (mm)
chord_root_radius = 1350;               // Maximum wing root shell radius (mm)
flight_armor_wall = 25;                 // Optimized lightweight titanium-aluminide skin (mm)
harness_conduit_width = 80;             // Embedded 4oz copper logic trace track (mm)

module Runner_C_Panel_Forge() {
    // Central Supply Injection Runner Axis (Molten Magma Feed from Siphon Forge)
    color([0.3, 0.3, 0.32]) {
        cylinder(h = panel_span_length + 600, d = 48, center = true);
        // Direct injection gates splitting off straight to the part molds
        translate([0, 0, 900]) rotate([0, 90, 0]) cylinder(h = 550, d = 22);
        translate([0, 0, -900]) rotate([0, 90, 0]) cylinder(h = 550, d = 22);
    }
    
    // Instantiate Scaled Wing Shell Molds Symmetrically
    Cast_Wing_Binder_Outer_Panels();
}

module Cast_Wing_Binder_Outer_Panels() {
    // ---- PART C4: UPPER EXTERIOR FLIGHT PANEL SHELL (LEFT) ---- [Page 8, Step 9]
    translate([550, 0, 600]) color([0.85, 0.85, 0.9]) {
        difference() {
            // Parabolic curved lifting outer aerodynamic skin surface
            scale([1.0, 0.38, 1.0])
                cylinder(h = panel_span_length * 0.45, r1 = chord_root_radius, r2 = chord_root_radius * 0.35, center = true);
            
            // Internal pocket excavation (Enforces the rigid 25mm protective boundary)
            scale([1.0, 0.38, 1.0])
                cylinder(h = panel_span_length * 0.5, r1 = chord_root_radius - flight_armor_wall, r2 = (chord_root_radius * 0.35) - flight_armor_wall, center = true);
            
            // Sub-surface cast-in grooves to accommodate the zero-wire copper harness rails
            cube([harness_conduit_width, chord_root_radius * 2, panel_span_length], center = true);
            
            // Slicing profile tool to yield an asymmetrical half-shell part component
            translate([0, -chord_root_radius, 0])
                cube([chord_root_radius * 3, chord_root_radius * 2, panel_span_length * 2], center = true);
        }
    }
    
    // ---- PART C5: LOWER EXTERIOR FLIGHT PANEL SHELL (RIGHT) ---- [Page 8, Step 9]
    translate([-550, 0, -600]) rotate([0, 180, 0]) color([0.85, 0.85, 0.9]) {
        difference() {
            scale([1.0, 0.38, 1.0])
                cylinder(h = panel_span_length * 0.45, r1 = chord_root_radius, r2 = chord_root_radius * 0.35, center = true);
            scale([1.0, 0.38, 1.0])
                cylinder(h = panel_span_length * 0.5, r1 = chord_root_radius - flight_armor_wall, r2 = (chord_root_radius * 0.35) - flight_armor_wall, center = true);
            cube([harness_conduit_width, chord_root_radius * 2, panel_span_length], center = true);
            translate([0, -chord_root_radius, 0])
                cube([chord_root_radius * 3, chord_root_radius * 2, panel_span_length * 2], center = true);
        }
    }
}

// Instantiate Global Tray Assembly for Workspace Geometry Compiling
// Runner_C_Panel_Forge();
