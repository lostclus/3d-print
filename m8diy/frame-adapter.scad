body_size=68.0;
body_ray_size=6.45;
body_t=1.4;

prop_hole_d=53.7;
prop_hole_sp=85;

frame_hole1_sp=62;
frame_hole1_d=2.2;

frame_hole2_sp=36;
frame_hole2_d=1.3;
frame_hole2_top_d=2.4;
frame_hole2_top_h=0.5;

standoff_hole_sp=20;
standoff_hole_d=1.77;
standoff_hole_top_d=2.65;
standoff_hole_top_h=0.75;

power_cable_hole_size=15;
power_cable_hole_r=3;

motor_cable_pos_x=21.5;
motor_cable_pos_y=4.0;
motor_cable_angle=18;
motor_cable_w=3.2;
motor_cable_l=1.6;
motor_cable_r=0.75;

ol=0.01;

include <BOSL2/std.scad>

difference() {
    union() {
	zrot_copies([0, 90])
	    cuboid(
		[body_size, body_ray_size, body_t],
		rounding=body_ray_size/2,
		edges="Z",
		$fn=16*body_ray_size
	    );

	cuboid(
	    [
		body_size-1.0*body_ray_size,
		body_size-1.0*body_ray_size,
		body_t
	    ]
	);
    }

    zrot_copies([45, 135])
	xcopies(spacing=prop_hole_sp, n=2)
	    cyl(d=prop_hole_d, h=body_t+2*ol, $fn=16*prop_hole_d);

    zrot_copies([0, 90]) {
	xcopies(spacing=frame_hole1_sp, n=2)
	    cyl(d=frame_hole1_d, h=body_t+2*ol, $fn=16*frame_hole1_d);
	xcopies(spacing=frame_hole2_sp, n=2) {
	    cyl(
		d=frame_hole2_d,
		h=body_t+2*ol,
		$fn=32*frame_hole2_d
	    );
	    up(body_t/2+ol)
		cyl(
		    d=frame_hole2_top_d,
		    h=frame_hole2_top_h+ol,
		    anchor=TOP,
		    rounding1=frame_hole2_top_h/2,
		    $fn=32*frame_hole2_top_d
		);
	}
    }

    grid_copies(spacing=[standoff_hole_sp, standoff_hole_sp], n=[2, 2]) {
	cyl(d=standoff_hole_d, h=body_t+2*ol, $fn=16*standoff_hole_d);
	up(body_t/2+ol)
	    cyl(
		d=standoff_hole_top_d,
		h=standoff_hole_top_h+ol,
		anchor=TOP,
		rounding2=-0.4*standoff_hole_top_h,
		$fn=32*standoff_hole_top_d
	    );
    }

    zrot(45)
	cuboid(
	    [power_cable_hole_size, power_cable_hole_size, body_t+2*ol],
	    rounding=power_cable_hole_r,
	    edges="Z",
	    $fn=32*power_cable_hole_r
	);

    yflip_copy()
	xflip_copy()
	    left(motor_cable_pos_x)
		back(motor_cable_pos_y)
		    zrot(motor_cable_angle)
			cuboid(
			    [motor_cable_w, motor_cable_l, body_t+2*ol],
			    rounding=motor_cable_r,
			    edges="Z",
			    except=BACK,
			    $fn=32*motor_cable_r
			);
    
}
