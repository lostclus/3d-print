inner_d1=7.7;
inner_d2=9.5;
outer_d=12.5;
h1=1.5;
h2=2.7;

hinge_gap=3.2;
hinge_t=1.5;
hinge_l=3.75;
hinge_hole1_d=2.2;
hinge_hole2_d=1.6;

hinge2_l=8.5;
hinge2_w=5.5;
hinge2_t=1.75;
hinge2_a=15;
hinge2_hole_d=2.2;

total_h=h1+h2;

ol=0.01;

include <BOSL2/std.scad>

difference() {
    union() {
        cyl(
            d=outer_d,
            h=h1+h2,
            anchor=BOTTOM,
            $fn=16*outer_d
        );
        cuboid(
            [hinge_gap+2*hinge_t, outer_d/2+hinge_l, total_h],
            anchor=BOTTOM+FRONT,
            rounding=total_h/2,
            edges="X",
            $fn=16*total_h
        );
        translate(
            [
                hinge_gap/2+hinge_t-ol,
                outer_d/2+hinge_l-total_h/2,
                total_h/2
            ]
        )
            rotate([0, 90, 0])
                cyl(
                    d1=total_h,
                    d2=hinge_hole2_d+1,
                    h=0.5*hinge_t+ol,
                    anchor=BOTTOM,
                    $fn=16*total_h
                );
        
        translate([0, -outer_d/2+hinge2_t, total_h-0.25*hinge2_t])
            rotate([-hinge2_a, 0, 0])
                difference() {
                    cuboid(
                        [hinge2_w, hinge2_l+hinge2_t, hinge2_t],
                        anchor=TOP+BACK,
                        rounding=hinge2_w/2,
                        edges=[FRONT+LEFT, FRONT+RIGHT],
                        $fn=16*total_h
                    );
                    fwd(hinge2_l+hinge2_t-hinge2_w/2) up(ol) hull() {
                        cyl(
                            d=hinge2_hole_d,
                            h=hinge2_t+2*ol,
                            anchor=TOP,
                            $fn=16*hinge2_hole_d
                        );
                        back(hinge2_hole_d)
                        cyl(
                            d=hinge2_hole_d,
                            h=hinge2_t+2*ol,
                            anchor=TOP,
                            $fn=16*hinge2_hole_d
                        );
                    }
                    
                }
    }
    down(ol)
        cyl(
                d=inner_d1,
                h=h1+ol,
                anchor=BOTTOM,
                $fn=16*inner_d1
            );
    up(h1-ol)
        cyl(
                d=inner_d2,
                h=h2+2*ol+hinge2_t,
                anchor=BOTTOM,
                $fn=16*inner_d2
            );
    down(ol)
        cuboid(
                [hinge_gap, outer_d/2+hinge_l+ol, total_h+2*ol],
                anchor=BOTTOM+FRONT
            );
    translate([-hinge_gap/2+ol, outer_d/2+hinge_l-total_h/2, total_h/2])
            rotate([0, 90, 0])
                cyl(
                    d=hinge_hole1_d,
                    h=hinge_t+2*ol,
                    anchor=TOP,
                    $fn=16*hinge_hole1_d
                );
    translate([hinge_gap/2-ol, outer_d/2+hinge_l-total_h/2, total_h/2])
            rotate([0, 90, 0])
                cyl(
                    d=hinge_hole2_d,
                    h=1.5*hinge_t+2*ol,
                    anchor=BOTTOM,
                    $fn=16*hinge_hole2_d
                );
}