// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - FLIGHT SURFACE MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER C - WING BINDERS C1 & C3
// INTEGRATION MANIFEST: SOLID-STATE ELECTRICAL HARNESS CORE PRODUCTION
// DESIGN FOCUS: CURVED PARAMETRIC FLIGHT PATHS & EMBEDDED CONDUIT COUPLERS
// ============================================================================

$fn = 120; // High-fidelity curved rendering profile

// Wing Geometric Constraints & Scale Variables (1:1 Metrics for 16.7m Chassis)
wing_span_length = 6800;                // Longitudinal wing element axis (mm)
base_chord_width = 1600;                // Proximal root thickness envelope (mm)
titanium_skin_wall = 25;                // Optimized lightweight flight armor (mm)
harness_conduit_width = 90;             // Cast-in 4oz copper bus rail track (mm)

module Runner_C_Wing_Casts() {
    // Master Injection Distribution Sprue (Siphon Forge Magma Conduit)
    color([0.28, 0.28, 0.3]) {
        cylinder(h = wing_span_length + 800, d = 50, center = true);
        // Direct injection gates tracking straight to the shell mold profiles
        translate([0, 300, 1500]) rotate([0, 90, 0]) cylinder(h = 600, d = 25);
        translate([0, 300, -1500]) rotate([0, 90, 0]) cylinder(h = 600, d = 25);
    }
    
    // Instantiate Scaled Wing Armor Component Shells
    Cast_Solid_State_Flight_Surfaces();
}

module Cast_Solid_State_Flight_Surfaces() {
    // ---- PART C1: MAIN WING ARMORED HULL SHELL (LEFT) ---- [From Page 7, Step 8]
    translate([600, 0, 1200]) color([0.85, 0.85, 0.9]) {
        difference() {
            // Parametric Curved Aerodynamic Lifting Surface
            scale([1.0, 0.4, 1.0])
                cylinder(h = wing_span_length * 0.45, r1 = base_chord_width, r2 = base_chord_width * 0.4, center = true);
            
            // Internal Packaging Space (Isolates Outer Titanium Defensive Shield)
            scale([1.0, 0.4, 1.0])
                cylinder(h = wing_span_length * 0.5, r1 = base_chord_width - titanium_skin_wall, r2 = (base_chord_width * 0.4) - titanium_skin_wall, center = true);
            
            // Clean splitting cut to generate the asymmetrical outer wing half-shell
            translate([0, -base_chord_width, 0])
                cube([base_chord_width * 3, base_chord_width * 2, wing_span_length], center = true);
        }
        
        // INTEGRATED SOLID-STATE FRAMEWORK HARNESS [Cables built into structural ribs]
        color([1.0, 0.73, 0.2]) { // Embedded 4oz pure copper track array
            translate([200, 40, 0])
                cube([harness_conduit_width, 15, wing_span_length * 0.4], center = true);
            translate([400, 30, 200])
                cube([harness_conduit_width, 15, wing_span_length * 0.3], center = true);
        }
    }
    
    // ---- PART C3: MAIN WING ARMORED HULL SHELL (RIGHT) ---- [From Page 8, Step 9]
    translate([600, 0, -1200]) rotate([180, 0, 0]) color([0.85, 0.85, 0.9]) {
        difference() {
            scale([1.0, 0.4, 1.0])
                cylinder(h = wing_span_length * 0.45, r1 = base_chord_width, r2 = base_chord_width * 0.4, center = true);
            scale([1.0, 0.4, 1.0])
                cylinder(h = wing_span_length * 0.5, r1 = base_chord_width - titanium_skin_wall, r2 = (base_chord_width * 0.4) - titanium_skin_wall, center = true);
            translate([0, -base_chord_width, 0])
                cube([base_chord_width * 3, base_chord_width * 2, wing_span_length], center = true);
        }
        
        // INTEGRATED SOLID-STATE FRAMEWORK HARNESS [Zero exposed wiring connection bus]
        color([1.0, 0.73, 0.2]) {
            translate([200, 40, 0])
                cube([harness_conduit_width, 15, wing_span_length * 0.4], center = true);
            translate([400, 30, 200])
                cube([harness_conduit_width, 15, wing_span_length * 0.3], center = true);
        }
    }
}

// Render Geometry Core to Parametric Design Space
Runner_C_Wing_Casts();
