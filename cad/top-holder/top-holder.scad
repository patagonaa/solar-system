$fn = $preview ? 16 : 64;

bottomLength = 100;
topLength = 30;
topScrewDepth = 20;
partWidth = 20;
partHeight = 110;
earDepth = 20;
earWidth = 20;

module basePartHalf()
{
    rotate([90,0,0])
    linear_extrude(partWidth, center=true)
    {
        polygon([
            [0,0],
            [bottomLength/2,0],
            [bottomLength/2,earDepth],
            [bottomLength/2-earWidth,earDepth],
            [topLength/2,partHeight],
            [0,partHeight]
            ]);
    }
}

// 4x30 countersink wood screw
bottomScrewHeadDiameter = 8.5; // nominal 8
bottomScrewDiameter = 4.5; // nominal 4
bottomScrewExtraSink = 0.4;
bottomScrewSinkDepth = (bottomScrewHeadDiameter-bottomScrewDiameter)*sqrt(2);

// M5x30
topScrewDiameter = 5.8;
topScrewNutDiameter = 8.4 * (2/sqrt(3)); // 8mm + tolerance

topScrewInnerLength = 30;
topScrewNutPos = 12;
topScrewNutHeight = 6; // 5mm + tolerance

module partHalf()
{
    difference()
    {
        basePartHalf();
        
        translate([0,0,partHeight-topScrewInnerLength +0.01])
            cylinder(d=topScrewDiameter, h=topScrewInnerLength);
        translate([0,0,partHeight - topScrewNutPos - topScrewNutHeight])
        cylinder(d=topScrewNutDiameter, h=topScrewNutHeight, $fn = 6);
        
        translate([bottomLength/2-earWidth/2, 0, 0])
        {
            cylinder(d=bottomScrewDiameter, h=1000);
            translate([0,0,earDepth - bottomScrewExtraSink])
            {
                cylinder(h=1000, d=bottomScrewHeadDiameter);
                translate([0,0,-bottomScrewSinkDepth + 0.01])
                    cylinder(h=bottomScrewSinkDepth, d1=0, d2=8);
            }
        }
    }
}

if($preview)
{
    partHalf();
}
else
{
    union()
    {
        partHalf();
        mirror([1,0,0])
            partHalf();
    }
}