body_h=6;
body_t=1;
body_l=8;
hole1_d=2.45;
hole2_d=1.4;
ol=0.01;

include <BOSL2/std.scad>

difference() {
    union() {
        fwd(body_l/2-hole1_d/2-body_t)
            cyl(
                d=hole1_d+2*body_t,
                h=body_h,
                $fn=16*hole1_d
            );
        cuboid(
            [hole2_d+2*body_t, body_l, body_h],
            rounding=hole2_d/2+body_t,
            edges=[BACK+LEFT, BACK+RIGHT],
            $fn=16*hole2_d
        );
    }
    fwd(body_l/2-hole1_d/2-body_t)
        cyl(
            d=hole1_d,
            h=body_h+2*ol,
            $fn=16*hole1_d
        );
    
    fwd(body_t/2+ol)
        cuboid(
            [hole2_d, body_l-body_t+ol, body_h+2*ol],
            rounding=hole2_d/2,
            edges=[BACK+LEFT, BACK+RIGHT],
            $fn=16*hole2_d
        );
}
