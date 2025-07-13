include <hw-851-case-common.scad>

body_h=6.5;

pcb_standoff_a_o_d=3.4;
pcb_standoff_a_i_d=2.0;
pcb_standoff_b_o_d=5.0;
pcb_standoff_b_i_d=2.8;
pcb_standoff_chamfer=0.9;
pcb_standoff_head_d_k=1.8;
pcb_standoff_head_h_k=0.3;
pcb_standoff_h=body_h-body_t-case_joiner_h-pcb_h;

include <BOSL2/std.scad>

difference() {
    union() {
	difference() {
	    union() {
		cuboid(
		    [
			body_w-body_t-2*case_joiner_tolerance,
			body_l-body_t-2*case_joiner_tolerance,
			body_h
		    ],
		    anchor=BOTTOM,
		    rounding=body_r,
		    except=TOP,
		    $fn=32*body_t
		);
		cuboid(
		    [body_w, body_l, body_h-case_joiner_h],
		    anchor=BOTTOM,
		    rounding=body_r,
		    except=TOP,
		    $fn=32*body_t
		);
	    }

	    up(body_t)
		cuboid(
		    [body_w-2*body_t, body_l-2*body_t, body_h-body_t+2*ol],
		    anchor=BOTTOM,
		    rounding=body_r,
		    except=TOP,
		    $fn=32*body_t
		);
	}

	up(body_t-ol) {
	    back(pcb_hole_a_dy)
		xcopies(spacing=pcb_hole_a_sx, n=2)
		    cyl(
			d=pcb_standoff_a_o_d,
			h=pcb_standoff_h+ol,
			anchor=BOTTOM,
			rounding1=-0.25*pcb_standoff_a_o_d,
			$fn=16*pcb_standoff_a_o_d
		    );
	    fwd(pcb_hole_b_dy)
		cyl(
		    d=pcb_standoff_b_o_d,
		    h=pcb_standoff_h+ol,
		    anchor=BOTTOM,
		    rounding1=-0.25*pcb_standoff_b_o_d,
		    $fn=16*pcb_standoff_b_o_d
		);
	}
    }

    down(ol) {
	back(pcb_hole_a_dy)
	    xcopies(spacing=pcb_hole_a_sx, n=2) {
		cyl(
		    d=pcb_standoff_a_i_d,
		    h=body_t+pcb_standoff_h+2*ol,
		    anchor=BOTTOM,
		    $fn=16*pcb_standoff_a_i_d
		);
		cyl(
		    d=pcb_standoff_a_i_d*pcb_standoff_head_d_k,
		    h=pcb_standoff_a_i_d*pcb_standoff_head_h_k,
		    anchor=BOTTOM,
		    $fn=16*pcb_standoff_a_i_d
		);
		up(pcb_standoff_a_i_d*pcb_standoff_head_h_k-ol)
		    cyl(
			d1=pcb_standoff_a_i_d*pcb_standoff_head_d_k,
			d2=pcb_standoff_a_i_d,
			h=pcb_standoff_a_i_d*pcb_standoff_head_h_k*0.75,
			anchor=BOTTOM,
			$fn=16*pcb_standoff_a_i_d
		    );
	    }
	fwd(pcb_hole_b_dy) {
	    cyl(
		d=pcb_standoff_b_i_d,
		h=body_t+pcb_standoff_h+2*ol,
		anchor=BOTTOM,
		$fn=16*pcb_standoff_b_i_d
	    );
	    cyl(
		d=pcb_standoff_b_i_d*pcb_standoff_head_d_k,
		h=pcb_standoff_b_i_d*pcb_standoff_head_h_k,
		anchor=BOTTOM,
		$fn=16*pcb_standoff_b_i_d
	    );
	    up(pcb_standoff_b_i_d*pcb_standoff_head_h_k-ol)
		cyl(
		    d1=pcb_standoff_b_i_d*pcb_standoff_head_d_k,
		    d2=pcb_standoff_b_i_d,
		    h=pcb_standoff_b_i_d*pcb_standoff_head_h_k*0.75,
		    anchor=BOTTOM,
		    $fn=16*pcb_standoff_b_i_d
		);
	}
    }

    up(body_t+pcb_standoff_h+0.75*pcb_h) {
	fwd(body_l/2-body_t-ol) 
	    xcopies(spacing=usb_sp, n=2)
		cuboid(
		    [usb_w, body_t+2*ol, usb_h],
		    anchor=BOTTOM+BACK
		);
	back(body_l/2-body_t-ol)
	    right(in_conn_dx)
		cuboid(
		    [in_conn_w, body_t+2*ol, in_conn_h],
		    anchor=BOTTOM+FRONT
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
