euroboxInnerHeight = 220-203;

module eurobox(){
    // EG 64/22 WB
    
    outer = [600, 400, 220];
    inner = [565, 366, 203]; // x+y gemessen und 2mm Toleranz abgezogen
    innerRadius = 8.5; // grob gemessen
    
    color("grey")
    difference(){
        cube(outer);
        
        translate([(outer.x-(inner.x-innerRadius*2))/2, (outer.y-(inner.y-innerRadius*2))/2, outer.z-inner.z])
            linear_extrude(inner.z+1)
                minkowski(){
                    square([inner.x - innerRadius*2, inner.y - innerRadius*2]);
                    circle(r=innerRadius);
                }
                
    }
}

module inverter(){
    tabSize = [15, 200, 1];
    inverterSize = [423, 290, 105];
    
    union(){
        translate([0, inverterSize.y/2 - tabSize.y/2, 0])
            cube(tabSize);
        translate([tabSize.x, 0, 0])
            cube(inverterSize);
        color("red", 0.2)
            translate([tabSize.x + inverterSize.x, 0, 0])
            cube([30, inverterSize.y, inverterSize.z]);
    }
}

eurobox();

translate([18, 60, euroboxInnerHeight])
    inverter();