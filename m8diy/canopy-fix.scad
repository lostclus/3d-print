standoff_l=16;
hole_d=1.15;
hole2_d=2;
hole2_h=0.7;
body_d=3.5;
body_h=1.5;
body_t=1.5;

ol=0.01;

include <BOSL2/std.scad>

difference() {
    union() {
        difference() {
            cuboid(
                [standoff_l+body_t, standoff_l+body_t, body_h],
                rounding=0.4*body_h,
                edges=TOP,
                $fn=16*body_h
            );
            cuboid(
                [standoff_l-body_t, standoff_l-body_t, body_h+2*ol],
                rounding=-0.4*body_h,
                edges=TOP,
                $fn=16*body_h
            );
        }
        
        for(a=[0, 90, 180, 270])
            rotate([0, 0, a])
                translate([standoff_l/2, standoff_l/2, 0])
                    cyl(
                        d=body_d,
                        h=body_h,
                        rounding2=0.4*body_h,
                        $fn=32*body_d
                    );
    }
    
    for(a=[0, 90, 180, 270])
            rotate([0, 0, a])
                translate([standoff_l/2, standoff_l/2, 0]) {
                    cyl(
                        d=hole_d,
                        h=body_h+2*ol,
                        $fn=32*hole_d
                    );
                    up(body_h/2+ol)
                    cyl(
                        d=hole2_d,
                        h=hole2_h,
                        anchor=TOP,
                        $fn=32*hole2_d
                    );
                }
}