// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AIRFRAME ELECTRICAL TOTAL MATRIX
// COMPONENTS: RUNNER J (FINGERS), RUNNER D (WEAPONS), RUNNER E (WING BINDERS)
// PACKAGING CONFIG: UNIVERSAL DECENTRALIZED SUB-ARMOR CAPACITOR POCKETS
// RESISTOR PARITY: ZERO-RESISTOR DUAL-RAIL CASCADING ENERGY INTERLOCKS
// ============================================================================

$fn = 80; // High-precision circular rendering resolution

// Universal Sizing Elements Scaled 1:1 for a 16.7m Airframe Architecture (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 110;           // Transverse MLCC array pocket width (mm)
harness_conduit_width = 40;             // Cast-in 4oz copper logic trace track (mm)
titanium_armor_skin = 35;               // Baseline defensive plating thickness (mm)

module Universal_Decentralized_Capacitor_Matrix() {
    // 1. Instantiate Capacitor-Enforced Component Modules Symmetrically
    Cast_Runner_J_Finger_Capacitors();
    Cast_Runner_D_Weapon_Capacitors();
    Cast_Runner_E_Wing_Capacitors();
}

module Cast_Runner_J_Finger_Capacitors() {
    // ---- PARTS J1 & J2 MODIFIED: MICRO-KNUCKLES WITH STORAGE BAYS ----
    translate([-300, 0, 800]) color([0.4, 0.4, 0.42]) { // Inner Frame Gunmetal Spec
        difference() {
            cylinder(h = 320, d = 145, center = true);
            cylinder(h = 340, d = 65, center = true); // Micro-cycloidal bore
            
            // Sub-Armor Recessed Capacitor Pocket (Traps finger-shove impact shocks)
            translate([0, (145/2 - titanium_armor_skin + capacitor_pocket_depth/2), 0])
                cube([capacitor_pocket_width * 0.6, capacitor_pocket_depth, 120], center = true);
                
            cube([harness_conduit_width, 150, 340], center = true);
        }
    }
}

module Cast_Runner_D_Weapon_Capacitors() {
    // ---- PARTS D3 & D4 MODIFIED: RIFLE STOCKS WITH RECOIL CAPACITOR RESERVOIRS ----
    translate([450, 0, 0]) color([0.5, 0.5, 0.55]) { // Weapon Metallic Casing Spec
        difference() {
            cube([380, 480, 1150], center = true);
            cube([310, 410, 1160], center = true); // Internal receiver line
            
            // Multi-Stage Sub-Armor Capacitor Bays (Drinks Twin Buster Rifle blast surges)
            for (z_offset = [-300, 300]) {
                translate([(380/2 - titanium_armor_skin + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 160], center = true);
            }
            cube([harness_conduit_width * 2, 500, 1170], center = true);
        }
    }
}

module Cast_Runner_E_Wing_Capacitors() {
    // ---- PARTS E19 TO E26 MODIFIED: DISTAL FEATHER FOCUSERS WITH FLUTTER CAPACITORS ----
    for (i = [0 : 2]) {
        translate([-600, 0, -800 + (i * 500)]) color([0.85, 0.85, 0.9]) { // White Wing Shell Spec
            difference() {
                scale([1.0, 0.15, 1.0])
                    cylinder(h = 900, r1 = 160, r2 = 40, center = true);
                
                // Embedded Casing Pocket for the Aerodynamic Aero-Elastic Shock Absorption Caps
                translate([0, 0, -200])
                    cube([capacitor_pocket_width * 0.8, capacitor_pocket_depth, 100], center = true);
                    
                cube([harness_conduit_width, 200, 920], center = true);
            }
        }
    }
}

// Render Global Hardware Mesh to Verification Layer
Universal_Decentralized_Capacitor_Matrix();
