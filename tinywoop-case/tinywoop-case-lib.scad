include <BOSL2/std.scad>

module tinywoop_case(
    base = 65,
    prop_d = 38,
    body_w = 54,
    body_h = 65,
    body_t = 0.54,
    with_top = true,
    top_h = 8
) {
    cuboid([body_w, body_w, body_h], anchor=BOTTOM);
    zrot(45)
	arc_copies(d=base, n=4)
	    cyl(
		d=prop_d,
		h=body_h,
		anchor=BOTTOM,
		$fn=4*prop_d
	    );
    if (with_top) {
	right(base+prop_d)
	    tinywoop_case(
		base=base,
		prop_d=prop_d+2*body_t,
		body_w=body_w+2*body_t,
		body_h=top_h,
		with_top=false
	    );
    }
}
