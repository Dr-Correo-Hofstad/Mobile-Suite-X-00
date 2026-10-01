// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - THRUST REBALANCING MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER B - EXHAUST NOZZLES B21 & B22
// ENGINE SPEC: ELECTROACOUSTIC PLASMA VORTEX MOUNT COMPLETION
// ELECTRICAL PARITY: SOLID-STATE EMBEDDED CONDUITS FOR SQUARE-WAVE RETROFITTING
// ============================================================================

$fn = 100; // Circular segment resolution calculation count

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
exhaust_barrel_length = 980;            // Total longitudinal exhaust axis (mm)
nozzle_throat_diameter = 740;           // Core gas containment inner width (mm)
armor_casing_wall = 60;                 // Solid TiAl protective wall thickness (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
vector_flap_length = 520;               // B22 variable deflection plate axis (mm)

module Runner_B_Exhaust_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = exhaust_barrel_length * 2.2, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 0, -500]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically
    Cast_Exhaust_Vector_Components();
}

module Cast_Exhaust_Vector_Components() {
    // ---- PART B21: CENTRAL EXHAUST CONTAINMENT BARREL ---- [Page 18, Step 10-1]
    translate([-400, 0, 450]) color([0.7, 0.7, 0.75]) { // Standard Armor Grey Spec
        difference() {
            // Main solid heavy-duty high-pressure containment block
            cylinder(h = exhaust_barrel_length, d = nozzle_throat_diameter + (armor_casing_wall * 2), center = true);
            
            // Core Exhaust Bore Path (Isolates gas during sound excitation loops)
            cylinder(h = exhaust_barrel_length + 20, d = nozzle_throat_diameter, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, nozzle_throat_diameter + 150, exhaust_barrel_length + 10], center = true);
        }
    }
    
    // ---- PART B22: VARIABLE DEFLECTION EXHAUST FLAP ---- [Page 18, Step 10-3]
    // Houses internal electromagnetic hinges to execute zero-delay steering shifts
    translate([400, 0, -450]) color([0.3, 0.3, 0.32]) { // Inner Frame Dark Spec
        difference() {
            // Flat tapered deflection vector shield plate segment
            cube([260, 450, vector_flap_length], center = true);
            
            // Internal mounting slot for the air-gapped magnetic track pins
            translate([0, 0, (vector_flap_length/2 - 60)])
                rotate() cylinder(h = 300, d = 45, center = true);
                
            cube([harness_conduit_width, 500, vector_flap_length + 10], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_B_Exhaust_Forge();
