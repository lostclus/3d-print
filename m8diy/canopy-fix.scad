standoff_sp=16;
standoff_outher_d=3.5;
standoff_hole_d=1.15;
standoff_hole_top_d=2;
standoff_hole_top_h=0.7;

body_t=1.5;
body_w=1.5;
body_r=0.6;

ol=0.01;

include <BOSL2/std.scad>

difference() {
    union() {
	zrot_copies([0, 90])
	    left(standoff_sp/2) {
		cuboid(
		    [body_w, standoff_sp, body_t],
		    anchor=BOTTOM,
		    rounding=body_r,
		    edges=TOP,
		    $fn=48*body_r
		);
	    }

	zrot(45)
	    cuboid(
		[body_w, sqrt(2*pow(standoff_sp, 2)), body_t],
		anchor=BOTTOM,
		rounding=body_r,
		edges=TOP,
		$fn=48*body_r
	    );

	zrot_copies([-90, 0, 90])
	    left(standoff_sp/2)
		fwd(standoff_sp/2)
		    cyl(
			d=standoff_outher_d,
			h=body_t,
			anchor=BOTTOM,
			rounding2=body_r,
			$fn=32*standoff_outher_d
		    );
    }

    down(ol)
	zrot_copies([-90, 0, 90])
	    left(standoff_sp/2)
		fwd(standoff_sp/2) {
		    cyl(
			d=standoff_hole_d,
			h=body_t+2*ol,
			anchor=BOTTOM,
			$fn=32*standoff_hole_d
		    );
		    up(body_t+2*ol)
			cyl(
			    d=standoff_hole_top_d,
			    h=standoff_hole_top_h+ol,
			    anchor=TOP,
			    $fn=32*standoff_hole_top_d
			);
		}
}
