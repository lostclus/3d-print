body_w=14;
body_l=8.0;
body_h=9.5;
body_r=1;
cam_w=11;
cam_h=8;
cam_l=5.25;
cam_back_w=5.75;
cam_back_l=4.5;
lens_d=8;
lens_w2=7;
lens_z=6.9;
hole_d=1.75;
hole_y=3.2;
hole_z=6.7;
ol=0.01;

include <BOSL2/std.scad>

difference() {
    cuboid(
	[body_w, body_l, body_h],
	anchor=BOTTOM,
	rounding=body_r,
	$fn=32*body_r
    );
    up(body_h+ol)
	cuboid([cam_w, cam_l, cam_h+ol], anchor=TOP);
    up(lens_z)
	fwd(body_l/2+ol)
	    ycyl(
		d=lens_d,
		h=0.5*body_l,
		anchor=FRONT,
		$fn=8*lens_d
	    );
    up(body_h+ol)
	fwd(body_l/2+ol)
	    cuboid(
		[lens_w2, 0.5*body_l, 0.5*lens_d],
		anchor=FRONT+TOP
	    );


    down(ol)
	back(body_l/2+ol)
	    cuboid(
		[cam_back_w, cam_back_l+ol, body_h+2*ol],
		anchor=BOTTOM+BACK
	    );
    up(hole_z)
	fwd(body_l/2-hole_y)
	xcyl(
	    d=hole_d,
	    h=body_w+2*ol,
	    $fn=16*hole_d
	);
}
