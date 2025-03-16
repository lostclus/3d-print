include <bbp20-12-case-common.scad>

body_h=40;

case_conn_hole1_d=6.3;
case_conn_hole2_d=3.4;

pcb_w=55;
pcb_l=55;
pcb_h=36;
pcb_gap_l=6;

pcb_hole_x=50;
pcb_hole_y=50;

pcb_standoff_od=6.5;
pcb_standoff_id=4.1;
pcb_standoff_h=4.5;

bat_w=60.5;
bat_l=5.5;
bat_h=4;
bat_d=20;
bat_gap=7;

bat_sp=58;

led_d=5.2;
led_sp=12;

power_conn_w=20.8;
power_conn_h=13.0;
power_conn_hole_d=3.5;
power_conn_hole_gap=28;

out_conn_d=12.6;

back_stiffener_l=1.0;

radiation_w=0.45*body_w;
radiation_l=0.3*body_l;
radiation_sp=0.45*body_l;
radiation_hole_w=1.5;
radiation_hole_sp=3;

leg_gap=8;

include <BOSL2/std.scad>
include <BOSL2/walls.scad>

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
	        difference() {
		    cuboid(
			[body_w-2*body_t, body_l-2*body_t, body_h-body_t+2*ol],
			anchor=BOTTOM,
			rounding=body_r,
			except=TOP,
			$fn=32*body_t
		    );
		    fwd(body_l/2-body_t+ol)
			cuboid(
			    [body_w, back_stiffener_l+ol, body_h-body_t+2*ol],
			    anchor=BOTTOM+FRONT
			);
		}
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
	down(ol) left(body_w/2-body_t-case_conn_size/2)
	    ycopies(spacing=0.6*body_l, n=2) {
		cyl(
		    d=case_conn_hole1_d,
		    h=body_h-body_t+ol,
		    anchor=BOTTOM,
		    chamfer2=(case_conn_hole1_d-case_conn_hole2_d)/2,
		    $fn=8*case_conn_hole1_d
		);
		cyl(
		    d=case_conn_hole2_d,
		    h=body_h+2*ol,
		    anchor=BOTTOM,
		    $fn=8*case_conn_hole2_d
		);
	    }

    fwd(body_l/2+ol) up(0.7*body_h) left(0.15*body_w) {
	cuboid(
	    [
		power_conn_w,
		body_t+back_stiffener_l+2*ol,
		power_conn_h
	    ],
	    anchor=FRONT,
	    rounding=power_conn_h/2,
	    edges="Y",
	    $fn=4*power_conn_h
	);
	xcopies(spacing=power_conn_hole_gap, n=2)
	    xrot(90)
	    cyl(
		d=power_conn_hole_d,
		h=body_t+back_stiffener_l+2*ol,
		anchor=TOP,
		$fn=8*power_conn_hole_d
	    );
    }

    fwd(body_l/2+ol) up(0.7*body_h) right(0.25*body_w)
	xrot(90)
	    cyl(
		d=out_conn_d,
		h=body_t+back_stiffener_l+2*ol,
		anchor=TOP,
		$fn=8*out_conn_d
	    );

    back(body_l/2+ol) up(0.85*body_h)
	xrot(90)
	    xcopies(spacing=led_sp, n=3)
		cyl(
		    d=led_d,
		    h=body_t+2*ol,
		    anchor=BOTTOM,
		    $fn=8*led_d
		);
    down(ol)
	ycopies(spacing=radiation_sp, n=2)
	    xcopies(spacing=radiation_hole_sp, l=radiation_w)
		cuboid([radiation_hole_w, radiation_l, body_t+2*ol], anchor=BOTTOM);

    down(ol)
	grid_copies(
	    spacing=[body_w-2*leg_gap, body_l-2*leg_gap],
	    n=[2, 2]
	)
	    cyl(
		d=leg_joiner_d+leg_joiner_tolerance,
		h=leg_joiner_h,
		$fn=16*leg_joiner_d
	    );
}

fwd(body_l/2-pcb_l/2-body_t-pcb_gap_l) {
    grid_copies(spacing=[pcb_hole_x, pcb_hole_y], n=[2, 2])
	up(body_t-ol)
	    difference() {
		cyl(
		    d=pcb_standoff_od,
		    h=pcb_standoff_h+ol,
		    anchor=BOTTOM,
		    rounding1=-body_t,
		    $fn=16*pcb_standoff_od
		);
		cyl(
		    d=pcb_standoff_id,
		    h=pcb_standoff_h+2*ol,
		    anchor=BOTTOM,
		    $fn=16*pcb_standoff_id
		);
	    }
}

back(body_l/2-bat_sp/2-body_t-bat_l-body_t-bat_gap) up(body_t-ol)
    yflip_copy(bat_sp/2+bat_l+body_t)
	difference() {
	    cuboid(
		[body_w-2*body_t+ol, bat_l+body_t, bat_h+ol],
		anchor=BOTTOM+BACK
	    );
	    fwd(body_t)
		cuboid(
		    [bat_w, bat_l+ol, bat_d],
		    anchor=BOTTOM+BACK,
		    rounding=bat_d/2,
		    edges="Y",
		    $fn=8*bat_d
		);
	}
