body_h=2;
leg_l=180;
leg_w=8;
leg_h=2;
sign_w=95;
sign_h=55;
join_w=8;
join_h=4;
join_l=12;
join_r=2;
join_oy=30;
ol=1;

include <BOSL2/std.scad>

cuboid(
    [leg_w, leg_l+ol, body_h],
    anchor=BOTTOM,
    chamfer=leg_w/2,
    edges="Z",
    except=BACK
);
back(leg_l/2-join_oy)
    cuboid(
	[join_w, join_l, join_h],
	rounding=join_r,
	anchor=BOTTOM,
	edges=TOP,
	$fn=16*join_r
    );
back(leg_l/2-ol)
    yscale(sign_h/sign_w)
    cyl(
	d=max(sign_w, sign_h),
        h=body_h,
	anchor=BOTTOM+FRONT,
        $fn=16*sign_w
    );
