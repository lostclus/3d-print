bat_d=18.4;
bat_xn=3;
bat_yn=3;
bat_sp=20;
bat_hole_d=15;

body_h=5;
body_t=1;

screw_d=2.65;
screw_h=8;

ol=0.01;

include <BOSL2/std.scad>

difference() {
    cuboid(
	[bat_xn*bat_sp, bat_yn*bat_sp, body_h],
	anchor=BOTTOM,
	rounding=bat_sp/2,
	edges="Z",
	$fn=8*bat_d
    );

    grid_copies(spacing=[bat_sp, bat_sp], n=[bat_xn, bat_yn]) {
	down(ol)
	    cyl(
		d=bat_hole_d,
		h=body_h+2*ol,
		anchor=BOTTOM,
		$fn=8*bat_hole_d
	    );
	up(body_t)
	    cyl(
		d=bat_d,
		h=body_h-body_t+ol,
		anchor=BOTTOM,
		rounding2=-body_t/2,
		$fn=8*bat_d
	    );
    }

    yflip_copy()
	up(body_h/2) fwd(bat_yn*bat_sp/2+ol)
	    xcopies(spacing=bat_sp, n=bat_xn-1)
		xrot(90)
		    cyl(
			d=screw_d,
			h=screw_h+ol,
			anchor=TOP,
			chamfer1=screw_d/2,
			$fn=16*screw_d
		    );
}
