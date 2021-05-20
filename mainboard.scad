include <mainframes.scad>

use <screws.scad>

module mainboard(form_factor = mobo_ff, pci_shift = 1, screw = true) {
    module lineup(num, space, r=false) {
        for (i = [0 : num - 1]) {
            if (r) {
                translate([0, space * i, 0]) children(0);
            } else {
                translate([space * i, 0, 0]) children(0);
            }
        }
    }

    module mobo_base() {
        difference() {
            color("#1F1F1F") union() {
                // pcb           
                cube([ mobo_height, mobo_width, mobo_thickness ]);

                // io panel
                translate([ -3.302, -1.143, -2.2352 ]) {
                    cube([ 158.75, 1.144, 44.75 ]);
                }
                // vrm? heatsink
                translate([ -3.302, 0, 0 ]) {
                    difference() {
                        cube([ 158.75, 35, 44.75 - 2.2352 ]);
                        translate([ 0, 0, -0.01 ])
                            linear_extrude(44.75 - 2.2352 + 0.02) polygon([
                                [ 0 - 0.01, 15 - 0.01 ],
                                [ 0 - 0.01, 35 + 0.01 ],
                                [ 20 + 0.01, 35 + 0.01 ]
                            ]);
                        translate([ 158.75, 0, -0.01 ])
                            linear_extrude(44.75 - 2.2352 + 0.02) polygon([
                                [ 0 + 0.01, 15 - 0.01 ],
                                [ 0 + 0.01, 35 + 0.01 ],
                                [ -20 - 0.01, 35 + 0.01 ]
                            ]);
                        polyhedron(points = [
                            [
                                0 - 0.01, 0 - 0.01,
                                44.75 - 2.2352 + 0.01
                            ],
                            [
                                0 - 0.01, 35 + 0.01,
                                44.75 - 2.2352 + 0.01
                            ],
                            [
                                158.75 + 0.01, 35 + 0.01,
                                44.75 - 2.2352 + 0.01
                            ],
                            [
                                158.75 + 0.01, 0 - 0.01,
                                44.75 - 2.2352 + 0.01
                            ],
                            [
                                158.75 + 0.01, 35 + 0.01,
                                44.75 - 2.2352 - 8 - 0.01
                            ],
                            [
                                0 - 0.01, 35 + 0.01,
                                44.75 - 2.2352 - 8 - 0.01
                            ]
                        ],
                        faces = [
                            [ 0, 1, 2, 3 ], [ 3, 2, 4 ],
                            [ 2, 1, 5, 4 ], [ 1, 0, 5 ],
                            [ 5, 0, 3, 4 ]
                        ]);
                    }
                }
            }

        union() { // screw holes
                translate([ screw_row_0_to_top,
                            screw_row_0_col_0_to_back, 
                            0 - 0.01 ]) {
                    cylinder(h = mobo_thickness + 0.02, r = 2.5);
                }
                translate([ screw_row_0_to_top, 
                            screw_col_1_to_back, 
                            0 - 0.01 ]) {
                    cylinder(h = mobo_thickness + 0.02, r = 2.5);
                }
                translate([ screw_row_0_to_top, 
                            screw_col_2_to_back, 
                            0 - 0.01 ]) {
                    cylinder(h = mobo_thickness + 0.02, r = 2.5);
                }
                translate([ screw_row_0_to_top, 
                            screw_col_3_to_back, 
                            0 - 0.01 ]) {
                    cylinder(h = mobo_thickness + 0.02, r = 2.5);
                }

                translate([ screw_row_1_to_top, 
                            screw_col_0_to_back, 
                            0 - 0.01 ]) {
                    cylinder(h = mobo_thickness + 0.02, r = 2.5);
                }
                translate([ screw_row_1_to_top, 
                            screw_col_1_to_back, 
                            0 - 0.01 ]) {
                    cylinder(h = mobo_thickness + 0.02, r = 2.5);
                }
                translate([ screw_row_1_to_top, 
                            screw_col_2_to_back, 
                            0 - 0.01 ]) {
                    cylinder(h = mobo_thickness + 0.02, r = 2.5);
                }
                translate([ screw_row_1_to_top, 
                            screw_col_3_to_back, 
                            0 - 0.01 ]) {
                    cylinder(h = mobo_thickness + 0.02, r = 2.5);
                }

                translate([ screw_row_1_5_to_top, 
                            screw_col_0_to_back, 
                            0 - 0.01 ]) {
                    cylinder(h = mobo_thickness + 0.02, r = 2.5);
                }
                if (form_factor == "mATX") {
                    translate([ screw_row_1_5_to_top, 
                                screw_col_1_to_back, 
                                0 - 0.01 ]) {
                        cylinder(h = mobo_thickness + 0.02, r = 2.5);
                    }
                }

                if (form_factor == "mATX") {
                    translate([screw_row_1_m_to_top, 
                               screw_col_1_to_back, 
                               0 - 0.01 ]) {
                        cylinder(h = mobo_thickness + 0.02, r = 2.5);
                    }
                }

                translate([ screw_row_2_to_top, 
                            screw_col_0_to_back, 
                            0 - 0.01 ]) {
                    cylinder(h = mobo_thickness + 0.02, r = 2.5);
                }
                translate([ screw_row_2_to_top, 
                            screw_col_1_to_back, 
                            0 - 0.01 ]) {
                    cylinder(h = mobo_thickness + 0.02, r = 2.5);
                }
                translate([ screw_row_2_to_top, 
                            screw_col_2_to_back, 
                            0 - 0.01 ]) {
                    cylinder(h = mobo_thickness + 0.02, r = 2.5);
                }
                translate([ screw_row_2_to_top, 
                            screw_col_3_to_back, 
                            0 - 0.01 ]) {
                    cylinder(h = mobo_thickness + 0.02, r = 2.5);
                }
            }
        }
    }

    module pcie16x() {
        slot_width = 1.6;
        slot_depth = 7.6;

        module slot() {
            difference() {
                cube([ 7.2, 89, 11 ]);
                translate(
                    [ (7.2 - slot_width) / 2, 2, 11 - slot_depth - 0.01 ]) {
                    cube([ slot_width, 11.65, slot_depth + 0.02 ]);
                }
                translate(
                    [ (7.2 - slot_width) / 2, 15.35, 11 - slot_depth - 0.01 ]) {
                    cube([ slot_width, 70, slot_depth + 0.02 ]);
                }
            }
            translate([ 0, 89, 0 ]) rotate([ 90, 0, 90 ]) linear_extrude(7.2)
                polygon([
                    [ 0, 3 ], [ 0, 11 ], [ 12.625, 11 ], [ 12.625, 14.35 ],
                    [ 18.025, 16 ], [ 18.025, 5 ], [ 3, 5 ]
                ]);

            translate([ 0, 89, 7.4 ]) rotate([ 90, 0, 0 ]) linear_extrude(89)
                polygon([ [ -1.5, 0 ], [ -1.8, 0.8 ], [ 0, 3.6 ], [ 0, 0 ] ]);
        }

        translate([ -3.6, -14.5, 0 ]) color("#3F1F1F") slot();
    }

    module screws() {
        module m4screw(screw_length = 8) {
            color("#7F7F1F") union() {
                translate([ 0, 0, screw_length / 2 ]) {
                    screw_head(head_thickness = 2.4, head_diameter = 8);
                }
                screw_thread(screw_length = screw_length, thread_diameter = 4,
                             thread_pitch = 0.7, thread_flatness = 12);
            }
        }
        screw_length = 75;
        translate([ 0, 0, -screw_length / 2 + mobo_thickness ]) {
            translate([ screw_row_0_to_top, screw_row_0_col_0_to_back, 0 ]) {
                m4screw(screw_length = screw_length);
            }
            translate([ screw_row_0_to_top, screw_col_1_to_back, 0 ]) {
                m4screw(screw_length = screw_length);
            }
            if (form_factor != "mITX" && form_factor != "mDTX") {
                translate([ screw_row_0_to_top, screw_col_2_to_back, 0 ]) {
                    m4screw(screw_length = screw_length);
                }
                if (form_factor == "EATX" || form_factor == "EEB") {
                    translate([ screw_row_0_to_top, screw_col_3_to_back, 0 ]) {
                        m4screw(screw_length = screw_length);
                    }
                }
            }

            translate([ screw_row_1_to_top, screw_col_0_to_back, 0 ]) {
                m4screw(screw_length = screw_length);
            }
            translate([ screw_row_1_to_top, screw_col_1_to_back, 0 ]) {
                m4screw(screw_length = screw_length);
            }
            if (form_factor != "mITX" && form_factor != "mDTX") {
                translate([ screw_row_1_to_top, screw_col_2_to_back, 0 ]) {
                    m4screw(screw_length = screw_length);
                }
                if (form_factor == "EATX" || form_factor == "EEB") {
                    translate([ screw_row_1_to_top, screw_col_3_to_back, 0 ]) {
                        m4screw(screw_length = screw_length);
                    }
                }
            }

            if (form_factor != "mITX" && form_factor != "mDTX") {
                translate([ screw_row_1_5_to_top, screw_col_0_to_back, 0 ]) {
                    m4screw(screw_length = screw_length);
                }
                if (form_factor == "mATX") {
                    translate([ screw_row_1_5_to_top, screw_col_1_to_back, 0 ]) {
                        m4screw(screw_length = screw_length);
                    }
                }
            }

            if (form_factor == "mATX") {
                translate([ screw_row_1_m_to_top, 
                            screw_col_1_to_back, 0 ]) {
                    m4screw(screw_length = screw_length);
                }
            }

            if (form_factor != "mITX" && form_factor != "mDTX" &&
                form_factor != "mATX") {
                translate([ screw_row_2_to_top, screw_col_0_to_back, 0 ]) {
                    m4screw(screw_length = screw_length);
                }
                translate([ screw_row_2_to_top, screw_col_1_to_back, 0 ]) {
                    m4screw(screw_length = screw_length);
                }
                translate([ screw_row_2_to_top, screw_col_2_to_back, 0 ]) {
                    m4screw(screw_length = screw_length);
                }
                if (form_factor == "EATX" || form_factor == "EEB") {
                    translate([ screw_row_2_to_top, screw_col_3_to_back, 0 ]) {
                        m4screw(screw_length = screw_length);
                    }
                }
            }
        }
    }

    module ddr4_dimm() {
        color("#3F1F1F") cube([142, 6.5, 6]);
        color("#3F1F1F") cube([6.5, 6.5, 19]);
        translate([142 - 6.5, 0, 0]) color("#3F1F1F") cube([6.5, 6.5, 19]);
        translate([(142 - 133.35) / 2, 2.55, 2.50]) {
            color("#7F7FFF") cube([133.35, 1.4, 35]);
        }
    }

    module cpu() {
        module mos_array() { 
            choke_y = 7.8;
            choke_space = 0.2;
            mos_x = 5.7;
            mos_y = 4.8;
            mos_t = 0.8;
            mos_space = 0.2;
            intersection() {
                rotate([ 0, 0, 0 ]) {
                    lineup(14, choke_y + choke_space, true) {
                        color("#3F3F3F") %cube([ mos_x, mos_y, mos_t ]);
                    }
                }
            }            
        }
        module choke_array() {
            choke_x = 10.1;
            choke_y = 7.8;
            choke_t = 4.8;
            choke_space = 0.2;
            translate([ 0, 0, 0 ]) {
                rotate([ 0, 0, 0 ]) {
                    lineup(14, choke_y + choke_space, true) {
                        color("#8F8F8F") cube([ choke_x, choke_y, choke_t ]);
                    }
                }
            }
        }
        module cap_array(count) {
            cap_d = 11;
            cap_t = 7.8;
            cap_space = 1;
            translate([ 0, 0, 0 ]) {
                rotate([ 0, 0, 0 ]) {
                    lineup(count, cap_d + cap_space, true) {
                        color("#AFAFAF") cylinder(h=cap_t, d=cap_d);
                    }
                }
            }
        }
        module flat_cpu() {
            difference() {
                union() {
                    polygon([
                        [0, 7],
                        [12, 27],
                        [12, 67],
                        [0, 87],
                        [7, 94],
                        [27, 82],
                        [67, 82],
                        [87, 94],
                        [94, 87],
                        [82, 67],
                        [82, 27],
                        [94, 7],
                        [87, 0],
                        [67, 12],
                        [27, 12],
                        [7, 0]
                    ]);
                    translate([3.5, 3.5]) circle(d=7 * sqrt(2));
                    translate([90.5, 90.5]) circle(d=7 * sqrt(2));
                    translate([90.5, 3.5]) circle(d=7 * sqrt(2));
                    translate([3.5, 90.5]) circle(d=7 * sqrt(2));
                }
                translate([3.5, 3.5]) circle(d=4);
                translate([90.5, 90.5]) circle(d=4);
                translate([90.5, 3.5]) circle(d=4);
                translate([3.5, 90.5]) circle(d=4);
            }
        }
        translate([60, 80, mobo_thickness]) {
            color("#AFAFAF") intersection() {
                translate([0, 0, 1]) linear_extrude(7) flat_cpu();

                translate([ 47, 47, 1 ]) {
                    cylinder(h = 59/3, r1 = 59 * sqrt(2), r2 = 0);
                }
            }
            color("#AFAFAF") linear_extrude(70) flat_cpu();
            color("#AFAFAF") translate([0, 0, -mobo_thickness - 3]) linear_extrude(3) flat_cpu();
            
            translate([-44, -10, 0]) {
                mos_array();
            }
            translate([-36, -10, 0]) {
                choke_array();
            }
            translate([-18, -2.5, 0]) {
                cap_array(9);
            }
            translate([-7, 3.5 + 12 * 2, 0]) {
                cap_array(5);
            }
        }
    }

    module molex_connectors() {
        molex_x = 12.8;
        molex_y = 18;
        molex_t = 9.6;
        molex_space = 1.2;
        translate([0,40, mobo_thickness]) {
            lineup(2, molex_y + molex_space, true) {
                color("#1F1F1F") cube([molex_x, molex_y, molex_t]);
            }
        }
    }

    function pci_count(ff) = 
        (ff == "mITX") ? 1 : (
            (ff == "mDTX") ? 2 : (
                (ff == "mATX") ? 4 : 7
            )
        ) - pci_shift;

    mobo_base();
    
    pci_socket_init_pos = pci_socket_to_top + pci_shift * pci_socket_distance;
    
    translate([
        pci_socket_init_pos + pci_socket_distance * 0, pci_socket_indent,
        mobo_thickness
    ]) {
        lineup(pci_count(form_factor), pci_socket_distance) {
            pcie16x();
        };
    }

    cpu();
    
    translate([ 32, 40, mobo_thickness ]) {
        lineup(4, 7.5, r=true) {
            ddr4_dimm();
        }
    }
    translate([ 32, 40 + 30 + 112.5 + 1, mobo_thickness ]) {
        lineup(4, 7.5, r=true) {
            ddr4_dimm();
        }
    }

    if (screw) {
        screws();
    }
    molex_connectors();
}

