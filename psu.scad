use <screws.scad>

use <fans.scad>

include <variables.scad>

module psu(form_factor = "ATX", length = 150) {
    module hscrew(len = 8) {
        translate([0, len / 2, 0])rotate([90, 0, 0]) screw_thread(len, 3.5, 0.7);
    }

    module power_connector() {
        cube([16, 18.5, 24]);
    }

    module psu_fan(size, thickness) {
        translate([-size / 2, -size / 2, thickness]) 
            scale([ 1, 1, -1 ]) 
                fan(size, thickness, shroud = false);
    }

    color("#AF3F3F") if (form_factor == "SFX") {
        difference() {
            cube([psu_sfx_width, length, psu_sfx_height]);
            translate([6, 0 - 0.01, 6]) hscrew();
            translate([6, 0 - 0.01, 31.7]) hscrew();
            translate([6, 0 - 0.01, 57.5]) hscrew();
            translate([119, 0 - 0.01, 6]) hscrew();
            translate([119, 0 - 0.01, 57.5]) hscrew();
            translate([psu_sfx_width / 2, length / 2, 38.5+0.02]) cylinder(h=25, d=92);
            translate([12, 0 - 0.02, 16 + 20]) rotate([0, 90, 0]) power_connector();
        }
    } else if (form_factor == "FLEX") {  
        difference() {
            cube([psu_flex_width, length, psu_flex_height]);
            translate([4.4, 0 - 0.01, 36]) hscrew();
            translate([15.2, 0 - 0.01, 37]) hscrew();
            translate([77.1, 0 - 0.01, 4]) hscrew();
            translate([77.1, 0 - 0.01, 36]) hscrew();
            translate([50, 20 - 0.02, 20.25]) rotate([90, 0, 0]) cylinder(h=20, d=40);
            translate([2, 0 - 0.02, 2]) power_connector();
        }
    } else {
        difference() {
            cube([psu_atx_width, length, psu_atx_height]);
            translate([6, 0 - 0.01, 80]) hscrew();
            translate([6, 0 - 0.01, 16]) hscrew();
            translate([120, 0 - 0.01, 6]) hscrew();
            translate([144, 0 - 0.01, 80]) hscrew();
            translate([75, length / 2, 61.02]) cylinder(h=25, d=140);
            translate([112, 0 - 0.02, 31.5]) power_connector();
        }
    }
    if (form_factor == "SFX") {
        translate([125 / 2, length / 2, 38.5+0.02]) psu_fan(92, 25);
    } else if (form_factor == "FLEX") {  
        translate([50, 20 - 0.02, 20.25]) rotate([90, 0, 0]) psu_fan(40, 15);
    } else {
        translate([75, length / 2, 61.02]) psu_fan(140, 25);
    }
}

module atx_psu(length) {
    translate([ 0, length, psu_atx_height ]) {
        scale([ 1, -1, -1 ]) {
            psu("ATX", length);
        }
    }
}

module atx_corner_mount() {
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
