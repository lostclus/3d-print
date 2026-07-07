body_t=1.1;
body_w=20;
bat_d=17.8;
pie_ang=130;
gap_ang=12;
middle_w=10;
middle_pie_ang=290;

vtx_ant_mount_l=5;
vtx_ant_mount_w=5;
vtx_ant_mount_t=1.75;
vtx_ant_mount_hole_d=1.95;

elrs_ant_mount_l=5;
elrs_ant_mount_w=4;
elrs_ant_mount_t=1.75;
elrs_ant_mount_hole_d=1.3;

ol=0.01;

include <BOSL2/std.scad>

difference() {
    cyl(
	d=bat_d+2*body_t,
	h=body_w,
	$fn=16*bat_d
    );
    cyl(
	d=bat_d,
	h=body_w+2*ol,
	$fn=16*bat_d
    );
    pie_slice(
	d=bat_d+2*body_t+2*ol,
	h=body_w+2*ol,
	ang=pie_ang,
	spin=(180-pie_ang)/2,
	center=true,
	$fn=16*bat_d
    );

    for(n=[0 : 3])
	pie_slice(
	    d=bat_d+2*body_t+2*ol,
	    h=middle_w,
	    ang=(360-pie_ang)/4-gap_ang,
	    spin=90+pie_ang/2+n*(360-pie_ang)/4+0.5*gap_ang,
	    center=true,
	    $fn=16*bat_d
	);

    /*
    zscale(2.75)
	torus(
	    od=bat_d+2.75*body_t,
	    id=bat_d+1.25*body_t,
	    $fn=4*bat_d
	);
    */
}

left(bat_d/2+body_t-ol)
    up(body_w/2-(body_w-middle_w)/4)
	difference() {
	    cuboid(
		[elrs_ant_mount_l, elrs_ant_mount_t, elrs_ant_mount_w],
		anchor=RIGHT,
		rounding=elrs_ant_mount_w/2,
		edges="Y",
		except=RIGHT,
		$fn=16*elrs_ant_mount_w
	    );
	    left(elrs_ant_mount_l-elrs_ant_mount_w/2) {
		ycyl(
		    d=elrs_ant_mount_hole_d,
		    h=elrs_ant_mount_t+2*ol,
		    $fn=16*elrs_ant_mount_hole_d
		);
		cuboid(
		    [
			elrs_ant_mount_w/2+ol,
			2*body_t,
			0.85*elrs_ant_mount_hole_d
		    ],
			anchor=RIGHT
		);
	    }
	}

right(bat_d/2+body_t-ol)
    down(body_w/2-(body_w-middle_w)/4)
	difference() {
	    cuboid(
		[vtx_ant_mount_l, vtx_ant_mount_t, vtx_ant_mount_w],
		anchor=LEFT,
		rounding=vtx_ant_mount_w/2,
		edges="Y",
		except=LEFT,
		$fn=16*vtx_ant_mount_w
	    );
	    right(vtx_ant_mount_l-vtx_ant_mount_w/2) {
		ycyl(
		    d=vtx_ant_mount_hole_d,
		    h=vtx_ant_mount_t+2*ol,
		    $fn=16*vtx_ant_mount_hole_d
		);
		cuboid(
		    [
			vtx_ant_mount_w/2+ol,
			2*body_t,
			0.85*vtx_ant_mount_hole_d
		    ],
			anchor=LEFT
		);
	    }
	}
