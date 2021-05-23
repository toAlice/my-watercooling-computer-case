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

module psu_mount() {
    module hexagon(size = 6) {
        polygon([
            [-size / 2, size * sqrt(3) / 2],
            [size / 2, size * sqrt(3) / 2],
            [size, 0],
            [size / 2, -size * sqrt(3) / 2],
            [-size / 2, -size * sqrt(3) / 2],
            [-size, 0]
        ]);
    }
    module _frame() {
        difference() {
            polygon([
                [0, ext_sidelen + psu_bottom_clearance],
                [0, ext_sidelen + psu_bottom_clearance + psu_atx_height],
                [ext_sidelen + psu_side_clearance + psu_atx_width,
                    ext_sidelen + psu_bottom_clearance + psu_atx_height],
                [ext_sidelen + psu_side_clearance + psu_atx_width, 0],
                [ext_sidelen + psu_side_clearance, 0],
                [ext_sidelen + psu_side_clearance, 
                    ext_sidelen + psu_bottom_clearance]
            ]);
            polygon([
                [ext_sidelen + psu_side_clearance + 6,
                    ext_sidelen + psu_bottom_clearance + 6],
                [ext_sidelen + psu_side_clearance + 6,
                    ext_sidelen + psu_bottom_clearance + psu_atx_height - 6],
                [ext_sidelen + psu_side_clearance + psu_atx_width - 6,
                    ext_sidelen + psu_bottom_clearance + psu_atx_height - 6],
                [ext_sidelen + psu_side_clearance + psu_atx_width - 6,
                    ext_sidelen + psu_bottom_clearance + 6]
            ]);
        }
        translate([ext_sidelen + psu_side_clearance, 
            ext_sidelen + psu_bottom_clearance]) {
            translate([6, 80]) hexagon();
            translate([30, 6]) hexagon();
            translate([144, 16]) rotate([0, 0, 30]) hexagon();
            translate([144, 80]) hexagon();
        }
    }
    module _slice() {
        difference() {
            _frame();
            translate([ext_sidelen + psu_side_clearance, 
                ext_sidelen + psu_bottom_clearance]) {
                translate([6, 80]) circle(d = alu_ext_screw_hole_size);
                translate([30, 6]) circle(d = alu_ext_screw_hole_size);
                translate([144, 16]) circle(d = alu_ext_screw_hole_size);
                translate([144, 80]) circle(d = alu_ext_screw_hole_size);
            }
            translate([ ext_sidelen / 2, 
                        ext_sidelen + psu_bottom_clearance + ext_sidelen / 2,
                        0 ]) {
                circle(d = alu_ext_screw_hole_size);
            }
            translate([ ext_sidelen / 2, 
                        ext_sidelen + psu_bottom_clearance 
                        + psu_atx_height - ext_sidelen / 2 ]) {
                circle(d = alu_ext_screw_hole_size);
            }
            translate([ ext_sidelen + psu_side_clearance 
                        + ext_sidelen / 2,
                        ext_sidelen / 2 ]) {
                circle(d = alu_ext_screw_hole_size);
            }
            translate([ ext_sidelen + psu_side_clearance 
                        + psu_atx_width - ext_sidelen / 2,
                        ext_sidelen / 2 ]) {
                circle(d = alu_ext_screw_hole_size);
            }
        }
    }
    module corner_mount() {
        translate([ psu_atx_height + ext_sidelen + psu_bottom_clearance, 
                    alu_thickness, 0 ]) {
            rotate([ 90, -90, 0]) {
                color("#2F1F3F") {
                    linear_extrude(alu_thickness) {
                        _slice();
                    }
                }
            }
        }
    }
    
    // frames
    if (mobo_ff != "mITX" && mobo_ff != "mDTX") 
        translate([ ext_sidelen,
                    rad_depth + front_rad_clearance + screw_row_2_to_top 
                    - ext_sidelen / 2,
                    0 ]) xext(width - ext_sidelen * 2);
    translate([ ext_sidelen,
                rad_depth + front_rad_clearance + screw_row_2_to_top 
                + ext_sidelen / 2 - psu_length,
                0 ]) xext(width - ext_sidelen * 2);

    

    if (mobo_ff != "mITX" && mobo_ff != "mDTX") {
        translate([ width - ext_sidelen - psu_bottom_clearance - psu_atx_height,
                    ext_sidelen + rad_depth 
                    + front_rad_clearance + screw_row_2_to_top 
                    - ext_sidelen / 2,
                    0 ]) {
            corner_mount();
        }
    } else {
        translate([ width - ext_sidelen - psu_bottom_clearance - psu_atx_height,
                    depth,
                    0 ]) {
            corner_mount();
        }
    }
}

module pump_mount() {
    translate([ ext_sidelen,
                rad_depth + front_rad_clearance + screw_row_2_to_top 
                + ext_sidelen + ext_sidelen / 2 
                - psu_length - pump_mount_size,
                0 ]) xext(width - ext_sidelen * 2);
    translate([ 0,
                rad_depth + front_rad_clearance + screw_row_2_to_top
                + ext_sidelen - psu_length - pump_mount_size / 2,
                ext_sidelen ]) zext(height - ext_sidelen * 2);
}
