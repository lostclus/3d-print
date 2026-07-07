frame_h=5;

motor_front_x_spacing=100;
motor_back_x_spacing=90;
motor_y_spacing=87;
motor_mount_d=11;
motor_hole_d=1.6;
motor_hole2_d=2.3;
motor_hole2_h=3.3;
motor_hole_spacing_d=7;
motor_hole_n=3;
motor_center_hole_d=3.8;
motor_front_holes_rot_a=60;
motor_back_holes_rot_a=20;

fc_hole_spacing=25.5;
fc_hole_d=2.25;
fc_hole_diag=sqrt(2*pow(fc_hole_spacing, 2));
fc_mount_h=2.5;
fc_mount_w=5.5;

arm_front_w=5;
arm_front_x1=7.5;
arm_back_w=3;
arm_back_y1=6.5;
arm_back_y2=22;
arm_mid_w=3;
arm_mid_x1=40;
arm_mid_x2=5;

bat_holder_h=7;
bat_holder_front_w1=26;
bat_holder_front_w2=20;
bat_holder_front_fc_mount_h=4.5;
bat_holder_back_w=6.0;
bat_holder_back_l=1.25;
bat_holder_back_y=28;
bat_l=65.4;
bat_d=18.2;
bat_h=17.5;
bat_y=13.5;

cam_mount_x_spacing=14.5;
cam_mount_w=3;
cam_mount_l=20;
cam_mount_h=11;
cam_mount_hole_d=2.2;
cam_mount_hole_k=0.3;
cam_mount_hole_l=3;
cam_mount_hole2_h=4;
cam_mount_hole2_l=8;

gps_y=6;
gps_w=13;
gps_l=17;
gps_h=4.5;
gps_a=20;
gps_t=1.0;
gps_z=3;
gps_mount_h=7;
gps_mount_w=6;

motor_h=6;
prop_d=65;

ol=0.01;

include <BOSL2/std.scad>

module motor_mount() {
    cyl(
	d=motor_mount_d,
	h=frame_h,
	anchor=BOTTOM,
	$fn=16*motor_mount_d
    );
}

module all_motor_mounts() {
    fwd(motor_y_spacing/2)
	xflip_copy()
	    left(motor_front_x_spacing/2)
		motor_mount();
    back(motor_y_spacing/2)
	xflip_copy()
	    left(motor_back_x_spacing/2)
		motor_mount();
}

module motor_holes() {
    down(ol) {
	cyl(
	    d=motor_center_hole_d,
	    h=frame_h+2*ol,
	    anchor=BOTTOM,
	    $fn=32*motor_center_hole_d
	);
	zrot_copies(d=motor_hole_spacing_d, n=motor_hole_n) {
	    cyl(
		d=motor_hole_d,
		h=frame_h+2*ol,
		anchor=BOTTOM,
		$fn=32*motor_hole_d
	    );
	    cyl(
		d=motor_hole2_d,
		h=motor_hole2_h+ol,
		anchor=BOTTOM,
		$fn=32*motor_hole2_d
	    );
	}
    }
}

module all_motor_holes() {
    fwd(motor_y_spacing/2)
	xflip_copy()
	    left(motor_front_x_spacing/2)
		zrot(motor_front_holes_rot_a)
		    motor_holes();
    back(motor_y_spacing/2)
	xflip_copy()
	    left(motor_back_x_spacing/2)
		zrot(motor_back_holes_rot_a)
		    motor_holes();
}

module front_arms() {
    xflip_copy()
	left(arm_front_x1)
	    cuboid(
		[
		    motor_front_x_spacing/2-arm_front_x1,
		    arm_front_w,
		    frame_h
		],
		anchor=BOTTOM+RIGHT
	    );
}

module back_arms() {
    xflip_copy()
	hull() {
	    left(motor_back_x_spacing/2)
		cyl(
		    d=arm_back_w,
		    h=frame_h,
		    anchor=BOTTOM,
		    $fn=8*arm_back_w
		);
	    fwd(motor_y_spacing-fc_hole_diag-arm_back_y1)
		cyl(
		    d=arm_back_w,
		    h=frame_h,
		    anchor=BOTTOM,
		    $fn=8*arm_back_w
		);
	}

    xflip_copy()
	hull() {
	    left(motor_back_x_spacing/2)
		cyl(
		    d=arm_back_w,
		    h=frame_h,
		    anchor=BOTTOM,
		    $fn=8*arm_back_w
		);
	    fwd(motor_y_spacing-fc_hole_diag-arm_back_y2)
		cyl(
		    d=arm_back_w,
		    h=frame_h,
		    anchor=BOTTOM,
		    $fn=8*arm_back_w
		);
	}
}

module middle_arms() {
    xflip_copy()
	hull() {
	    left(arm_mid_x1)
		cyl(
		    d=arm_mid_w,
		    h=frame_h,
		    anchor=BOTTOM,
		    $fn=8*arm_mid_w
		);
	    back(fc_hole_diag/2)
		left(fc_hole_diag/2+arm_mid_x2)
		    cyl(
			d=arm_back_w,
			h=frame_h,
			anchor=BOTTOM,
			$fn=8*arm_back_w
		    );
	}
    xflip_copy()
	hull() {
	    back(fc_hole_diag/2)
		left(fc_hole_diag/2+arm_mid_x2)
		    cyl(
			d=arm_back_w,
			h=frame_h,
			anchor=BOTTOM,
			$fn=8*arm_back_w
		    );
	    back(fc_hole_diag+arm_back_y2)
		cyl(
		    d=arm_back_w,
		    h=frame_h,
		    anchor=BOTTOM,
		    $fn=8*arm_back_w
		);
	}
}

module all_arms() {
    fwd(motor_y_spacing/2) {
        front_arms();
	middle_arms();
    }
    back(motor_y_spacing/2)
	back_arms();
}

module fc_front_mount() {
    cuboid(
	[2*arm_front_x1+2*ol, arm_front_w, fc_mount_h],
	anchor=BOTTOM
    );
}

module fc_back_mount() {
    hull() {
	cyl(
	    d=fc_mount_w,
	    h=fc_mount_h,
	    anchor=BOTTOM,
	    $fn=8*fc_mount_w
	);
	back(arm_back_y1)
	    cyl(
		d=fc_mount_w,
		h=fc_mount_h,
		anchor=BOTTOM,
		$fn=8*fc_mount_w
	    );
    }
}

module fc_middle_mount() {
    xflip_copy()
	hull() {
	    left(fc_hole_diag/2)
		cyl(
		    d=fc_mount_w,
		    h=fc_mount_h,
		    anchor=BOTTOM,
		    $fn=8*fc_mount_w
		);
	    left(fc_hole_diag/2+arm_mid_x2)
		half_of(RIGHT+FRONT)
		    cyl(
			d=fc_mount_w,
			h=fc_mount_h,
			anchor=BOTTOM,
			$fn=8*fc_mount_w
		    );
	}
}

module all_fc_mounts() {
    fwd(fc_hole_diag/2)
	fc_front_mount();
    back(fc_hole_diag/2)
	fc_back_mount();
    fc_middle_mount();
}

module all_fc_holes() {
    down(ol)
	zrot_copies(n=4, d=fc_hole_diag)
	    cyl(
	        d=fc_hole_d,
		h=frame_h+2*ol,
		anchor=BOTTOM,
		$fn=16*fc_hole_d
	    );
    up(frame_h)
	fwd(fc_hole_diag/2)
	    cyl(
	        d=1.6*fc_hole_d,
		h=bat_holder_h+ol,
		anchor=BOTTOM,
		$fn=16*fc_hole_d
	    );
}

module bat_holder_front() {
    hull() {
        up(frame_h-ol)
	    cuboid(
		[
		    bat_holder_front_w1,
		    arm_front_w,
		    ol
		]
	    );
        up(frame_h+bat_holder_h)
	    cuboid(
		[
		    bat_holder_front_w2,
		    arm_front_w,
		    ol
		]
	    );
    }
}

module bat_holder_front_fc_mount() {
    up(fc_mount_h)
	cuboid(
	    [2*arm_front_x1, arm_front_w+2*ol, bat_holder_front_fc_mount_h],
	    anchor=BOTTOM
	);
}

module bat_holder_back() {
    back(bat_holder_back_y)
	cuboid(
	    [
		bat_holder_back_w,
		bat_l/2-bat_holder_back_y+bat_holder_back_l,
		frame_h+bat_holder_h,
	    ],
	    anchor=BOTTOM+FRONT
	);
}

module all_bat_holders() {
    fwd(fc_hole_diag/2)
	bat_holder_front();
    back(bat_y)
	bat_holder_back();
}

module battery() {
    xrot(90)
	cyl(
	    d=bat_d,
	    h=bat_l,
	    $fn=32*bat_d
	);
}

module cam_mount() {
    xflip_copy()
	left(cam_mount_x_spacing/2)
	    cuboid(
		[
		    cam_mount_w,
		    cam_mount_l+ol,
		    cam_mount_h
		],
		rounding=cam_mount_h/2,
		edges="X",
		except=BACK,
		anchor=BOTTOM+BACK+RIGHT,
		$fn=32*cam_mount_h
	    );
}

module all_cam_mount_holes() {
    fwd(cam_mount_l-cam_mount_hole_k*cam_mount_h)
	up(cam_mount_h-cam_mount_hole_k*cam_mount_h) {
	    hull() {
		yrot(90)
		    cyl(
			d=cam_mount_hole_d,
			h=cam_mount_x_spacing+2*cam_mount_w+2*ol,
			$fn=8*cam_mount_hole_d
		    );
		back(cam_mount_hole_l)
		    yrot(90)
			cyl(
			    d=cam_mount_hole_d,
			    h=cam_mount_x_spacing+2*cam_mount_w+2*ol,
			    $fn=8*cam_mount_hole_d
			);
	    }
	}
    up((cam_mount_h-cam_mount_hole2_h)/2)
	cuboid(
	    [
		cam_mount_x_spacing+2*cam_mount_w+2*ol,
		cam_mount_hole2_l,
		cam_mount_hole2_h,
	    ],
	    rounding=cam_mount_hole2_h/2,
	    edges="X",
	    except=BACK,
	    anchor=BOTTOM+BACK,
	    $fn=8*cam_mount_hole2_h
	);
}

module prop() {
    %cyl(d=prop_d, h=ol, $fn=32*prop_d);
}

module all_props() {
    up(frame_h+motor_h) {
	fwd(motor_y_spacing/2)
	    xflip_copy()
		left(motor_front_x_spacing/2)
		    prop();
	back(motor_y_spacing/2)
	    xflip_copy()
		left(motor_back_x_spacing/2)
		    prop();
    }
}

module gps_mount() {
    difference() {
	union() {
	    hull() {
		up(frame_h+bat_holder_h)
		    fwd(ol)
			cuboid(
			    [bat_holder_back_w, ol, gps_mount_h],
			    anchor=FRONT+UP
			);
		up(frame_h+bat_holder_h+gps_z)
		    back(gps_y)
			xrot(-gps_a)
				down((gps_h+gps_t)/2-ol)
				    cuboid(
					[gps_mount_w, 0.4*gps_l, ol],
					anchor=FRONT
				    );
	    }
	    up(frame_h+bat_holder_h+gps_z)
		back(gps_y)
		    xrot(-gps_a)
			    cuboid(
				[
				    gps_w+2*gps_t,
				    gps_l+gps_t,
				    gps_h+gps_t
				],
				anchor=FRONT
			    );
	}
	up(frame_h+bat_holder_h+gps_z)
	    back(gps_y)
		xrot(-gps_a)
		    up(gps_t/2) fwd(ol)
			cuboid(
			    [gps_w, gps_l, gps_h+ol],
			    anchor=FRONT
			);
    }
}

difference() {
    union() {
	back(motor_y_spacing/2)
	    fwd(fc_hole_diag/2) {
		all_motor_mounts();
		all_arms();
		all_props();
	    }
	all_fc_mounts();
	all_bat_holders();
	fwd(fc_hole_diag/2+arm_front_w/2-ol)
	    cam_mount();
	back(bat_y+bat_l/2+bat_holder_back_l)
	    gps_mount();
    }
    back(motor_y_spacing/2)
	fwd(fc_hole_diag/2)
	    all_motor_holes();
    all_fc_holes();
    up(bat_h) back(bat_y)
	battery();
    fwd(fc_hole_diag/2)
        bat_holder_front_fc_mount();
    fwd(fc_hole_diag/2+arm_front_w/2)
	    all_cam_mount_holes();
}
