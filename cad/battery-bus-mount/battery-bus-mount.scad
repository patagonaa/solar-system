$fn = $preview ? 16 : 64;

panelThickness = 1;
panelCutout = [17.5, 25.5];

// straight pluggable screw terminals WJ2EDGVC-5.08
module screwTerminal(pins, socket = true, plug = true)
{
    pitch = 5.08;
    totalLength = 22;
    socketLength = 12.2;
    socketHeight = 7.8;
    plugHeight = 15.2;
    
    translate([-pins * pitch / 2,0,-socketHeight/2])
    {
        if(socket)
        {
            // socket
            cube([pins * pitch, socketLength, socketHeight]);
            socketTab = 0.6;
            socketTabPos = 3.2;
            cube([pins * pitch, socketTabPos, socketHeight + socketTab]);
            
            for(i = [1:pins])
            {
                translate([-0.5*pitch + i * pitch,socketLength,3.9])
                    rotate([-90,0,0])
                    cylinder(d=1.3, h=6);
            }
        }
        
        if(plug)
        {
            // plug
            plugLength = totalLength - socketLength;
            translate([0,-plugLength,0])
                cube([pins * 5.08,plugLength,plugHeight]);
            clipPos = 3.2;
            clipWidth = 2;
            
            translate([clipPos, 0, socketHeight])
                cube([clipWidth, 5.5, 3]);
            translate([pins * pitch - clipPos - clipWidth, 0, socketHeight])
                cube([clipWidth, 5.5, 3]);
        }
    }
}

//translate([-10,0,0])
//hull(){
//translate([0,0,-20])
//cylinder(d=3, h=20);
//
//rotate([0,-10,0])
//translate([0,0,-20])
//cylinder(d=3, h=20);
//}

borderThickness = 3;
frontThickness = 2.3;
totalDepth = 12.2;
depth2 = 1.5;
depth3 = 5.0;
bottomDepth = totalDepth - frontThickness + 1;
extraClearance = 0.3;

screwHeadHeight = 1.4;
screwHeadPos = frontThickness - screwHeadHeight;
screwHeadDiameter = 3.8;
holeDiameter = 2.6;
holePos = panelCutout.x/2 - holeDiameter/2 + 0.25;
nutLength = 20;
nutMaxDiameter = 4.7;

if($preview)
    translate([holePos, 0, screwHeadPos])
        color("black", 0.5)
        cylinder(d=screwHeadDiameter, h=2);
        
letterDepth = 0.45;

difference()
{
    union()
    {
        translate([0,0,frontThickness/2])
            cube([panelCutout.x+borderThickness, panelCutout.y+borderThickness, frontThickness], center=true);
            
        translate([0,0,-depth2/2])
            cube([panelCutout.x, panelCutout.y, depth2], center=true);
            
        translate([4,0,-depth3/2])
            cube([8, 16, depth3], center=true);
        translate([-4,0,-depth3/2])
            cube([8, 8, depth3], center=true);
            
        translate([0,0,-bottomDepth/2])
            cube([10, 22.5, bottomDepth], center=true);
    }

    translate([0,0,frontThickness + extraClearance])
        rotate([-90,0,-90])
        minkowski()
        {
            screwTerminal(4, true, true);
            if(!$preview)
                sphere(r=extraClearance);
        }
    
    translate([holePos, 0, 0])
        cylinder(d=holeDiameter, h=100, center=true);
    translate([holePos, 0, -nutLength - panelThickness + 0.2])
        cylinder(d=nutMaxDiameter, h=nutLength, $fn=6);
    translate([holePos, 0, screwHeadPos])
        cylinder(d=screwHeadDiameter, h=screwHeadHeight);
        
    translate([-holePos, 0, 0])
        cylinder(d=holeDiameter, h=100, center=true);
    translate([-holePos, 0, -nutLength - panelThickness + 0.2])
        cylinder(d=nutMaxDiameter, h=nutLength, $fn=6);
    translate([-holePos, 0, screwHeadPos])
        cylinder(d=screwHeadDiameter, h=screwHeadHeight);
    
    translate([-8.9, 10, frontThickness - letterDepth + 0.01])
        rotate([0,0,-90])
        linear_extrude(letterDepth)
        text("A", font = "Liberation Sans:style=Bold", size=3.5, halign="center");
        
    translate([-8.9, 5, frontThickness - letterDepth + 0.01])
        rotate([0,0,-90])
        linear_extrude(letterDepth)
        text("B", font = "Liberation Sans:style=Bold", size=3.5, halign="center");
    
    translate([-8.9, -5, frontThickness - letterDepth + 0.01])
        rotate([0,0,-90])
        linear_extrude(letterDepth)
        text("⏚", font="Segoe UI Symbol:style=Bold", size=3.5, halign="center");
        
    translate([-8.9, -10, frontThickness - letterDepth + 0.01])
        rotate([0,0,-90])
        linear_extrude(letterDepth)
        text("⏻", font="Segoe UI Symbol:style=Bold", size=3.5, halign="center");
}