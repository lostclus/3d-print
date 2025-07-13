include <hw-851-case-common.scad>

body_h=19;

pcb_standoff_h=body_h-body_t;
pcb_standoff_a_o_d=3.2;
pcb_standoff_a_i_d=1.5;
pcb_standoff_b_o_d=5.0;
pcb_standoff_b_i_d=2.2;
pcb_standoff_i_h=8;
pcb_standoff_base_h=8;

include <BOSL2/std.scad>

difference() {
    difference() {
	cuboid(
	    [body_w, body_l, body_h],
	    anchor=BOTTOM,
	    rounding=body_r,
	    except=TOP,
	    $fn=32*body_t
	);

	up(body_h+ol)
	    cuboid(
		[
		    body_w-body_t+2*case_joiner_tolerance,
		    body_l-body_t+2*case_joiner_tolerance,
		    case_joiner_h+ol
		],
		anchor=TOP,
		rounding=body_r,
		edges="Z",
		$fn=32*body_t
	    );

	up(body_t)
	    difference() {
		cuboid(
		    [body_w-2*body_t, body_l-2*body_t, body_h-body_t+2*ol],
		    anchor=BOTTOM,
		    rounding=body_r,
		    except=TOP,
		    $fn=32*body_t
		);

	    }
	}

    up(body_t+pcb_standoff_h+ol) {
	fwd(body_l/2+ol) 
	    xcopies(spacing=usb_sp, n=2)
		cuboid(
		    [usb_w, 2*body_t+2*ol, usb_h],
		    anchor=TOP+FRONT
		);
	back(body_l/2+ol)
	    left(in_conn_dx)
		cuboid(
		    [in_conn_w, body_t+2*ol, in_conn_h],
		    anchor=TOP+BACK
		);
    }

    down(ol)
	back(radiation_dy)
	    xcopies(spacing=radiation_sp, l=radiation_w)
		cuboid(
		    [radiation_t, radiation_l, body_t+2*ol],
		    anchor=BOTTOM
		);
}

xflip_copy()
    difference() {
	union() {
	    left(body_w/2-body_t+ol)
		back(pcb_hole_a_dy)
		    cuboid(
			[
			    (body_w-pcb_hole_a_sx)/2-body_t+pcb_standoff_a_o_d/2,
			    pcb_standoff_a_o_d,
			    pcb_standoff_base_h
			],
			anchor=BOTTOM+LEFT,
			rounding=pcb_standoff_a_o_d/2,
			edges="Z",
			except=LEFT,
			$fn=16*pcb_standoff_a_o_d
		    );
	    up(body_t-ol)
		left(pcb_hole_a_sx/2)
		    back(pcb_hole_a_dy)
			cyl(
			    d=pcb_standoff_a_o_d,
			    h=pcb_standoff_h+ol,
			    anchor=BOTTOM,
			    rounding1=-body_t,
			    $fn=16*pcb_standoff_a_o_d
			);
	}
	left(pcb_hole_a_sx/2)
	    back(pcb_hole_a_dy)
		up(body_t+pcb_standoff_h+ol)
		    cyl(
			d=pcb_standoff_a_i_d,
			h=pcb_standoff_i_h+ol,
			anchor=TOP,
			chamfer1=pcb_standoff_a_i_d/2,
			$fn=16*pcb_standoff_a_i_d
		    );
    }

fwd(pcb_hole_b_dy)
    difference() {
	up(body_t-ol)
	    cyl(
		d=pcb_standoff_b_o_d,
		h=pcb_standoff_h+ol,
		anchor=BOTTOM,
		rounding1=-body_t,
		$fn=16*pcb_standoff_b_o_d
	    );
	up(body_t+pcb_standoff_h+ol)
	    cyl(
		d=pcb_standoff_b_i_d,
		h=pcb_standoff_i_h+ol,
		anchor=TOP,
		chamfer1=pcb_standoff_b_i_d/2,
		$fn=16*pcb_standoff_b_i_d
	    );
    }
