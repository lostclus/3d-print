include <BOSL2/std.scad>

body_d=12;
body_t=1.25;
body_l=35;
body_h1=4.5;
body_h2=7.0;

motor_hole_d=1.8;
motor_hole_d2=3.2;
motor_center_hole_d=3.2;
motor_center_hole_h=1.75;
motor_hole_l=7;

ol=0.01;

difference() {
    union() {
	hull() {
	    cuboid(
		[body_d, body_t, body_h2],
		anchor=TOP+FRONT,
		rounding=body_d/2,
		edges="Y",
		except=TOP,
		$fn=16*body_d
	    );
	    back(body_l-body_d)
		cuboid(
		    [body_d, body_d, ol],
		    anchor=TOP+FRONT,
		    rounding=body_d/2,
		    edges="Z",
		    except=FRONT,
		    $fn=16*body_d
		);
	}
	down(ol)
	    cuboid(
		[body_d, 1.5*body_t, body_h1+ol],
		anchor=BOTTOM+FRONT,
		rounding=-body_h1,
		edges=BOTTOM+BACK,
		$fn=16*body_d
	    );
    }

    fwd(ol)
	down(body_h2-body_d/2) {
	    xrot(-90)
		cyl(
		    d=motor_center_hole_d,
		    h=motor_center_hole_h+ol,
		    anchor=BOTTOM,
		    $fn=16*motor_center_hole_d
		);
	    yrot_copies(n=3, d=motor_hole_l, sa=90)
		xrot(-90) {
		    cyl(
			d=motor_hole_d,
			h=body_l+2*ol,
			anchor=BOTTOM,
			$fn=16*motor_hole_d
		    );
		    up(body_t+ol)
			cyl(
			    d=motor_hole_d2,
			    h=body_l,
			    anchor=BOTTOM,
			    $fn=16*motor_hole_d2
			);
		}
	    }
}
