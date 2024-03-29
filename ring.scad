$fn=100;

$diameter = 140;
$height = 30;
$thickness = 10;

$mount_width = 60;
$mount_height = 20;
$clamp_width = 30;
$clamp_height = 10;

$spacing = 2;
$rounding = 2;


difference() {
    union() {
        // main structure
        cylinder($height,$diameter/2+$thickness,$diameter/2+$thickness, true);
        // mount
        translate([0,-$diameter/2-$mount_height/2,0]) cube([$mount_width,$mount_height,$height], true);
        // clamps
        translate([$diameter/2+$clamp_width/2,-$clamp_height/2-$spacing/2,0]) cube([$clamp_width,$clamp_height,$height], true);
        translate([-$diameter/2-$clamp_width/2,-$clamp_height/2-$spacing/2,0]) cube([$clamp_width,$clamp_height,$height], true);
    }
    // hole in the middle
    cylinder($height+2,$diameter/2,$diameter/2, true);
    
    // space for clamping ring together
    translate([$diameter/2+$clamp_width/2,0,0]) cube([$clamp_width*2,$spacing,$height+2], true);
    translate([-$diameter/2-$clamp_width/2,0,0]) cube([$clamp_width*2,$spacing,$height+2], true);
    
    // holes for screws
    translate([$diameter/2+20,0,0]) rotate([90,0,0]) cylinder(100,3,3, true);
    translate([-$diameter/2-20,0,0]) rotate([90,0,0]) cylinder(100,3,3, true);
    rotate([90,0,0]) cylinder($diameter*2,3,3, true);
    rotate([90,0,0]) cylinder($diameter+$mount_height,8,8, true);

    // smooth edges inside
    translate([-$diameter/2-$rounding*0.95,-$rounding-$spacing/2,0])  rotate([0,0,90]) roundCorner();
    translate([$diameter/2+$rounding*0.95,-$rounding-$spacing/2,0])  rotate([0,0,180]) roundCorner();

    // smooth edges clamps
    translate([$clamp_width-$rounding+$diameter/2,-$rounding-$spacing/2,0])  rotate([0,0,90]) roundCorner();
    translate([$clamp_width-$rounding+$diameter/2,-$clamp_height+$rounding-$spacing/2,0])  rotate([0,0,0]) roundCorner();
    translate([-$clamp_width+$rounding-$diameter/2,-$rounding-$spacing/2,0])  rotate([0,0,180]) roundCorner();
    translate([-$clamp_width+$rounding-$diameter/2,-$clamp_height+$rounding-$spacing/2,0])  rotate([0,0,270]) roundCorner();
    
    // smooth edges mount
    translate([-$mount_width/2+$rounding,-$mount_height+$rounding-$diameter/2,0])  rotate([0,0,270]) roundCorner();
    translate([$mount_width/2-$rounding,-$mount_height+$rounding-$diameter/2,0])  rotate([0,0,0]) roundCorner();

    // remove unused half
    translate([0,$diameter/2,0]) cube([$diameter*2+$clamp_width*2,$diameter,$height*2], true);
}

module roundCorner() {
    difference() {
        translate([$rounding,-$rounding,0]) cube([$rounding*2,$rounding*2,$height+2], true);
        cylinder($height+4,$rounding,$rounding, true);
    }
}

