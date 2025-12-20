lenght=45;
inner_d=1.9;
outer_d=4.2;
ear_d=7;
ear_h=1;
ear_a=35;
ear_pos=8;
ol=0.01;

include <BOSL2/std.scad>

difference() {
    union() {
	cyl(
	    d=outer_d,
	    h=lenght,
	    $fn=16*outer_d
	);
	down(lenght/2) up(ear_pos)
	    xscale(cos(ear_a))
		hull() {
		    zcopies(spacing=ear_h, n=2)
			xrot(ear_a)
			    cyl(
				d=ear_d,
				h=ol,
				$fn=16*ear_d
			    );
		}
    }
    cyl(
	d=inner_d,
	h=lenght+2*ol,
	$fn=16*inner_d
    );
}
