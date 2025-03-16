include <bbp20-12-case-common.scad>

body_h=30;

case_conn_hole1_d=4.1;
case_conn_hole1_h=4.5;
case_conn_hole2_d=3.4;
case_conn_hole2_h=3;

radiation_w=6;
radiation_h=6;
radiation_l=0.4*body_l;
radiation_hole_w=1.5;
radiation_hole_sp=3;

include <BOSL2/std.scad>
include <BOSL2/walls.scad>

difference() {
    union() {
	difference() {
	    cuboid(
		[body_w, body_l, body_h+case_joiner_h],
		anchor=BOTTOM,
		rounding=body_r,
		except=TOP,
		$fn=32*body_t
	    );
	    up(body_t)
		cuboid(
		    [
			body_w-2*body_t,
                        body_l-2*body_t,
			body_h-body_t+2*ol
		    ],
		    anchor=BOTTOM,
		    rounding=body_r,
		    except=TOP,
		    $fn=32*body_t
		);
	    up(body_h)
		cuboid(
		    [
			body_w-body_t-case_joiner_tolerance,
                        body_l-body_t-case_joiner_tolerance,
			case_joiner_h+ol
		    ],
		    anchor=BOTTOM,
		    rounding=body_r,
		    edges="Z",
		    $fn=32*body_t
		);
	}

	xflip_copy()
	    up(body_t-ol) left(body_w/2-body_t+ol)
		ycopies(spacing=0.6*body_l, n=2)
		    cuboid(
			[case_conn_size, case_conn_size, body_h-body_t+ol],
			anchor=BOTTOM+LEFT,
			rounding=case_conn_size/2,
			edges=[RIGHT+FRONT, RIGHT+BACK],
			$fn=8*case_conn_size
		    );

    }

    xflip_copy()
	up(body_h+ol) left(body_w/2-body_t-case_conn_size/2)
	    ycopies(spacing=0.6*body_l, n=2) {
		cyl(
		    d=case_conn_hole1_d,
		    h=case_conn_hole1_h+ol,
		    anchor=TOP,
		    $fn=8*case_conn_hole1_d
		);
		cyl(
		    d=case_conn_hole2_d,
		    h=case_conn_hole1_h+case_conn_hole2_h+ol,
		    anchor=TOP,
		    $fn=8*case_conn_hole2_d
		);
	    }

    down(ol)
     xflip_copy()
	left(body_w/2+ol)
	    ycopies(spacing=radiation_hole_sp, l=radiation_l)
		cuboid(
		    [radiation_w+ol, radiation_hole_w, radiation_h+ol],
		    anchor=BOTTOM+LEFT
		);
}
