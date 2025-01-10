use <din-rail-mount.scad>

$fn = $preview ? 16 : 64;

boxSideSize = [310, 173];
boxHandleSize = [145, 36];

module boxSide(){
    color("lightgrey")
    difference(){
        square(boxSideSize);
        translate([boxSideSize.x/2 - boxHandleSize.x/2, boxSideSize.y - boxHandleSize.y,0])
            square(boxHandleSize);
    }
}

//boxSide();

module frontpanel(){
        offset(-1){
            boxSide();
        }
}

module powerIn(cutout, cap){
    holeX = 19/2;
    holeY = 24/2;
    
    if(cutout){
        circle(d=23.8);
        translate([-holeX, holeY])
            circle(d=3.2);
        translate([holeX, -holeY])
            circle(d=3.2);
    } else {
        color("grey"){ // NAC3MPX
            translate([0, 0, 7/2])
                cube([26, 31, 7], center=true);
            if(cap){ // NSSC-1
                translate([0, 0, 22.7/2]){
                    cube([32.2, 37.2, 22.7], center=true);
                    translate([0, 37.2/2 + (47.7-37.2)/2, 0])
                        cube([26, 47.7-37.2, 22.7], center=true);
                }
            }
        }
    }
}

module powerOut(cutout, cap){
    holePos = 24.4/2;
    
    if(cutout){
        circle(d=28.7);
        translate([-holePos, holePos])
            circle(d=3.2);
        translate([holePos, -holePos])
            circle(d=3.2);
    } else {
        color("grey"){ // NAC3FPX
            translate([0, 0, 10.2/2])
                cube([35.4, 35.4, 10.2], center=true);
            
            if(cap){ // NSSC-2
                translate([0, 0, 25.7/2]){
                    cube([41.5, 41.5, 25.7], center=true);
                    translate([0, 41.5/2 + 8.4/2, 0])
                        cube([30, 8.4, 25.7], center=true);
                }
            }
        }
    }
}

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

module dinrail(te, cutout){
    teWidth = 17.8;
    railDepth = 7.5;
    railHeight = 35;
    
    lssPosition = 1.2;
    
    lssBodySize = [89, 50];
    lssProtrusionSize = [45, 72];
    
    if(cutout)
    {
        //translate([lssBodySize.x/2, -lssBodySize.y - lssPosition,0])
        translate([0, lssBodySize.x/2 - (lssProtrusionSize.x/2)])
            square([te*teWidth, lssProtrusionSize.x]);
    } else {
        rotate([90,0,90])
            translate([lssBodySize.x/2, -lssBodySize.y - lssPosition,0])
            union(){
                color("grey")
                linear_extrude(te*teWidth){
                    translate([-railHeight/2, 0])
                        square([railHeight, railDepth]);
                }
                
                color("lightgrey")
                linear_extrude(te*teWidth){
                    union(){
                        translate([-lssBodySize.x/2, lssPosition])
                            square(lssBodySize);
                        translate([-lssProtrusionSize.x/2, lssPosition])
                            square(lssProtrusionSize);

                    }
                }
            }
    }
}

module banana(cutout)
{
    if(cutout)
    {
        circle(d=12.2);
    } else {
        color("grey")
            cylinder(h=20, d=12.2, center=true);
    }
}

module dinRailMountFrontpanel(cutout)
{
    holeSize = 4.3; // M4
    mountScrewPos = 31;
    if(cutout)
    {
        translate([0,mountScrewPos])
            circle(d=holeSize);
        translate([0,-mountScrewPos])
            circle(d=holeSize);
    }
    else
    {
        rotate([0,90,0])
            dinRailMount();
    }
}

module connectors(cutout){
    topPartWidth = (boxSideSize.x - boxHandleSize.x) / 2 / 2;
    
    translate([topPartWidth - 16, 95])
        powerIn(cutout, false);
    translate([topPartWidth + 16, 95])
        powerIn(cutout, false);
    translate([topPartWidth, 50])
        sbMount(cutout, 50);
    translate([topPartWidth, 20])
        banana(cutout);
    
    translate([boxSideSize.x-topPartWidth, 95])
        powerOut(cutout, true);
    translate([boxSideSize.x-topPartWidth, 35])
        powerOut(cutout, true);
    
    translate([topPartWidth,154])
        sbMount(cutout, 120);
    translate([boxSideSize.x-topPartWidth,154])
        sbMount(cutout, 120);
    
//    translate([boxSideSize.x-topPartWidth, 95])
//        color("blue")
//        cube([50, 63, 40], center=true);

    teWidth = 17.8;
    dinRailMountWidth = 16;
    te = 7;
    
    translate([(boxSideSize.x-2)/2 - (te*teWidth)/2, 20])
        dinrail(te, cutout);

    translate([(boxSideSize.x-2)/2 - (te*teWidth)/2 - dinRailMountWidth/2, 20 + 89/2])
        dinRailMountFrontpanel(cutout);

    translate([(boxSideSize.x-2)/2 + (te*teWidth)/2 + dinRailMountWidth/2, 20 + 89/2])
        dinRailMountFrontpanel(cutout);
}

//sbMount(false, 50);

if($preview){
    connectors(false);
}

difference(){
    frontpanel();
    connectors(true);
}