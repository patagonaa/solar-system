$fn = $preview ? 16 : 64;

boxSideSize = [310, 173];
boxHandleSize = [145, 36];

module boxSide(){
    color("lightgrey")
    difference(){
        square(boxSideSize);
        translate([boxSideSize.x/2 - boxHandleSize.x/2,0,0])
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
                    translate([0, -37.2/2 - (47.7-37.2)/2, 0])
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
                    translate([0, -41.5/2 - 8.4/2, 0])
                        cube([30, 8.4, 25.7], center=true);
                }
            }
        }
    }
}

module connectors($cutout){
    translate([20, 70])
        powerIn($cutout, false);
    translate([20, 120])
        powerIn($cutout, true);
    
    translate([60, 70])
        powerOut($cutout, false);
    translate([60, 120])
        powerOut($cutout, true);
}

if($preview){
    connectors(false);
}

difference(){
    frontpanel();
    connectors(true);
}