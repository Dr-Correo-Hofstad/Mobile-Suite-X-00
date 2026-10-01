// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - UPPER AIRFRAME EXTRACTIONS
// COMPONENT VAULT: BANDAI CAST RUNNER B - BICEP ARMOR SHELLS B17 & B18
// REBALANCING PARITY: UPPER LIMB WEIGHT TRACKING BEFORE GLOBAL LEG CALCULATIONS
// DESIGN PROTOCOL: WIRELESS INDUCTIVE HARNESS MATING HOUSINGS
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
bicep_armor_length = 1650;              // Total vertical height of upper arm armor (mm)
bicep_outer_diameter = 440;             // Transverse shell casing envelope width (mm)
armor_skin_thickness = 35;              // Solid TiAl defensive protective wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_B_Bicep_Armor_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = bicep_armor_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 300, d = 22);
        translate([0, 250, -400]) rotate() cylinder(h = 300, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically
    Cast_Upper_Arm_Armor_Shells();
}

module Cast_Upper_Arm_Armor_Shells() {
    // ---- PART B17: LEFT BICEP EXTERIOR PROTECTION SHELL ---- [Page 6, Step 4]
    translate([-450, 0, 450]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main cylindrical contoured upper arm protective panel
            cylinder(h = bicep_armor_length * 0.45, d1 = bicep_outer_diameter + 60, d2 = bicep_outer_diameter, center = true);
            
            // Internal pocket excavation (Leaves the rigid 35mm protective boundary)
            cylinder(h = bicep_armor_length * 0.5, d1 = bicep_outer_diameter + 60 - (armor_skin_thickness*2), d2 = bicep_outer_diameter - (armor_skin_thickness*2), center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, bicep_outer_diameter + 80, bicep_armor_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -bicep_outer_diameter, 0])
                cube([bicep_outer_diameter * 2, bicep_outer_diameter * 2, bicep_armor_length * 2], center = true);
        }
    }
    
    // ---- PART B18: RIGHT BICEP EXTERIOR PROTECTION SHELL ---- [Page 6, Step 3]
    translate([450, 0, -450]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            cylinder(h = bicep_armor_length * 0.45, d1 = bicep_outer_diameter + 60, d2 = bicep_outer_diameter, center = true);
            cylinder(h = bicep_armor_length * 0.5, d1 = bicep_outer_diameter + 60 - (armor_skin_thickness*2), d2 = bicep_outer_diameter - (armor_skin_thickness*2), center = true);
            cube([harness_conduit_width, bicep_outer_diameter + 80, bicep_armor_length], center = true);
            translate([0, -bicep_outer_diameter, 0])
                cube([bicep_outer_diameter * 2, bicep_outer_diameter * 2, bicep_armor_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_B_Bicep_Armor_Forge();
