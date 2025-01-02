$fn = $preview ? 16 : 64;

woodWidth = 100;
woodHeight = 38;

tlWidth = 70;
tlHeight = 17;
tlRadius = 21; // 

brWidth = 17;
brHeight = 13;
brRadius = 12.7;

module woodInterference()
{
    translate([woodWidth-tlWidth-tlRadius,tlHeight + tlRadius])
    {
        square([tlRadius,100]);
        circle(r=tlRadius);
    }
    translate([woodWidth-brWidth + brRadius, brHeight - brRadius])
    {
        square([100, brRadius]);
        circle(r=brRadius);
    }
}

module wood()
{
    difference()
    {
        square([woodWidth, woodHeight]);
        woodInterference();
    }
}


module sb120()
{
    plugSize = [47, 64, 21];
    hole1Position = 8.6; //from back
    hole2Position = hole1Position + 19.1;
  
    color("grey")
    difference()
    {
        cube(plugSize);
        translate([plugSize.x/2,plugSize.y-hole1Position,0])
            cylinder(h=400, d=5.1, center=true);
        translate([plugSize.x/2,plugSize.y-hole2Position,0])
            cylinder(h=400, d=5.1, center=true);
    }
}

module sb120mount()
{
    plugSize = [47, 64, 21];
    hole1Position = 8.6; //from back
    hole2Position = hole1Position + 19.1;
    
    thickness = 3;
    border = 3;
    difference()
    {
        translate([-thickness, 0, -thickness])
            union()
            {
                cube([plugSize.x+thickness*2,plugSize.y, plugSize.z+thickness*2]);
                translate([-border, 0, -border])
                    cube([plugSize.x+thickness*2+border*2,border, plugSize.z+thickness*2+border*2]);
            }
        cube(plugSize);
        translate([plugSize.x/2,plugSize.y-hole1Position,0])
            cylinder(h=400, d=5.1, center=true);
        translate([plugSize.x/2,plugSize.y-hole2Position,0])
            cylinder(h=400, d=5.1, center=true);
    }
    
    tabSize = 12;
    tabHoleCountersinkHeadDiameter = 10;
    extraSink = 0.5;
    tabHoleDiameter = 5.3; // M5 Durchgang
    translate([-thickness - border - tabSize, 0, -thickness - border])
    {
        difference(){
            cube([tabSize, border, tabSize]);
            translate([tabSize/2, 0, tabSize/2])
                rotate([90, 0, 0])
                {
                    cylinder(h=100, d=tabHoleDiameter, center=true);
                    translate([0, 0, -((tabHoleCountersinkHeadDiameter-tabHoleDiameter)/2*1.14)- extraSink])
                        cylinder(h=(tabHoleCountersinkHeadDiameter-tabHoleDiameter)/2*1.14, d1=tabHoleDiameter, d2=tabHoleCountersinkHeadDiameter);
                    translate([0, 0, -extraSink])
                        cylinder(h=extraSink, d=tabHoleCountersinkHeadDiameter);
                }
        }
    }
    translate([plugSize.x  + thickness + border, 0, plugSize.z + thickness + border - tabSize])
    {
        difference(){
            cube([tabSize, border, tabSize]);
            translate([tabSize/2, 0, tabSize/2])
                rotate([90, 0, 0])
                {
                    cylinder(h=100, d=tabHoleDiameter, center=true);
                    translate([0, 0, -((tabHoleCountersinkHeadDiameter-tabHoleDiameter)/2*1.14)- extraSink])
                        cylinder(h=(tabHoleCountersinkHeadDiameter-tabHoleDiameter)/2*1.14, d1=tabHoleDiameter, d2=tabHoleCountersinkHeadDiameter);
                    translate([0, 0, -extraSink])
                        cylinder(h=extraSink, d=tabHoleCountersinkHeadDiameter);
                }
        }
    }
}

if($preview)
    wood();

//translate([32,8,3])
//    rotate([-90, 0, 0])
//    sb120();


difference()
{
    translate([33,8,3])
        rotate([-90, 0, 0])
        color("black", 0.5)
        {
            sb120mount();
        }
    linear_extrude(10, center=true)
        woodInterference();
}







