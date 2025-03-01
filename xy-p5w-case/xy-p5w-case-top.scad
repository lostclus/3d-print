include <xy-p5w-case-common.scad>

body_h=13;

pcb_standoff_h=9;
pcb_standoff_o_d=3.2;
pcb_standoff_i_d=1.4;
pcb_standoff_i_h=8;
pcb_standoff_base_h=4;

power_conn_pos_y=10.25;
power_conn_pos_z=1.75;
power_conn_size=[8, 3];
power_conn_r=0.7;

audio_out_pos_y=21.5;
audio_out_pos_z=3.0;
audio_out_size=5.5;

control_pos_y=12.0;
control_pos_z=2.25;
control_size=[11, 2.5];

other_conn_pos_y=16.5;
other_conn_pos_z=1.95;
other_conn_size=[23, 6.0];


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

		xflip_copy()
		    difference() {
			union() {
			    left(body_w/2-body_t+ol)
				ycopies(spacing=pcb_hole_sp_y, n=2)
				    cuboid(
					[
					    (body_w-pcb_hole_sp_x)/2-body_t+pcb_standoff_o_d/2,
					    pcb_standoff_o_d,
					    pcb_standoff_base_h
					],
					anchor=BOTTOM+LEFT,
					rounding=pcb_standoff_o_d/2,
					edges="Z",
					except=LEFT,
					$fn=16*pcb_standoff_o_d
				    );
			    up(body_t-ol)
				left(pcb_hole_sp_x/2)
				    ycopies(spacing=pcb_hole_sp_y, n=2)
					cyl(
					    d=pcb_standoff_o_d,
					    h=pcb_standoff_h+ol,
					    anchor=BOTTOM,
					    $fn=16*pcb_standoff_o_d
					);
			}
			left(pcb_hole_sp_x/2)
			    ycopies(spacing=pcb_hole_sp_y, n=2)
				    up(body_t+pcb_standoff_h+ol)
					cyl(
					    d=pcb_standoff_i_d,
					    h=pcb_standoff_i_h+ol,
					    anchor=TOP,
					    chamfer1=pcb_standoff_i_d/2,
					    $fn=16*pcb_standoff_i_d
					);
		    }
	    }
	}

    right(body_w/2+ol)
	up(body_h-case_joiner_h-power_conn_pos_z)
	    back(body_l/2-power_conn_pos_y)
		cuboid(
		    [body_t+2*ol, power_conn_size[0], power_conn_size[1]],
		    anchor=RIGHT,
		    rounding=power_conn_r,
		    edges="X",
		    $fn=16*power_conn_r
		);

    right(body_w/2+ol)
	up(body_h-case_joiner_h-audio_out_pos_z)
	    back(body_l/2-audio_out_pos_y)
	        yrot(90)
		    cyl(
			d=audio_out_size,
			h=body_t+2*ol,
			anchor=TOP,
			$fn=16*audio_out_size
		    );

    right(body_w/2+ol)
	up(body_h-case_joiner_h-control_pos_z)
	    fwd(body_l/2-control_pos_y)
		cuboid(
		    [body_t+2*ol, control_size[0], control_size[1]],
		    anchor=RIGHT
		);

    left(body_w/2+ol)
	up(body_h-case_joiner_h-other_conn_pos_z)
	    back(body_l/2-other_conn_pos_y)
		cuboid(
		    [body_t+2*ol, other_conn_size[0], other_conn_size[1]],
		    anchor=LEFT
		);
}
