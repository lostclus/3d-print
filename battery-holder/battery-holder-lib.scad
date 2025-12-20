include <BOSL2/std.scad>

module battery_holder(
    bat_d=18.4,
    bat_xn=2,
    bat_yn=1,
    bat_sp=20,
    bat_hole_d=15,
    bat_r=0.6,
    body_h=5,
    body_t=0.5,
    ol=0.01
) {
    difference() {
	cuboid(
	    [bat_xn*bat_sp, bat_yn*bat_sp, body_h],
	    anchor=BOTTOM,
	    rounding=bat_sp/2,
	    edges="Z",
	    $fn=4*bat_d
	);

	grid_copies(spacing=[bat_sp, bat_sp], n=[bat_xn, bat_yn]) {
	    down(ol)
		cyl(
		    d=bat_hole_d,
		    h=body_h+2*ol,
		    anchor=BOTTOM,
		    $fn=4*bat_hole_d
		);
	    up(body_t)
		cyl(
		    d=bat_d,
		    h=body_h-body_t+ol,
		    anchor=BOTTOM,
		    rounding2=-bat_r,
		    $fn=4*bat_d
		);
	}
    }
}
