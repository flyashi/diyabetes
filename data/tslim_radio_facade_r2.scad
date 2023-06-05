p_w=58;
p_h=86;
p_d=20;

p_corner_r=10;
p_in_corner_r=4;
//p_back_r=5;
r_h=130;

front_bottom_r=5;

t=2;
ant_inset=8;
ant_r=7;
ant_h=30;

knob_inset=10;
knob_r=5;
knob_h=7;

num_grooves = 6;
groove_r=2;
groove_d=1.5;
groove_start=2;
        
phi = 30;

ant_back_cutout_w=10;

btn_x_inset=30;
btn_h=20;
btn_max_z=14;

n_speakers = 10;
speaker_inset=10;
speaker_bottom=10;
speaker_h=1;
speaker_d=0.5;
speaker_spacing=1.5;

r_w=p_w + 2 * t;
r_d = p_d + t;


$fn=40;

difference() {
    union() {
        // body
        /* rev 1 
        hull() {
            translate([p_corner_r+t,p_corner_r+t,0]) cylinder(h=r_d,r=p_corner_r+t);
            translate([r_w-p_corner_r-t,p_corner_r+t,0]) cylinder(h=r_d,r=p_corner_r+t);
            translate([p_corner_r+t,r_h-p_corner_r-t,0]) cylinder(h=r_d,r=p_corner_r+t);
            translate([r_w-p_corner_r-t,r_h-p_corner_r-t,0]) cylinder(h=r_d,r=p_corner_r+t);
        } */
        /* rev 2 */
        intersection() {
            hull () {
        translate([p_corner_r+t,p_corner_r+t,0]) cylinder(h=r_d,r=p_corner_r+t);
            translate([r_w-p_corner_r-t,p_corner_r+t,0]) cylinder(h=r_d,r=p_corner_r+t);
            translate([p_corner_r+t,r_h-p_corner_r-t,0]) cylinder(h=r_d,r=p_corner_r+t);
            translate([r_w-p_corner_r-t,r_h-p_corner_r-t,0]) cylinder(h=r_d,r=p_corner_r+t);
            }
            cube([r_w,p_h+2*t,r_d]);
        }
        intersection() {
            hull() {
                translate([p_corner_r+t,p_corner_r+t,0]) cylinder(h=r_d-front_bottom_r,r=p_corner_r+t);
                translate([r_w-p_corner_r-t,p_corner_r+t,0]) cylinder(h=r_d-front_bottom_r,r=p_corner_r+t);
                translate([front_bottom_r,r_h-front_bottom_r,0]) cylinder(h=r_d-front_bottom_r,r=front_bottom_r);
                translate([r_w-front_bottom_r,r_h-front_bottom_r,0]) cylinder(h=r_d-front_bottom_r,r=front_bottom_r);
                translate([front_bottom_r,r_h-front_bottom_r,r_d-front_bottom_r])sphere(r=front_bottom_r);
                translate([r_w-front_bottom_r,r_h-front_bottom_r,r_d-front_bottom_r])sphere(r=front_bottom_r);
                translate([front_bottom_r,front_bottom_r,r_d-front_bottom_r])sphere(r=front_bottom_r);
                translate([r_w-front_bottom_r,front_bottom_r,r_d-front_bottom_r])sphere(r=front_bottom_r);
            }
            translate([0,p_h+2*t,-0.001]) cube(1000);
        }
        // antenna
        hull() {
            translate([ant_inset+ant_r,0,(r_d/2)]) sphere(ant_r);
            translate([ant_inset+ant_r,-ant_h,r_d/2]) sphere(ant_r);
        }
        // knob
        hull() {
            translate([r_w-knob_inset-knob_r,0,(r_d/2)]) sphere(knob_r);
            translate([r_w-knob_inset-knob_r,-knob_h,r_d/2]) sphere(knob_r);
        }
    }
    // hull out radio - top
    hull() {
            translate([p_corner_r+t,p_corner_r+t,-0.001]) cylinder(h=p_d,r=p_corner_r);
            translate([r_w-p_corner_r-t,p_corner_r+t,-0.001]) cylinder(h=p_d,r=p_corner_r);
            translate([t,p_h+t,-0.001]) cylinder(h=p_d,r=0.001);
            translate([r_w-t,p_h+t,-0.001]) cylinder(h=p_d,r=0.001);
    }
    // hull out radio - bottom
    intersection() {
        hull() {
                translate([t,p_h+2*t,-0.001]) cylinder(h=r_d-front_bottom_r,r=0.001);
                translate([r_w-t,p_h+2*t,-0.001]) cylinder(h=r_d-front_bottom_r,r=0.001);
                translate([front_bottom_r,r_h-front_bottom_r,-0.001]) cylinder(h=r_d-front_bottom_r,r=front_bottom_r-t);
                translate([r_w-front_bottom_r,r_h-front_bottom_r,-0.001]) cylinder(h=r_d-front_bottom_r,r=front_bottom_r-t);
                translate([front_bottom_r,r_h-front_bottom_r,r_d-front_bottom_r])sphere(r=front_bottom_r-t);
                translate([r_w-front_bottom_r,r_h-front_bottom_r,r_d-front_bottom_r])sphere(r=front_bottom_r-t);
                translate([front_bottom_r,p_h+2*t,r_d-front_bottom_r])sphere(r=front_bottom_r-t);
                translate([r_w-front_bottom_r,p_h+2*t,r_d-front_bottom_r])sphere(r=front_bottom_r-t);
            }
            translate([0,p_h+2*t,-0.001]) cube(1000);
    }

    // cut out back part of antenna
    translate([ant_inset+(ant_r-ant_back_cutout_w/2),-ant_h,-0.001]) cube([ant_back_cutout_w,ant_h+t+5,r_d/2]);
    
    // cut out inside of antenna
    hull() {
        translate([ant_inset+ant_r,10,(r_d/2)]) sphere(ant_r-t);
        translate([ant_inset+ant_r,-ant_h,r_d/2]) sphere(ant_r-t);
    }
    
    // grooves on the knob
    for (i = [0:num_grooves]) {

        dx = cos(i * 360 / num_grooves + phi) * (knob_r + groove_r - groove_d);
        dy = sin(i * 360 / num_grooves + phi) * (knob_r + groove_r - groove_d);
        rotate([90,0,0]) translate([r_w-knob_inset-knob_r+dx,r_d/2 + dy,groove_start+groove_r])cylinder(h=100,r=groove_r);
        translate([r_w-knob_inset-knob_r+dx,-groove_start-groove_r,r_d/2 + dy]) sphere(groove_r);
    }
    // screen
    hull() {
            translate([p_corner_r+t,p_corner_r+t,-0.001]) cylinder(h=100,r=p_in_corner_r);
            translate([r_w-p_corner_r-t,p_corner_r+t,-0.001]) cylinder(h=100,r=p_in_corner_r);
            translate([p_corner_r+t,t+p_h-p_corner_r-t,-0.001]) cylinder(h=100,r=p_in_corner_r);
            translate([r_w-p_corner_r-t,t+p_h-p_corner_r-t,-0.001]) cylinder(h=100,r=p_in_corner_r);
    }
    translate([r_w-t-0.001,t+btn_x_inset,-0.001]) cube([t+0.002,btn_h,btn_max_z+t]);
    // "speaker" cutouts
    for(i=[0:n_speakers]) {
        translate([speaker_inset,r_h-speaker_bottom-i*speaker_h-i*speaker_spacing,r_d-speaker_d]) cube([r_w-2*speaker_inset,speaker_h,speaker_d+0.001]);
    }
}
