include <BOSL2/std.scad>

base_w=48;
base_l=48;
base_h=28;
base_r1=5;
base_r2=20;

body_t=2.8;
body_w=70;
mount_w=8;

mount_hole_gap=62;
mount_hole_d=3.2;

cam_mount_leg_w=2;
cam_mount_leg_l=8;
cam_mount_leg_h=10;
cam_mount_hole_d=2.2;
cam_mount_step=4;

antena_hole_w1=9;
antena_hole_w2=2.5;

extra_hole_d=4.0;

ol=0.01;

difference() {
    union() {
	cuboid(
	    [base_w, base_l, base_h],
	    anchor=BOTTOM,
	    rounding=base_r2,
	    except=BOTTOM,
	    $fn=6*base_r2
	);
	cuboid(
	    [base_w+2*base_r1, base_l+2*base_r1, body_t],
	    anchor=BOTTOM
	);
	up(body_t)
	    cuboid(
		[base_w, base_l, base_r1],
		anchor=BOTTOM,
		rounding=-base_r1,
		edges=BOTTOM,
		$fn=6*base_r1
	    );
	zrot_copies([0, 90])
	    cuboid(
		[body_w, mount_w, body_t],
		anchor=BOTTOM,
		rounding=mount_w/2,
		edges="Z",
		$fn=8*mount_w
	    );
	up(base_h-body_t)
	    xcopies(n=3, spacing=cam_mount_step)
		cuboid(
		    [cam_mount_leg_w, cam_mount_leg_l, cam_mount_leg_h+body_t],
		    anchor=BOTTOM,
		    rounding=cam_mount_leg_l/2,
		    edges="X",
		    except=BOTTOM,
		    $fn=4*cam_mount_leg_l
		);
    }

    down(ol) {
	cuboid(
	    [base_w-2*body_t, base_l-2*body_t, base_h-body_t],
	    anchor=BOTTOM,
	    rounding=0.8*base_r2,
	    except=BOTTOM,
	    $fn=6*base_r2
	);
	cuboid(
	    [base_w-2*body_t, base_l-2*body_t, base_r1],
	    anchor=BOTTOM,
	    rounding=-1.35*base_r1,
	    edges=BOTTOM,
	    $fn=6*base_r1
	);

	zrot_copies(n=4, d=mount_hole_gap)
	    cyl(
		d=mount_hole_d,
		h=2*body_t,
		anchor=BOTTOM,
		$fn=8*mount_hole_d
	    );

	xflip_copy()
	    left(body_w/2)
		back(body_w/2)
		    cuboid(
			[
			    (body_w-mount_w)/2,
			    (body_w-mount_w)/2,
			    base_h+2*ol
			],
			anchor=BOTTOM+LEFT+BACK,
			rounding=(base_w-mount_w)/2,
			edges=FWD+RIGHT,
			$fn=2*base_w
		    );
	fwd(body_w/2)
	    cuboid(
		[
		    body_w,
		    (body_w-mount_w)/2,
		    base_h+2*ol
		],
		anchor=BOTTOM+FWD
	    );
    }

    up(base_h+cam_mount_leg_h-0.5*cam_mount_leg_l)
	yrot(90)
	    cyl(
		h=3*cam_mount_step,
		d=cam_mount_hole_d,
		$fn=8*cam_mount_hole_d
	    );

    hull() {
	back(mount_w/2)
	    up(base_h-body_t)
	    cuboid(
		[antena_hole_w1, ol, body_t+ol],
		anchor=BOTTOM+FRONT
	    );
	back((base_l-mount_w)/4-body_t)
	    xrot(-35)
		cyl(
		    d=antena_hole_w2,
		    h=2*base_h,
		    anchor=BOTTOM+FRONT,
		    $fn=8*antena_hole_w2
		);
    }

    xflip_copy()
	left(0.25*base_w) back(0.25*mount_w)
	    cyl(
		d=extra_hole_d,
		h=base_h+ol,
		anchor=BOTTOM,
		$fn=8*extra_hole_d
	    );
    
}
