include <BOSL2/std.scad>

d1=4.2;
d1_1=3.2;
d2=2.2;
d3=1.3;
h1=0.75;
h2=1.1;
ol=0.01;

difference() {
    union() {
	cyl(
	    d=d1,
	    h=h1,
	    anchor=BOTTOM,
	    $fn=32
	);
	up(h1-ol)
	    cyl(
		d=d2,
		h=h2+2*ol,
		anchor=BOTTOM,
		rounding2=-0.4*(d1_1-d2),
		$fn=32
	    );
	up(h1+h2)
	    cyl(
		d=d1_1,
		h=h1,
		anchor=BOTTOM,
		$fn=32
	    );
    }
    down($fs)
	cyl(
	    d=d3,
	    h=h1+h2+h1+2*$fs,
	    anchor=BOTTOM,
	    $fn=32
	);
}
