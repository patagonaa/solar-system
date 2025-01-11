use <din-rail-mount.scad>
use <sbmount.scad>

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

module ground(cutout)
{
    holeSize = 8.4; // M8
    if(cutout)
    {
        circle(d=holeSize);
    } else {
        color("grey")
            cylinder(h=20, d=holeSize, center=true);
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

font = "Liberation Sans:style=bold";
fontSize = 4.2;

frontPanelThickness = 1;

module connectors(mode){
    topPartWidth = (boxSideSize.x - boxHandleSize.x) / 2 / 2;
    
    translate([topPartWidth - 16, 95])
    {    
        if(mode != 2)
        {
            powerIn(mode == 1, false);
        }
        else
        {
            translate([0,-22])
                text("Inverter in", font=font, size=fontSize, halign="center");
        }
    }
    translate([topPartWidth + 16, 95])
    {
        if(mode != 2)
        {
            powerIn(mode == 1, false);
        }
        else
        {
            translate([0,-22])
                text("PSU in", font=font, size=fontSize, halign="center");
        }
    }
    translate([topPartWidth, 50])
    {
        if(mode != 2)
        {
            sbMount(mode == 1, 50);
        }
        else
        {
            translate([0,-18])
                text("PV in", font=font, size=fontSize, halign="center");
        }
    }
    translate([topPartWidth, 20])
    {
        if(mode != 2)
        {
            ground(mode == 1);
        }
        else
        {
            translate([0,-11])
                text("⏚", font="Segoe UI Symbol:style=Bold", size=fontSize+1, halign="center");
        }
    }
    
    translate([boxSideSize.x-topPartWidth, 95])
    {
        if(mode != 2)
        {
            powerOut(mode == 1, false);
        }
        else
        {
            translate([0,-24])
                text("AC Out 1", font=font, size=fontSize, halign="center");
        }
    }
    translate([boxSideSize.x-topPartWidth, 35])
    {
        if(mode != 2)
        {
            powerOut(mode == 1, false);
        }
        else
        {
            translate([0,-24])
                text("AC Out 2", font=font, size=fontSize, halign="center");
        }
    }
    
    translate([topPartWidth,154])
    {
        if(mode != 2)
        {
            sbMount(mode == 1, 120);
        }
        else
        {
            translate([0,-23])
                text("Battery", font=font, size=fontSize, halign="center");
        }
    }
    translate([boxSideSize.x-topPartWidth,154])
    {
        if(mode != 2)
        {
            sbMount(mode == 1, 120);
        }
        else
        {
            translate([0,-23])
                text("Battery", font=font, size=fontSize, halign="center");
        }
    }
    
//    translate([boxSideSize.x-topPartWidth, 95])
//        color("blue")
//        cube([50, 63, 40], center=true);

    teWidth = 17.8;
    dinRailMountWidth = 16;
    te = 7;
    
    if(mode != 2)
    {
        translate([(boxSideSize.x-2)/2 - (te*teWidth)/2, 20, -frontPanelThickness])
            dinrail(te, mode == 1);

        translate([(boxSideSize.x-2)/2 - (te*teWidth)/2 - dinRailMountWidth/2, 20 + 89/2, -frontPanelThickness])
            dinRailMountFrontpanel(mode == 1);

        translate([(boxSideSize.x-2)/2 + (te*teWidth)/2 + dinRailMountWidth/2, 20 + 89/2, -frontPanelThickness])
            dinRailMountFrontpanel(mode == 1);
    }
}

mode = $preview ? 0 : 1; // 0 = 3d preview, 1 = cutouts, 2 = labels
//mode = 1;

if(mode == 1)
{
    difference(){
        frontpanel();
        connectors(mode);
    }
}
else if(mode == 2)
{
    connectors(mode);
}
else
{
    translate([0,0,-frontPanelThickness])
        linear_extrude(frontPanelThickness)
        {
            difference(){
                frontpanel();
                connectors(1);
            }
        }
    
    color("black")
        linear_extrude(1)
        {
            connectors(2);
        }
    connectors(0);
}