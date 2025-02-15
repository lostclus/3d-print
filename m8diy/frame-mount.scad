ol=0.01;
body_l=7;
body_w=3.5;
body_h=3;
body_r=0.5;
cyl_d=4;
hole_d=1.6;

include <BOSL2/std.scad>

difference() {
    union() {
        cuboid(
            [body_w, body_l, body_h],
            rounding=body_r,
            $fn=32*body_r
        );
        cyl(
            d=cyl_d,
            h=body_h,
            $fn=16*cyl_d
        );
    }
    cyl(
        d=hole_d,
        h=body_h+2*ol,
        $fn=16*hole_d
    );
}

