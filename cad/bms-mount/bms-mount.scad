$fn = $preview ? 16 : 64;

bmsSize = [125, 67, 14];

module bmsHoles(){
    holeDistX = 115;
    holeDistYBalance = 44;
    holeDistYPower = 26;
    
    translate(bmsSize/2){ // center
        translate([-holeDistX/2, holeDistYBalance/2, 0])
            cylinder(100, d=3.3,center=true);
        translate([-holeDistX/2, -holeDistYBalance/2, 0])
            cylinder(100, d=3.3,center=true);
        
        translate([holeDistX/2, holeDistYPower/2, 0])
            cylinder(100, d=3.3,center=true);
        translate([holeDistX/2, -holeDistYPower/2, 0])
            cylinder(100, d=3.3,center=true);
    }
}

module bms(){
    color("red"){
        difference(){
            cube(bmsSize);
            bmsHoles();
        }
    }
}

module mountPlate2000(){
    plateSize = [220, 120, 3];
    
    holeDiameterTop = 5;
    holeDiameterBottom = 4;
    
    difference(){
        cube(plateSize);
        
        // TL
        translate([6.5,plateSize.y-6.5,-5])
            cylinder(10, d=holeDiameterTop);
        
        // TR
        translate([plateSize.x-6.5,plateSize.y-6.5,-5])
            cylinder(10, d=holeDiameterTop);
        
        // BL
        translate([17,6.5,-5])
            cylinder(10, d=holeDiameterBottom);
        
        // BR
        translate([plateSize.x-6.5,6.5,-5])
            cylinder(10, d=holeDiameterBottom);
        
        translate([60,30,3])
            bmsHoles();
    }
}

module mountPlate2000c(){
    plateSize = [213+15, 115, 3];
    
    holeDiameterTopLeft = 5;
    holeDiameter = 4;
    
    difference(){
        cube(plateSize);
        
        // TL
        translate([20.5,plateSize.y-15,-5])
            cylinder(10, d=holeDiameterTopLeft);
        
        // TR
        translate([213,plateSize.y-15,-5])
            cylinder(10, d=holeDiameter);
        
        // BL
        translate([20.5,18,-5])
            cylinder(10, d=holeDiameter);
        
        // BR
        translate([213,18,-5])
            cylinder(10, d=holeDiameter);
        
        translate([60,30,3])
            bmsHoles();
    }
}


// Platte 300x500

projection(){

    mountPlate2000c();
    translate([0, 115+1, 0])
        mountPlate2000();

    translate([0, 115+1+120+1, 0])
        mountPlate2000();
}