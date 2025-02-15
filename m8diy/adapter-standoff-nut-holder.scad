standoff_l=20;
nut_d=3.6;
body_d=4.8;
body_h=1.3;
body_t=1.5;

ol=0.01;

include <BOSL2/std.scad>

difference() {
    union() {
        difference() {
            cuboid(
                [standoff_l+body_t, standoff_l+body_t, body_h]
            );
            cuboid(
                [standoff_l-body_t, standoff_l-body_t, body_h+2*ol]
            );
        }
        
        for(a=[0, 90, 180, 270])
            rotate([0, 0, a])
                translate([standoff_l/2, standoff_l/2, 0])
                    cyl(
                        d=body_d,
                        h=body_h,
                        $fn=32*body_d
                    );
    }
    
    for(a=[0, 90, 180, 270])
            rotate([0, 0, a])
                translate([standoff_l/2, standoff_l/2, 0])
                    linear_extrude(height=body_h+2*ol, center=true)
                    hexagon(od=nut_d);
}