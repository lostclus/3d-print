angle=20;
body_t=1.75;
body_w=6;
body_h=13;
frame_hole_d=2.15;
canopy_hole_d=1.6;

ol=0.01;

include <BOSL2/std.scad>

difference() {
    union() {
        cuboid(
            [body_w, body_w+body_t, body_t],
            anchor=BOTTOM+FRONT,
            rounding=body_w/2,
            edges=[FRONT+LEFT, FRONT+RIGHT],
            $fn=16*body_w
        );
        back(body_w) up(body_t-ol)
            rotate([-angle, 0, 0])
                difference() {
                    union() {
                        cuboid(
                            [body_w, body_t, body_h],
                            anchor=BOTTOM+FRONT,
                            rounding=body_t,
                            edges=[TOP+LEFT, TOP+RIGHT],
                            $fn=32*body_t
                        );
                        up(body_h-body_w/2)
                            rotate([90, 0, 0])
                                cyl(
                                    d=3*canopy_hole_d,
                                    h=1.5*body_t,
                                    anchor=TOP,
                                    rounding1=0.75*body_t,
                                    $fn=32*canopy_hole_d
                                );
                    }
                    up(body_h-body_w/2) fwd(ol)
                        rotate([90, 0, 0])
                            cyl(
                                d=canopy_hole_d,
                                h=2*body_t+2*ol,
                                anchor=TOP,
                                $fn=32*canopy_hole_d
                            );
                    
                }
    }
    down(ol) back(body_w/2)
        cyl(
            d=frame_hole_d,
            h=body_t+2*ol,
            anchor=BOTTOM,
            $fn=16*frame_hole_d
        );
}

