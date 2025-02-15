battery_w=17.1;
battery_h=25.1;

battery_dh=12;

frame_fix_w=22;
frame_fix_h=4.1;
frame_fix_l=15.8;

body_l=40;
body_t=1.5;

conn_w=5.0;
conn_h=10.2;
conn_l=8;
conn_pos_z=1;

leg_w=30;
leg_l=12;
leg_r=2.5;

hole_sp=7.5;

ol=0.01;

include <BOSL2/std.scad>


difference() {
    union() {
	down(body_t)
	    cuboid(
		[frame_fix_w+2*body_t, frame_fix_l, frame_fix_h+2*body_t],
		anchor=BOTTOM
	    );
	cuboid(
	    [battery_w+2*body_t, body_l, battery_h-battery_dh+body_t],
	    anchor=TOP,
	    rounding=1.5*body_t,
	    edges=[TOP+FRONT, TOP+BACK],
	    $fn=16*body_t
	);

	xflip_copy()
	    left(battery_w/2+body_t-ol)
		yrot(-90)
		    cuboid(
			[body_t, frame_fix_l, body_t],
			anchor=BOTTOM+RIGHT,
			rounding=-0.75*body_t,
			edges=BOTTOM,
			except=RIGHT,
			$fn=32*body_t
		    );

	down(battery_h-battery_dh+body_t)
	    cuboid(
		[leg_w, leg_l, body_t],
		anchor=BOTTOM,
		rounding=leg_r,
		edges="Z",
		$fn=16*leg_r
	    );

	left(frame_fix_w/2)
	    down(body_t+conn_pos_z) {
		cuboid(
		    [conn_w+2*body_t, conn_l, conn_h+2*body_t],
		    anchor=BOTTOM+RIGHT
		);
		left(ol)
		    cuboid(
			[
			    frame_fix_w/2-battery_w/2+ol,
			    conn_l,
			    body_t
			],
			anchor=BOTTOM+LEFT
		    );
	    }
    }

    cuboid(
	[frame_fix_w, frame_fix_l+2*ol, frame_fix_h],
	anchor=BOTTOM
    );

    down(battery_h-battery_dh)
	cuboid(
	    [battery_w, body_l+2*ol, battery_h],
	    anchor=BOTTOM
	);

    down(battery_h-battery_dh+body_t+ol)
        ycopies(spacing=body_l/2-body_t, n=2)
	    cuboid(
		[battery_w-hole_sp, body_l/2-hole_sp, body_t+2*ol],
		anchor=BOTTOM,
		rounding=body_t,
		edges="Z",
		$fn=16*body_t
	    );

    if (battery_h-battery_dh-hole_sp > 2*body_t)
	down((battery_h-battery_dh+body_t)/2)
	    ycopies(spacing=body_l/2-body_t, n=2)
		cuboid(
		    [
			battery_w+2*body_t+2*ol,
			body_l/2-hole_sp,
			battery_h-battery_dh-hole_sp
		    ],
		    rounding=body_t,
		    edges="X",
		    $fn=16*body_t
		);

    left(frame_fix_w/2+body_t)
        down(conn_pos_z)
	    cuboid(
		[conn_w, conn_l+2*ol, conn_h],
		anchor=BOTTOM+RIGHT
	    );

    left(frame_fix_w/2+conn_w+body_t-ol)
        down(conn_pos_z)
	    difference() {
		cuboid(
		    [body_t+2*ol, conn_l+2*ol, conn_h],
		    anchor=BOTTOM+RIGHT,
		    rounding=-body_t/2,
		    edges="Y",
		    $fn=16*body_t
		);
		left(body_t/2) 
		    up(conn_h/2)
			zcopies(spacing=conn_h+0.25*body_t, n=2)
			    xrot(90)
				cyl(d=body_t, h=conn_l+2*ol, $fn=16*body_t);
		
	    }
}
