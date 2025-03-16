include <bbp20-12-case-common.scad>

leg_d=6;
leg_h=3;
leg_r=1.5;

include <BOSL2/std.scad>

cyl(
    d=leg_d,
    h=leg_h,
    anchor=BOTTOM,
    rounding1=leg_r,
    $fn=16*leg_d
);
cyl(
    d=leg_joiner_d-leg_joiner_tolerance,
    h=leg_h+leg_joiner_h-2.0*leg_joiner_tolerance,
    anchor=BOTTOM,
    rounding2=0.15*leg_joiner_d,
    $fn=16*leg_joiner_d
);
