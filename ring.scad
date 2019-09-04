$fn=100;

$diameter = 145;
$thickness = 30;

$mount_width = 60;
$mount_height = 20;
$clamp_width = 30;
$clamp_hight = 20;

$spacing = 2;
$rounding = 2;


difference() {
    union() {
        // main structure
        cylinder($thickness,$diameter/2+10,$diameter/2+10, true);
        // mount
        translate([0,$diameter/2+5,0]) cube([$mount_width,$mount_height,$thickness], true);
        translate([0,-$diameter/2-5,0]) cube([$mount_width,$mount_height,$thickness], true);
        // clamps
        translate([$diameter/2+$clamp_width/2,0,0]) cube([$clamp_width,$clamp_hight+$spacing,$thickness], true);
        translate([-$diameter/2-$clamp_width/2,0,0]) cube([$clamp_width,$clamp_hight+$spacing,$thickness], true);
    }
    // hole in the middle
    cylinder($thickness+2,$diameter/2,$diameter/2, true);
    
    // space for clamping ring together
    translate([$diameter/2+$clamp_width/2,0,0]) cube([$clamp_width*2,$spacing,$thickness+2], true);
    translate([-$diameter/2-$clamp_width/2,0,0]) cube([$clamp_width*2,$spacing,$thickness+2], true);
    
    // holes for screws
    translate([$diameter/2+20,0,0]) rotate([90,0,0]) cylinder(100,3,3, true);
    translate([-$diameter/2-20,0,0]) rotate([90,0,0]) cylinder(100,3,3, true);
    rotate([90,0,0]) cylinder($diameter*2,3,3, true);
    rotate([90,0,0]) cylinder($diameter+10,8,8, true);

    // smooth edges inside
    translate([-$diameter/2-$spacing*0.95,3,0])  roundCorner();
    translate([-$diameter/2-$spacing*0.95,-3,0])  rotate([0,0,90]) roundCorner();
    translate([$diameter/2+$spacing*0.95,-3,0])  rotate([0,0,180]) roundCorner();
    translate([$diameter/2+$spacing*0.95,3,0])  rotate([0,0,270]) roundCorner();

    // smooth edges clamps
    translate([28+$diameter/2,-3,0])  rotate([0,0,90]) roundCorner();
    translate([28+$diameter/2,3,0])  rotate([0,0,0]) roundCorner();
    translate([28+$diameter/2,-8,0])  rotate([0,0,0]) roundCorner();
    translate([28+$diameter/2,8,0])  rotate([0,0,90]) roundCorner();
    
    translate([-28-$diameter/2,3,0])  rotate([0,0,270]) roundCorner();
    translate([-28-$diameter/2,-3,0])  rotate([0,0,180]) roundCorner();
    translate([-28-$diameter/2,8,0])  rotate([0,0,180]) roundCorner();
    translate([-28-$diameter/2,-8,0])  rotate([0,0,270]) roundCorner();
    
    // smooth edges mount
    translate([28,13+$diameter/2,0])  rotate([0,0,90]) roundCorner();
    translate([-28,13+$diameter/2,0])  rotate([0,0,180]) roundCorner();
    translate([-28,-13-$diameter/2,0])  rotate([0,0,270]) roundCorner();
    translate([28,-13-$diameter/2,0])  rotate([0,0,0]) roundCorner();

    // remove one half
    translate([0,$diameter/2,0]) cube([$diameter*2+$clamp_width*2,$diameter,$thickness*2], true);
}

module roundCorner() {
    difference() {
        translate([$rounding,-$rounding,0]) cube([$rounding*2,$rounding*2,$thickness+2], true);
        cylinder($thickness+4,$rounding,$rounding, true);
    }
}

