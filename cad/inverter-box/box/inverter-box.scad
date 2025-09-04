euroboxInnerHeight = 220-203;

module eurobox(){
    // EG 64/22 WB
    
    outer = [600, 400, 220];
    inner = [565, 366, 203]; // x+y gemessen und 2mm Toleranz abgezogen, Z aus Datenblatt
    innerRadius = 8.5; // grob gemessen
    
    color("grey")
    difference(){
        cube(outer);
        
        translate([(outer.x-(inner.x-innerRadius*2))/2, (outer.y-(inner.y-innerRadius*2))/2, outer.z-inner.z])
            linear_extrude(inner.z+1)
            minkowski(){
                square([inner.x - innerRadius*2, inner.y - innerRadius*2]);
                circle(r=innerRadius);
            };
    }
}

module inverter(){
    tabSize = [15, 200, 1];
    inverterSize = [423, 290, 105];
    
    union(){
        color("darkgrey")
        translate([0, inverterSize.y/2 - tabSize.y/2, 0])
            cube(tabSize);
        color("lightblue")
            translate([tabSize.x, 0, 0])
            cube(inverterSize);
        color("red", 0.2)
            translate([tabSize.x + inverterSize.x, 0, 0])
            cube([30, inverterSize.y, inverterSize.z]);
    }
}

module dinrail(te){
    teWidth = 17.8;
    railDepth = 7.5;
    railHeight = 35;
    
    lssBodySize = [89, 50];
    lssProtrusionSize = [45, 72];
    
    translate([lssBodySize.x/2, 0])
    union(){
        color("grey")
        linear_extrude(te*teWidth){
            translate([-railHeight/2, 0])
                square([railHeight, railDepth]);
        }
        
        color("lightgrey")
        linear_extrude(te*teWidth){
            union(){
                translate([-lssBodySize.x/2, railDepth - 6.3])
                    square(lssBodySize);
                translate([-lssProtrusionSize.x/2, railDepth - 6.3])
                    square(lssProtrusionSize);

            }
        }
    }
}

eurobox();

translate([18, 60, euroboxInnerHeight])
    inverter();

translate([489, 30, euroboxInnerHeight])
    rotate([90, 0, 90])
    dinrail(5);