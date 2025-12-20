wheel_base=150;
standoff_h=60;
standoff_d=20;
body_w=20;
body_t=2;
ol=0.01;

include <BOSL2/std.scad>

zrot_copies([0, 90])
    cuboid(
	[wheel_base, body_w, body_t],
	anchor=BOTTOM
    );

zrot_copies(n=4, r=wheel_base/2)
    difference() {
	cyl(
	    d=standoff_d,
	    h=standoff_h,
	    anchor=BOTTOM,
	    $fn=8*standoff_d
	);
	up(standoff_h+ol)
	    cyl(
		d1=2,
		d2=standoff_d-2,
		h=2,
		anchor=TOP,
		$fn=8*standoff_d
	    );
    }
