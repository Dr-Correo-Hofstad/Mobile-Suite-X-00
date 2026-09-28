// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO - CORE COCKPIT COUPLER (NPP CAPSULE)
// SUB-MODULE: ATX COMPUTER MOUNTS, DUAL ECLSS HOUSING, & HATCH INTERLOCKS
// REVISED DESIGN STAGE: 100% TELEMETRIC SOLID-STATE POWER RETROFIT
// COMPATIBILITY: OPENSCAD v2021.01+ OR LATER WITH JSON EXPERIMENTAL ENABLED
// ============================================================================

\$fn = 100; // Geometry generation fidelity

// Master Dimensional Definitions (Scaled to SLS-Orion-II and Friendship-7 standards)
habitable_volume_target = 17300000;      // 17.3 Cubic Meters Habitable Target (mm^3)
capsule_inner_radius = 1850;            // Main cockpit pressure vessel radius (mm)
capsule_height = 2400;                  // Vertical enclosure clearance (mm)
structural_shell_thickness = 45;        // Layered Titanium-Aluminide wall (mm)

// Computational Bay Constraints (Standard Dual ATX Mainframe Layouts)
atx_mount_width = 305;                  // Standard ATX Board Dimension (mm)
atx_mount_length = 244;                 // ATX Depth Profile (mm)
shock_absorber_stroke = 60;             // GM_shocks.scad travel parameter (mm)

module Master_Core_Capsule() {
    difference() {
        // 1. External Protective Pressure Vessel
        color([0.8, 0.8, 0.85]) {
            cylinder(h = capsule_height + (structural_shell_thickness * 2), 
                     r1 = capsule_inner_radius + structural_shell_thickness, 
                     r2 = capsule_inner_radius * 0.7 + structural_shell_thickness, 
                     center = true);
        }
        
        // 2. Interior Habitable Footprint (17.3 m^3 Pressure Chamber Enclosure)
        color([0.2, 0.2, 0.22]) {
            cylinder(h = capsule_height, 
                     r1 = capsule_inner_radius, 
                     r2 = capsule_inner_radius * 0.7, 
                     center = true);
        }
        
        // 3. High-Precision Locking Hatch Port Cutout (`hatch.py` Interlock Path)
        translate([0, capsule_inner_radius + 20, 0])
            rotate([90, 0, 0])
                cube([900, capsule_height * 0.6, structural_shell_thickness * 4], center = true);
    }
    
    // Instantiate Internal Electronic and Life Support Sub-Allocations
    Internal_Capsule_Systems();
}

module Internal_Capsule_Systems() {
    // 4. ATX Mainframe Computational Mounts with Integrated Shock Dampers
    translate([0, 0, -(capsule_height / 2 - 150)]) {
        color([0.1, 0.5, 0.1]) { // KiCad Motherboard Array Placement
            // Dual-Stack ATX Board Configuration (UNIVAC IX / 3VL Control Logic)
            cube([atx_mount_width, atx_mount_length, 12], center = true);
            translate([0, 0, 40])
                cube([atx_mount_width, atx_mount_length, 12], center = true);
        }
        
        // Skeuomorphic `GM_shocks.scad` Structural Isolators
        color([0.4, 0.4, 0.4]) {
            translate([-(atx_mount_width/2 + 20), 0, -20])
                cylinder(h = 80, d = 25, center = true);
            translate([(atx_mount_width/2 + 20), 0, -20])
                cylinder(h = 80, d = 25, center = true);
        }
    }
    
    // 5. Dual-Chamber Environmental Life Support Array (`dynamic_eclss_array.scad`)
    color([0.3, 0.6, 0.9, 0.5]) {
        // Central Dielectric/Environmental Partition Divider Plate
        cube([capsule_inner_radius * 1.8, 15, capsule_height * 0.95], center = true);
        
        // Pilot-Side O2 Equalization and Fan Manifold
        translate([-(capsule_inner_radius / 2), 200, 0])
            cylinder(h = 350, d = 400, center = true);
            
        // Secondary Chamber Life Support Management Node
        translate([(capsule_inner_radius / 2), -200, 0])
            cylinder(h = 350, d = 400, center = true);
    }
    
    // 6. 360-Segment Electrostatic "Saiya" Ventral Deflector Rings
    for(segment = [0 : 10 : 360]) {
        rotate([0, 0, segment])
            translate([capsule_inner_radius + structural_shell_thickness - 10, 0, -(capsule_height / 2)])
                color([0.9, 0.9, 0.5])
                    cube([25, 45, 80], center = true);
    }
}

// Render Master Component to Parameter Workspace
Master_Core_Capsule();
