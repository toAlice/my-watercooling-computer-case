include <variables.scad>

module fan(size = 120, thickness = 25, blade = 9, 
           screw_dia = 4.3, screw_dis = 105, shroud = true) {
    module makeblade(blade = 5) {
        for (i = [0 : blade - 1]) {
            rotate([0, 0, 360 * i / blade]) children(0);
        }
    }

    frame_color = "#DFCEB7";

    fan_scale = 4;

    if (shroud) {
        // frame
        color(frame_color) difference() {
            linear_extrude(height = thickness) {
                translate([ (size - screw_dis) / 2, 
                            (size - screw_dis) / 2, 0 ]) {
                    minkowski() {
                        square(screw_dis);
                        circle(r = (size - screw_dis) / 2);
                    }
                }
            }
            translate([size / 2, size / 2, - 0.01]) {
                cylinder(d = size - 2, h = thickness + 0.02);
            }
            translate([(size - screw_dis) / 2, (size - screw_dis) / 2, -0.01]) {
                cylinder(d = screw_dia, h = thickness + 0.02);
            }
            translate([size - (size - screw_dis) / 2, size - (size - screw_dis) / 2, -0.01]) {
                cylinder(d = screw_dia, h = thickness + 0.02);
            }
            translate([(size - screw_dis) / 2, size - (size - screw_dis) / 2, -0.01]) {
                cylinder(d = screw_dia, h = thickness + 0.02);
            }
            translate([size - (size - screw_dis) / 2, (size - screw_dis) / 2, -0.01]) {
                cylinder(d = screw_dia, h = thickness + 0.02);
            }
        }

        // frame arms
        color(frame_color) translate([size / 2, size / 2, thickness * 6 / 7 - 0.01]) {
            linear_extrude(height = thickness / 7, twist = 0) {
                intersection() {
                    rotate([0, 0, 45])  {
                        makeblade(blade = 6) {
                            polygon([
                                [size / 5, 0], 
                                [size / 5, size / 2], 
                                [size / 5 - 4, size / 2], 
                                [size / 5 - 4, 0]
                            ]);
                        }
                    }
                    square(size, center = true);
                }
                circle(d = size * 2 / 5);
            }
        }
    }
    

    // blade
    color("#976961") translate([size / 2, size / 2, 0]) {
        linear_extrude(height = thickness / 4 * 3, twist = 22.5) {
            intersection() {
                makeblade(blade = blade) {
                    translate([ size / fan_scale, 0, 0]) intersection() {
                        difference() {
                            circle(d = size * 2 / fan_scale);
                            offset(-1.6) circle(d = size * 2 / fan_scale);
                        }
                        translate([ -size, -size * 2, 0]) square(size * 2);
                    } 
                }
                circle(d = size - 4);
            }
            circle(d = size * 2 / 5);
        }
    }
}

module fan20(facing = true) {
    translate([0, facing ? 0 : fan_thickness, 0]) {
        rotate([90, 0, 0]) {
            mirror([0, 0, facing ? 1 : 0]) {
                fan(size = fan_size, thickness = fan_thickness, blade = 9, 
                    screw_dia = 4.3, screw_dis = fan_mount_spacing);
            }
        }
    }
}

module rad_fans() {
    // front
    translate([(width - fan_size) / 2, 
                ext_sidelen - fan_thickness, 
                unit_space + ext_sidelen + unit_space * 4 + rad_bottom_height]) {
        fan20();
        translate([0, 0, fan_size]) fan20();
    }
    translate([(width - fan_size) / 2, 
                ext_sidelen + alu_thickness + rad_depth, 
                unit_space + ext_sidelen + unit_space * 4 + rad_bottom_height]) {
        fan20();
        translate([0, 0, fan_size]) fan20();
    }
    // back
    if (mobo_ff != "mITX" && mobo_ff != "mDTX") {
        translate([(width - fan_size) / 2, 
                    depth - ext_sidelen, 
                    unit_space + ext_sidelen + unit_space * 4 + rad_bottom_height]) {
            fan20(false);
            translate([0, 0, fan_size]) fan20(false);
        }
    }
    if (mobo_ff != "mITX" && mobo_ff != "mDTX") {
        translate([(width - fan_size) / 2, 
                    depth - ext_sidelen - alu_thickness - rad_depth - fan_thickness, 
                    unit_space + ext_sidelen + unit_space * 4 + rad_bottom_height]) {
            fan20(false);
            translate([0, 0, fan_size]) fan20(false);
        }
    }
}

module rad_fan_mounts() {
    module fan20_mount() {
        screw_spacing = 6;
        module _slice() {
            difference() {
                polygon([
                    [0, 0],
                    [0, fan_mount_spacing / 2 + screw_spacing],
                    [(width - fan_mount_spacing) / 2 + screw_spacing,
                        fan_mount_spacing / 2 + screw_spacing],
                    [(width - fan_mount_spacing) / 2 + screw_spacing,
                        fan_mount_spacing / 2 - screw_spacing / 2],
                    [ext_sidelen, fan_mount_spacing / 2 - screw_spacing
                        - ((width - fan_mount_spacing) / 2 - ext_sidelen) 
                        / sqrt(3)],
                    [ext_sidelen, 0],
                ]);
                translate([ ext_sidelen / 2,
                            fan_mount_spacing / 2 + screw_spacing 
                                - ext_sidelen / 2 ]) {
                    circle(d = alu_ext_screw_hole_size);
                }
                translate([ (width - fan_mount_spacing) / 2,
                            fan_mount_spacing / 2 ]) {
                    circle(d = 5);
                }
            }
        }
        color("#AF9FEF") {
            translate([ 0, 
                        fan_mount_spacing / 2 + (fan_size - fan_mount_spacing) / 2,
                        0 ]) {
                linear_extrude(height = alu_thickness) {
                    union() {
                        translate([ 0, -0.01, 0 ]) _slice();
                        scale([1, -1, 1]) _slice();
                    }        
                }
            }
        }
    }
    module vert() {
        translate([0, alu_thickness, 0]) rotate([90, 0, 0]) fan20_mount();
    }
    module verti() {
        rotate([90, 0, 180]) fan20_mount();
    }
    module _set() {
        vert();
        translate([0, 0, fan_size]) vert();
        translate([width, 0, 0]) {
            verti();
            translate([0, 0, fan_size]) verti();
        }
    }
    // front
    translate([0, 
                ext_sidelen, 
                unit_space + ext_sidelen + unit_space * 4 + rad_bottom_height]) {
        _set();
    }
    // back
    if (mobo_ff != "mITX" && mobo_ff != "mDTX") 
        translate([ 0, 
                    depth - ext_sidelen - alu_thickness, 
                    unit_space + ext_sidelen + unit_space * 4 + rad_bottom_height]) 
            _set();
}
