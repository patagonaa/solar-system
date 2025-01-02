$fn = $preview ? 16 : 64;

difference()
{
    union()
    {
        cylinder(h=4, d=10.5, $fn=6);
        translate([19.1, 0, 0])
            cylinder(h=4, d=10.5, $fn=6);
           
        translate([19.1/2,0,0])
            cube([35,10,1], center=true);
    }
    
    cylinder(h=100, d=5.4, center=true);
    translate([19.1, 0, 0])
        cylinder(h=100, d=5.3, center=true);
}