// servo info
s_padding = 0.7; // total

// measured
s_w = 12.5;
s_d = 22.5 + s_padding;
s_h = 22.5 + s_padding;
s_top_to_flange = 4;
s_flange=2.2;
s_bulge_d=14.6;
s_bulge_small_d = 5.6;

// desired

base_w=80;
base_d=30;
base_h=30;
face_r=45;
t=2.5;
face_a=80; // from vertical

// calculated
// (base_w/2)^2 + (fcfb)^2 = face_r^2
face_c_h = sqrt(face_r^2 - (base_w/2)^2);

// servo cutout is rectanlge, s_d wide and s_h high
// center of axle will be (s_w/2) to the right

$fn=390;
$fs=1;
$fa=0.04;

module face() {
    difference() {
                        cylinder(h=t,r=face_r);
                        translate([-face_r,-face_r,-0.01]) cube([2*face_r,face_r-face_c_h,t+0.02]);
           translate([-s_w/2,-s_w/2,-0.01]) cube([s_d,s_w,t+0.02]);
                    }
}

module final() {
    difference() {
        union () {
            cube([base_w,base_d,base_h]);
            
            translate([base_w/2,face_c_h*cos(face_a),base_h+face_c_h*sin(face_a)])
                rotate([face_a,0,0])
                    translate([0,0,-t])
                        face();
        }
        translate([t,t,t]) cube([base_w-2*t,base_d-2*t,base_h-t+0.01]);
    }
}

final();
// test
/*
intersection() {
    
face();
    translate([-s_w/2-2,-s_w/2-2]) cube([s_d+4,s_w+4,10]);
}
*/