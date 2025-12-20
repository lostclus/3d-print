include <BOSL2/std.scad>

hole_distance_x=20;
hole_distance_y=15;
hole1_d=2.5;
hole2_d=1.8;

body_w=26;
body_l=21;
body_h=5;
body_r=1.75;
body_t=4.5;
ol=0.01;

difference() {
    cuboid(
	[body_w, body_l, body_h],
	rounding=body_r,
	except=[BOTTOM+FRONT, BOTTOM+LEFT, BOTTOM+RIGHT, TOP+BACK],
	$fn=12*body_r
    );
    cuboid(
	[body_w-2*body_t, body_l-2*body_t, body_h+2*ol],
	rounding=body_r,
	edges="Z",
	$fn=12*body_r
    );

    fwd(hole_distance_y/2)
        xcopies(spacing=hole_distance_x, n=2)
	    cyl(
		d=hole1_d,
		h=body_h+2*ol,
		$fn=12*hole1_d
	    );
    back(hole_distance_y/2)
        xcopies(spacing=hole_distance_x, n=2)
	    cyl(
		d=hole2_d,
		h=body_h+2*ol,
		$fn=12*hole2_d
	    );

}
