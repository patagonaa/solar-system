
$fn = $preview ? 16 : 64;


boxSideWidth = 310;

handleWidth = 137.5;

holeDistance = 163.5;
outerPartWidth = holeDistance + 10;

module outerPart()
{
    difference()
    {
        translate([-outerPartWidth/2,-8])
            square([outerPartWidth,33]);
        translate([-holeDistance/2, 0])
            circle(d=5.3);
        translate([holeDistance/2, 0])
            circle(d=5.3);
        translate([-holeDistance/2, 20])
            circle(d=5.3);
        translate([holeDistance/2, 20])
            circle(d=5.3);
    }
}

module innerPart()
{
    points = [
        [-handleWidth/2,50],
        [-handleWidth/2,-2],
        [-handleWidth/2 + 17,-3],
        [0,-5],
        [handleWidth/2 - 17,-3],
        [handleWidth/2,-2],
        [handleWidth/2,50],
    ];

    polygon(points);
}

difference()
{
    union()
    {
        translate([0,0,-3])
            linear_extrude(height=3)
            outerPart();
        translate([0,-8,0])
            linear_extrude(height=80)
            translate([-(handleWidth+6)/2,0])
            square([handleWidth+6,20]);
    }
    translate([0,0,-10])
        linear_extrude(height=100)
            innerPart();
}


    