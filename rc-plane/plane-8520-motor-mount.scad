include <BOSL2/std.scad>

motor_d=8.5;
mount_d=5.5;
body_l=15;
body_t=1;
ol=0.01;


difference() {
    hull() {
	cyl(
	    d=motor_d+2*body_t,
	    h=body_l,
	    $fn=8*motor_d
	);
	fwd(motor_d/2+body_t+mount_d/2)
	    cyl(
		d=mount_d+2*body_t,
		h=body_l,
		$fn=8*mount_d
	    );
    }
    cyl(
	d=motor_d,
	h=body_l+2*ol,
	$fn=8*motor_d
    );
    fwd(motor_d/2+body_t+mount_d/2)
	cyl(
	    d=mount_d,
	    h=body_l+2*ol,
	    $fn=8*mount_d
	);
}
