$fn = $preview ? 16 : 64;

// SB120
//plateSize = [35, 10, 1];
//totalHeight = 4;
//holeDistance = 19.1;
//hexOuterSize = 10.5;
//holeDiameter = 5.3;

// SB50
plateSize = [29.8, 9, 0.5];
totalHeight = 3.0;
holeDistance = 19.1;
hexOuterSize = (5/16 * 25.4) * (2/sqrt(3));
holeDiameter = 3.4;

difference()
{
    union()
    {
        translate([-holeDistance/2, 0, 0])
            cylinder(h=totalHeight, d=hexOuterSize, $fn=6);
        translate([holeDistance/2, 0, 0])
            cylinder(h=totalHeight, d=hexOuterSize, $fn=6);
           
        translate([0,0,plateSize.z/2])
            cube(plateSize, center=true);
    }
    
    translate([-holeDistance/2, 0, 0])
        cylinder(h=100, d=holeDiameter, center=true);
    translate([holeDistance/2, 0, 0])
        cylinder(h=100, d=holeDiameter, center=true);
}