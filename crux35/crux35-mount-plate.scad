body_h=1.25;

front_hole_d=2.35;
front_hole_dx=18;
front_hole_dy=11;
mid_hole_d=2.2;
mid_hole_top_d=4.6;
mid_hole_top_dz=0.4;
mid_hole_dx=20;
mid_hole_dy=20;
back_hole_d=2.2;
back_hole_dx=20;
back_hole_dy=14.25;

elrs_antenna_mount_inner_d1=3.8;
elrs_antenna_mount_inner_d2=3.0;
elrs_antenna_mount_outer_d=6.0;
elrs_antenna_mount_len=22;
elrs_antenna_mount_h=8;
elrs_antenna_mount_gap_x=8;
elrs_antenna_mount_gap_y=0.5;
elrs_antenna_mount_base_l=2.75;

vtx_antenna_mount_base_d=8.0;
vtx_antenna_mount_inner_d1=4.0;
vtx_antenna_mount_inner_d2=3.0;
vtx_antenna_mount_outer_d=6.5;
vtx_antenna_mount_len=4;
vtx_antenna_mount_gap=0.5;

gps_module_w=12;
gps_module_l=17;
gps_module_h=4.5;
gps_mount_angle=30;
gps_mount_t=1.2;
gps_mount_r=1.0;
gps_mount_standoff_w=8;
gps_mount_standoff_l=8;
gps_mount_standoff_h=5.5;
gps_mount_standoff_r=1.5;
gps_mount_gap=6;

ol=0.01;

with_action_camera = true;
action_camera_h=10;
action_camera_w=2.2;
action_camera_l=8;
action_camera_sp=4.2;
action_camera_dy=20;
action_camera_hole_d=2.2;

include <BOSL2/std.scad>

difference() {
    linear_extrude(height=body_h)
	import("crux35-top-plate.svg", center=true);

    // holes
    down(ol)
	fwd(21.1) {
	    xcopies(spacing=front_hole_dx, n=2)
		cyl(
		    d=front_hole_d,
		    h=body_h+2*ol,
		    anchor=BOTTOM,
		    $fn=16*front_hole_d
		);
	    back(front_hole_dy+mid_hole_dy/2)
		grid_copies(spacing=[mid_hole_dx, mid_hole_dy], n=[2, 2]) {
		    cyl(
			d=mid_hole_d,
			h=body_h+2*ol,
			anchor=BOTTOM,
			$fn=16*mid_hole_d
		    );
		    up(mid_hole_top_dz+ol)
			cyl(
			    d=mid_hole_top_d,
			    h=body_h+ol,
			    anchor=BOTTOM,
			    $fn=16*mid_hole_top_d
			);
		}
	    back(front_hole_dy+mid_hole_dy+back_hole_dy)
		xcopies(spacing=back_hole_dx, n=2)
		    cyl(
			d=back_hole_d,
			h=body_h+2*ol,
			anchor=BOTTOM,
			$fn=16*back_hole_d
		    );
	}
}

// ELRS antenna mount
back(32) {
    difference() {
        union() {
	    cuboid(
		[
		    elrs_antenna_mount_len,
		    elrs_antenna_mount_outer_d,
		    elrs_antenna_mount_h
		],
		anchor=BOTTOM,
		rounding=elrs_antenna_mount_outer_d/2,
		edges=[FRONT+TOP, BACK+TOP, BACK+BOTTOM],
		$fn=8*elrs_antenna_mount_outer_d
	    );
	    fwd(elrs_antenna_mount_outer_d/2+elrs_antenna_mount_base_l-ol)
		xrot(90)
		    cuboid(
			[
			    elrs_antenna_mount_len,
			    body_h,
			    elrs_antenna_mount_base_l
			],
			rounding=-elrs_antenna_mount_base_l,
			edges=BOTTOM+BACK,
			anchor=TOP+FRONT,
			$fn=16*elrs_antenna_mount_base_l
		    );
	}
	down(ol)
	    back(elrs_antenna_mount_outer_d/2+ol)
		cuboid(
		    [
			elrs_antenna_mount_gap_x,
			elrs_antenna_mount_outer_d+elrs_antenna_mount_base_l+2*ol,
			elrs_antenna_mount_h+2*ol
		    ],
		    anchor=BOTTOM+BACK
		);
	up(elrs_antenna_mount_h+ol)
	    cuboid(
		[
		    elrs_antenna_mount_len+2*ol,
		    elrs_antenna_mount_gap_y,
		    elrs_antenna_mount_outer_d/2
		],
		anchor=TOP
	    );
	up(
	    elrs_antenna_mount_h-
	    elrs_antenna_mount_outer_d/2
	)
	    zrot_copies(n=2, d=elrs_antenna_mount_len+ol)
		yrot(90)
		    cyl(
			d1=elrs_antenna_mount_inner_d1,
			d2=elrs_antenna_mount_inner_d2,
			h=(elrs_antenna_mount_len-elrs_antenna_mount_gap_x)/2+2*ol,
			anchor=TOP,
			$fn=16*elrs_antenna_mount_inner_d1
		    );
    }
}

// VTX antenna mount
back(17) right(4.7) {
    difference() {
        union() {
	    cyl(
		d=vtx_antenna_mount_outer_d,
		h=vtx_antenna_mount_len,
		anchor=BOTTOM,
		$fn=16*vtx_antenna_mount_outer_d
	    );
	    cyl(
		d=vtx_antenna_mount_base_d,
		h=body_h,
		anchor=BOTTOM,
		$fn=16*vtx_antenna_mount_base_d
	    );
	}
	down(ol) {
	    cyl(
		d1=vtx_antenna_mount_inner_d1,
		d2=vtx_antenna_mount_inner_d2,
		h=vtx_antenna_mount_len+2*ol,
		anchor=BOTTOM,
		$fn=16*vtx_antenna_mount_inner_d1
	    );
	    cuboid(
		[
		    vtx_antenna_mount_gap,
		    vtx_antenna_mount_base_d/2+ol,
		    vtx_antenna_mount_len+2*ol
		],
		anchor=BOTTOM+FRONT
	    );
	}
    }
}

// GPS module mount
union() {
    difference() {
	cuboid(
	    [
		gps_mount_standoff_w,
		gps_mount_standoff_l,
		gps_mount_standoff_h*2
	    ],
	    anchor=BOTTOM,
	    rounding=gps_mount_standoff_r,
	    edges="Z",
	    $fn=16*gps_mount_standoff_r
	);
	up(gps_mount_standoff_h)
	    xrot(-gps_mount_angle)
		cuboid(
		    [
			gps_mount_standoff_w+2*ol,
			gps_mount_standoff_l*2,
			gps_mount_standoff_h*2
		    ],
		    anchor=BOTTOM
		);
    }
    up(gps_mount_standoff_h)
	xrot(-gps_mount_angle)
	    difference() {
		cuboid(
		    [
			gps_module_w+2*gps_mount_t,
			gps_module_l+2*gps_mount_t,
			gps_module_h+gps_mount_t
		    ],
		    anchor=BOTTOM,
		    rounding=gps_mount_r,
		    edges="Z",
		    $fn=16*gps_mount_r
		);
		up(gps_mount_t) {
		    cuboid(
			[
			    gps_module_w,
			    gps_module_l,
			    gps_module_h+ol,
			],
			anchor=BOTTOM
		    );
		    back(gps_module_l/2-ol)
			cuboid(
			    [
				gps_mount_gap,
				gps_mount_t+2*ol,
				gps_module_h+ol,
			    ],
			    anchor=BOTTOM+FRONT
			);
		}
	    }
}

// Action camera
if (with_action_camera) {
    fwd(action_camera_dy) {
	cuboid(
	    [action_camera_sp*3, action_camera_l, body_h],
	    anchor=BOTTOM
	);
	up(body_h-ol)
	    difference() {
		xcopies(spacing=action_camera_sp, n=3)
		    cuboid(
			[action_camera_w, action_camera_l, action_camera_h+ol],
			anchor=BOTTOM,
			rounding=action_camera_l/2,
			edges=[TOP+FRONT, TOP+BACK],
			$fn=8*action_camera_l
		    );
		up(action_camera_h-action_camera_l/2)
		    yrot(90)
			cyl(
			    d=action_camera_hole_d,
			    h=action_camera_sp*3,
			    $fn=8*action_camera_hole_d
			);
	    }
    }
}
