// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER LIMB ARTIULATION CORE
// COMPONENT VAULT: BANDAI CAST RUNNER F - KNEE ADAPTERS F7 & F9
// CONFIG SPECS: DUAL-AXIS CYCLOIDAL JOINT SHUNT (1:1 METRIC UP-SCALE)
// PARITY INTERFACE: SLIDING ARMOR TRACKS & EMBEDDED CONDUIT HARNESS CORES
// ============================================================================

$fn = 100; // Circular segment resolution calculation count

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
adapter_block_height = 760;             // Total vertical thickness of adapter (mm)
cycloidal_bore_diameter = 540;          // Inner cycloidal reduction ring bore (mm)
structural_core_wall = 55;              // Thick TiAl frame reinforcement (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
tracking_slot_stroke = 420;             // F9 parallel armor sliding guide length (mm)

module Runner_F_Adapter_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.24, 0.24, 0.26]) {
        cylinder(h = adapter_block_height * 2.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 0, -500]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically (Left & Right Halves)
    Cast_Internal_Knee_Adapters();
}

module Cast_Internal_Knee_Adapters() {
    // ---- PART F7: LOWER LEFT THIGH KNEE ADAPTER HOUSING ---- [Page 7, Step 5 / Page 7, Step 08-1]
    translate([-450, 0, 450]) color([0.45, 0.45, 0.48]) { // Inner Frame Dark Spec
        difference() {
            // Main high-strength structural adapter collar block
            cylinder(h = adapter_block_height * 0.5, d = cycloidal_bore_diameter + (structural_core_wall * 2), center = true);
            
            // Concentric Internal Boring for the Cycloidal Pin Rolling Tracks
            cylinder(h = adapter_block_height * 0.6, d = cycloidal_bore_diameter, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, cycloidal_bore_diameter + 150, adapter_block_height], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([cycloidal_bore_diameter, 0, 0])
                cube([cycloidal_bore_diameter * 2, cycloidal_bore_diameter * 2, adapter_block_height * 2], center = true);
        }
    }
    
    // ---- PART F9: LOWER RIGHT THIGH KNEE ADAPTER WITH GUIDE RAIL ---- [Page 7, Step 5 / Page 7, Step 08-1]
    translate([450, 0, -450]) rotate() color([0.45, 0.45, 0.48]) {
        difference() {
            cylinder(h = adapter_block_height * 0.5, d = cycloidal_bore_diameter + (structural_core_wall * 2), center = true);
            cylinder(h = adapter_block_height * 0.6, d = cycloidal_bore_diameter, center = true);
            
            // Parallel Sliding Tracking Channel for armor sync loops
            translate([0, (cycloidal_bore_diameter/2), 0])
                cube([tracking_slot_stroke, 120, adapter_block_height + 20], center = true);
                
            cube([harness_conduit_width, cycloidal_bore_diameter + 150, adapter_block_height], center = true);
            translate([cycloidal_bore_diameter, 0, 0])
                cube([cycloidal_bore_diameter * 2, cycloidal_bore_diameter * 2, adapter_block_height * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Adapter_Forge();
