$fn = $preview ? 16 : 64;

panelThickness = 1;
panelCutout = [17.5, 25.5];

intersectMargin = 0.001;

// PowerPole
ppSize = 7.9;
ppLength = 24.6;

retentionPinDiameter = 2.5;
retentionPinPosition = 10;

tongueHeight = 0.7;
tongueWidth = 3.4;
tongueLength = 12.2;

module pp45(){
    module pin(){
        translate([0,(ppSize+intersectMargin)/2,0])
            rotate([90,0,0])
            cylinder(h=ppSize+intersectMargin,d=retentionPinDiameter);
    }
    
    module tongue(){
        translate([-tongueWidth/2,ppSize/2-intersectMargin, ppLength-tongueLength])
            cube([tongueWidth, tongueHeight, tongueLength]);
    }

    difference(){
        union(){
            translate([-ppSize/2, -ppSize/2, 0])
                cube([ppSize, ppSize, ppLength]);
            
            for(i = [0:90:270]){
                rotate([0,0,i]) tongue();
            }
        };
        translate([ppSize/2,0,retentionPinPosition])
            pin();
        translate([-ppSize/2,0,retentionPinPosition])
            pin();
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
frontThickness = 3;
totalDepth = 20;
depth2 = 1.5;
bottomDepth = totalDepth - frontThickness + 1;
extraClearance = 0.1;

screwHeadHeight = 1;
screwHeadPos = frontThickness - screwHeadHeight;
screwHeadDiameter = 3.8;
holeDiameter = 2.6;
holePos = panelCutout.x/2 - holeDiameter/2 + 0.25;
nutLength = 20;
nutMaxDiameter = 4.7;

letterDepth = 0.45;

//        translate([0,ppSize/2,0])
//            rotate([180,0,90])
//            pp45();
//        translate([0,-ppSize/2,0])
//            rotate([180,0,90])
//            pp45();

module part()
{
    difference()
    {
        union()
        {
            translate([0,0,frontThickness/2])
                cube([panelCutout.x+borderThickness, panelCutout.y+borderThickness, frontThickness], center=true);
                
            translate([0,0,-depth2/2])
                cube([panelCutout.x, panelCutout.y, depth2], center=true);
                
            translate([0,0,-bottomDepth/2])
                cube([12, 20, bottomDepth], center=true);
        }

        minkowski()
        {
            union(){
                translate([0,ppSize/2,frontThickness])
                    rotate([180,0,90])
                    pp45();
                translate([0,-ppSize/2,frontThickness])
                    rotate([180,0,90])
                    pp45();
            }
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
            
    translate([0, -13, frontThickness - letterDepth + 0.01])
        linear_extrude(letterDepth)
        text("48V", font="Segoe UI Symbol:style=Bold", size=4, halign="center");
            
    translate([0, 13, frontThickness - letterDepth + 0.01])
        linear_extrude(letterDepth)
        rotate([0,0,180])
        text("48V", font="Segoe UI Symbol:style=Bold", size=4, halign="center");
    }
}

module diffPart()
{
translate([-8,0,-11])
    cube([15, 40, 24], center=true);
}

translate([0,0,-frontThickness])
    difference(){
        part();
        diffPart();
    }
translate([-12,0,-1])
    intersection(){
        part();
        diffPart();
    }