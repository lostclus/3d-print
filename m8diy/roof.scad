body_t=1.4;
body_r=2.4;

standoff1_hole_sp=20;
standoff1_hole_d=1.77;
standoff1_hole_bot_d=2.65;
standoff1_hole_bot_h=0.75;
standoff1_hole_top_d=3.4;
standoff1_hole_top_h=0.4;

standoff2_sp=16;
standoff2_d=2.5;
standoff2_h=7.5;
standoff2_r=0.5;
standoff2_hole_d=1.1;
standoff2_hole_h=4;

grid_strut=0.45;
grid_spacing=2.75;

ol=0.01;

include <BOSL2/std.scad>
include <BOSL2/walls.scad>

difference() {
    union() {
	zrot_copies([0, 90, 180])
	    left(standoff1_hole_sp/2)
		cuboid(
		    [2*body_r, standoff1_hole_sp+2*body_r, body_t],
		    anchor=BOTTOM,
		    rounding=body_r,
		    edges="Z",
		    $fn=16*body_r
		);
	grid_copies(spacing=[standoff1_hole_sp, standoff1_hole_sp], n=[2, 2])
	    up(body_t-ol)
		cyl(
		    d=standoff1_hole_top_d,
		    h=standoff1_hole_top_h,
		    anchor=BOTTOM,
		    rounding2=standoff1_hole_top_h/2,
		    $fn=16*standoff1_hole_top_d
		);
    }

    grid_copies(spacing=[standoff1_hole_sp, standoff1_hole_sp], n=[2, 2]) {
        down(ol) {
	    up(standoff1_hole_bot_h)
	    cyl(
		d=standoff1_hole_d,
		h=body_t+standoff1_hole_top_h-standoff1_hole_bot_h+ol,
		anchor=BOTTOM,
		chamfer1=-(standoff1_hole_bot_d-standoff1_hole_d)/2,
		$fn=32*standoff1_hole_d
	    );
	    cyl(
		d=standoff1_hole_bot_d,
		h=standoff1_hole_bot_h+ol,
		anchor=BOTTOM,
		rounding1=-0.4*standoff1_hole_bot_h,
		$fn=32*standoff1_hole_bot_d
	    );
	}
    }
}

hex_panel(
    [
	standoff1_hole_sp-2*body_r+2*grid_strut,
	standoff1_hole_sp-2*body_r+2*grid_strut,
	body_t
    ],
    anchor=BOTTOM,
    strut=grid_strut,
    spacing=grid_spacing
);

zrot_copies([0, 90, 180])
    left(sqrt(2*pow(standoff2_sp, 2))/2)
	difference() {
	    union() {
		cyl(
		    d=standoff2_d+2*standoff2_r,
		    h=body_t,
		    anchor=BOTTOM,
		    $fn=32*standoff2_d
		);
		up(body_t-ol)
		    cyl(
			d=standoff2_d,
			h=standoff2_h,
			anchor=BOTTOM,
			rounding1=-standoff2_r,
			$fn=16*standoff2_d
		    );
	    }
	    up(body_t+standoff2_h+ol)
		cyl(
		    d=standoff2_hole_d,
		    h=standoff2_hole_h,
		    anchor=TOP,
		    $fn=16*standoff2_hole_d
		);
	    left(standoff2_d/2)
		down(ol)
		    cuboid(
			[
			    standoff2_r,
			    standoff2_d,
			    body_t+standoff2_r+ol
			],
			anchor=BOTTOM+RIGHT
		    );
	}
