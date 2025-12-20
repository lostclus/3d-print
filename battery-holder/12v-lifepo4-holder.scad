bat_d=33.6;
bat_hole_d=28;

bat_xn=1;
bat_yn=4;
bat_sp_x=0;
bat_sp_y=19;
bat_offset_x=14.75;

body_h=6;
body_t=2;
body_w=65;
body_l=93;
body_r=4;

ol=0.01;

include <BOSL2/std.scad>

difference() {
    cuboid(
	[
	    //(bat_xn-1)*bat_sp_x+bat_d+2*bat_offset_x+2*body_pad,
	    body_w,
	    //(bat_yn-1)*bat_sp_y+bat_d+2*body_pad,
	    body_l,
	    body_h
	],
	anchor=BOTTOM,
	rounding=body_r,
	edges="Z",
	$fn=4*body_r
    );

    grid_copies(spacing=[bat_sp_x, bat_sp_y], n=[bat_xn, bat_yn])
	left(($row % 2 * 2 * bat_offset_x) - bat_offset_x) {
	    down(ol)
		cyl(
		    d=bat_hole_d,
		    h=body_h+2*ol,
		    anchor=BOTTOM,
		    $fn=2*bat_hole_d
		);
	    up(body_t)
		cyl(
		    d=bat_d,
		    h=body_h-body_t+ol,
		    anchor=BOTTOM,
		    rounding2=-body_t/2,
		    $fn=2*bat_d
		);
	}
}
