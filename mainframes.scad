include <variables.scad>

use <extrusions.scad>

module mainframes() {
    // axisx
    // axisx ul
    translate([ext_sidelen, depth - ext_sidelen, height - ext_sidelen]) {
        xext(width - ext_sidelen * 2);
    }
    // axisx ur
    translate([ext_sidelen, 0, height - ext_sidelen]) {
        xext(width - ext_sidelen * 2);
    }
    // axisx lr
    translate([ext_sidelen, 0, 0]) {
        xext(width - ext_sidelen * 2);
    }
    // axisx ll
    translate([ext_sidelen, depth - ext_sidelen, 0]) {
        xext(width - ext_sidelen * 2);
    }

    // asixy
    // asixy ul
    translate([0, ext_sidelen, height - ext_sidelen]) {
        yext(depth - ext_sidelen * 2);
    }
    // asixy ur
    translate([width - ext_sidelen, ext_sidelen, height - ext_sidelen]) {
        yext(depth - ext_sidelen * 2);
    }
    // asixy lr
    translate([width - ext_sidelen, ext_sidelen, 0]) {
        yext(depth - ext_sidelen * 2);
    }
    // asixy ll
    translate([0, ext_sidelen, 0]) {
        yext(depth - ext_sidelen * 2);
    }

    // asixz
    // asixz ul
    translate([0, 0, 0]) {
        zext(height);
    }
    // asixz ur
    translate([width - ext_sidelen, 0, 0]) {
        zext(height);
    }
    // asixz lr
    translate([width - ext_sidelen, depth - ext_sidelen, 0]) {
        zext(height);
    }
    // asixz ll
    translate([0, depth - ext_sidelen, 0]) {
        zext(height);
    }

    // mobo mount
    // mobo mount row 0
    translate([ width - ext_sidelen, 
                ext_sidelen + alu_thickness + rad_depth 
                    + front_rad_clearance - ext_sidelen / 2  
                    + screw_row_0_to_top, 
                ext_sidelen ]) {
        zext(height - ext_sidelen * 2);
    }
    // mobo mount row 1
    translate([ width - ext_sidelen, 
                ext_sidelen + alu_thickness + rad_depth 
                    + front_rad_clearance - ext_sidelen / 2  
                    + screw_row_1_to_top, 
                ext_sidelen ]) {
        zext(height - ext_sidelen * 2);
    }
    // mobo mount row 2
    if (mobo_ff != "mITX" && mobo_ff != "mDTX") 
        translate([ width - ext_sidelen, 
                    ext_sidelen + alu_thickness + rad_depth 
                        + front_rad_clearance - ext_sidelen / 2  
                        + screw_row_2_to_top, 
                    ext_sidelen ]) {
            zext(height - ext_sidelen * 2);
        }
}

module pcie_mount() {
    module lineup() {
        for (i = [0: pci_lock_multiplier - 1]) {
            translate([20.32 * i, 0, 0]) children(0);
        }
    }
    mount_height = width - ext_sidelen * 2 
                    - (mobo_clearance + mobo_thickness 
                    + 16.15 - 8.25 + 100.36 + pci_mount_thickness);
    module _mount() {
        difference() { // aluminum
            cube([ pci_socket_distance, 
                ext_sidelen, pci_mount_thickness ]);
            translate([ pci_socket_distance / 2, ext_sidelen / 2, -0.01 ])
                cylinder(d = alu_ext_screw_hole_size, 
                         h = pci_mount_thickness + 0.02);
        }
        
        cube([ pci_socket_distance, 
            pci_mount_thickness, 
            mount_height ]);

        // pcie panel
        translate([0, 0, mount_height - pci_mount_thickness]) {
            difference() {
                cube([ pci_socket_distance,
                     mobo_offset + (57.15 - 49.65) - 9.40,
                     pci_mount_thickness ]);
                translate([ pci_socket_distance / 2, 
                            pci_mount_thickness + (mobo_offset + (57.15 - 49.65) - 9.40) / 2,
                            -0.01 ])
                    cylinder(d = 3.5, 
                             h = pci_mount_thickness + 0.02);
            }
        }
        // pcie lock
        translate([0, 0, mount_height + pci_mount_thickness]) {
            difference() {
                cube([ pci_socket_distance,
                     mobo_offset + (57.15 - 49.65) - 9.40,
                     pci_mount_thickness ]);
                translate([ pci_socket_distance / 2, 
                            pci_mount_thickness + (mobo_offset + (57.15 - 49.65) - 9.40) / 2,
                            -0.01 ])
                    cylinder(d = 3.5, 
                             h = pci_mount_thickness + 0.02);
            }
        }
    }
    color("#A7CF36") 
        translate([0, pci_socket_distance * pci_lock_multiplier]) 
            rotate([0, 90, 0])  
                rotate([0, 0, -90])  
                    lineup() 
                        _mount();
}
