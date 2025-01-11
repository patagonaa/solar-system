$fn = $preview ? 16 : 64;

module sbMountA(cutout, plugSize, hole1Position, hole2Position, holeDiameter, thickness, border, tabWidth, mountPosition, tabHoleCountersinkHeadDiameter, extraSink, tabHoleDiameter)
{
    module hole()
    {
        rotate([90, 0, 0])
        {
            cylinder(h=100, d=tabHoleDiameter, center=true);
            translate([0, 0, -((tabHoleCountersinkHeadDiameter-tabHoleDiameter)/2*1.14)- extraSink])
                cylinder(h=(tabHoleCountersinkHeadDiameter-tabHoleDiameter)/2*1.14, d1=tabHoleDiameter, d2=tabHoleCountersinkHeadDiameter);
            translate([0, 0, -extraSink-0.01])
                cylinder(h=extraSink+0.02, d=tabHoleCountersinkHeadDiameter);
        }
    }
    
    if(cutout)
    {
        square([plugSize.x+thickness*2,plugSize.z+thickness*2], center=true);
        translate([-mountPosition.x,-mountPosition.y])
            circle(d=tabHoleDiameter);
        translate([mountPosition.x,-mountPosition.y])
            circle(d=tabHoleDiameter);
        translate([-mountPosition.x,mountPosition.y])
            circle(d=tabHoleDiameter);
        translate([mountPosition.x,mountPosition.y])
            circle(d=tabHoleDiameter);
    } else {
        translate([0,0,thickness])
        rotate([-90,0,0])
        difference()
        {
            translate([-thickness-plugSize.x/2, 0, -thickness - plugSize.z/2])
                union()
                {
                    cube([plugSize.x+thickness*2,plugSize.y, plugSize.z+thickness*2]);
                    translate([-border - tabWidth, 0, -border])
                        cube([plugSize.x+thickness*2+border*2+tabWidth*2,border, plugSize.z+thickness*2+border*2]);

                }
            translate([-plugSize.x/2,-0.01,- plugSize.z/2])
                cube([plugSize.x, plugSize.y+0.02, plugSize.z]);
            translate([0,plugSize.y-hole1Position,0])
                cylinder(h=400, d=holeDiameter, center=true);
            translate([0,plugSize.y-hole2Position,0])
                cylinder(h=400, d=holeDiameter, center=true);
            translate([-mountPosition.x,0,-mountPosition.y])
                hole();
            translate([mountPosition.x,0,-mountPosition.y])
                hole();
            translate([-mountPosition.x,0,mountPosition.y])
                hole();
            translate([mountPosition.x,0,mountPosition.y])
                hole();
        }
    }        
}

module sbMount(cutout, sbType)
{
    if(sbType == 120)
    {
        plugSize = [47, 64, 21];
        hole1Position = 8.6; //from back
        hole2Position = hole1Position + 19.1;
        holeDiameter = 5.1;
        
        thickness = 3;
        border = 3;
        
        tabWidth = 9;
        
        mountPosition = [32, 10];
        
        tabHoleCountersinkHeadDiameter = 10;
        extraSink = 0.5;
        tabHoleDiameter = 5.3; // M5 Durchgang
        
        color("grey")
            sbMountA(cutout, plugSize, hole1Position, hole2Position, holeDiameter, thickness, border, tabWidth, mountPosition, tabHoleCountersinkHeadDiameter, extraSink, tabHoleDiameter);
    } else if (sbType == 50)
    {
        plugSize = [36.6, 48.1, 16];
        hole1Position = 6.4; //from back
        hole2Position = hole1Position + 19.1;
        holeDiameter = 3.4;
        
        thickness = 2;
        border = 2;
        
        tabWidth = 6;
        
        mountPosition = [24, 8];
        
        tabHoleCountersinkHeadDiameter = 6;
        extraSink = 0.4;
        tabHoleDiameter = 3.2; // M3 Durchgang
        
        color("grey")
            sbMountA(cutout, plugSize, hole1Position, hole2Position, holeDiameter, thickness, border, tabWidth, mountPosition, tabHoleCountersinkHeadDiameter, extraSink, tabHoleDiameter);
    }
}

//sbMount(false, 50);
sbMount(false, 120);