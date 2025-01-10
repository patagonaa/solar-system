$fn = $preview ? 16 : 64;


width1 = 85;
width2 = 40;
height = 45; // front of rail to device terminals

mountScrewPos = 31;
mountScrewHeight = 4;
mountScrewDiameter = 4.3;
mountScreqNutSize = 7.1 * (2/sqrt(3)); // M4

railInner = 24;
railOuter = 35.5;
railDepth = 6.2;

railScrewLength = 42; // 4x40 wood screw
railScrewHoleDiameter = 3;

mountWidth = 16;


module dinRailMount()
{
    module mountScrew()
    {
        translate([-0.01,0,0])
            rotate([0,90,0])
            cylinder(h=100, d=mountScrewDiameter);
        
        translate([mountScrewHeight,0,0])
            rotate([0,90,0])
            cylinder(h=100, d=mountScreqNutSize, $fn=6);
    }
    
    difference(){
        linear_extrude(mountWidth, center=true)
            union()
            {
                polygon([[0, -width1/2], [0, width1/2], [height, width2/2], [height, -width2/2]]);
                
                translate([height, 0])
                    square([railDepth*2, railInner], center=true);
            }
        
        translate([0, -mountScrewPos,0])
            mountScrew();
        translate([0, mountScrewPos,0])
            mountScrew();
            
        translate([height + railDepth - railScrewLength,0,0])
            rotate([0,90,0])
            cylinder(h=100, d=railScrewHoleDiameter);
    }
}


dinRailMount();