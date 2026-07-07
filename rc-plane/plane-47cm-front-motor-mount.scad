body_d=21.5;
body_h=12.0;
body_t=1.5;
leg_l=5;
leg_w=8;
leg_t=1;
leg_hole_d=2.1;
leg_hole_dx=26.5;
motor_hole_d=2.1;
motor_hole_dx=2*5.77;
center_hole_d=5;
ol=0.01;

include <BOSL2/std.scad>

difference() {
    union() {
	cyl(
	    d=body_d,
	    h=body_h,
	    anchor=BOTTOM,
	    $fn=16*body_d
	);
	zrot_copies([0, 90])
	    difference() {
		intersection() {
		    cyl(
			d1=body_d+2*leg_l,
			d2=body_d,
			h=body_h,
			anchor=BOTTOM,
			$fn=16*body_d
		    );
		    cuboid(
			[leg_w, body_d+2*leg_l, body_h],
			anchor=BOTTOM
		    );
		}
		up(leg_t)
		    cuboid(
			[leg_w-2*leg_t, body_d+2*leg_l+2*ol, body_h],
			anchor=BOTTOM
		    );
	    }
    }
    down(ol)
	cyl(
	    d=body_d-body_t*2,
	    h=body_h-body_t+ol,
	    anchor=BOTTOM,
	    $fn=16*body_d
	);
    down(ol)
	zrot_copies(n=4, d=leg_hole_dx)
	    cyl(
		d=leg_hole_d,
		h=leg_t+2*ol,
		anchor=BOTTOM,
		$fn=16*leg_hole_d
	    );
    up(body_h+ol) {
	zrot_copies(n=3, d=motor_hole_dx)
	    cyl(
		d=motor_hole_d,
		h=body_t+2*ol,
		anchor=TOP,
		$fn=16*motor_hole_d
	    );
	cyl(
	    d=center_hole_d,
	    h=body_t+2*ol,
	    anchor=TOP,
	    $fn=16*center_hole_d
	);
    }
}
