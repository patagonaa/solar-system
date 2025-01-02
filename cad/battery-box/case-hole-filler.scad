
boardThickness = 10;
railThickness = 12.3;
railHeight = 25;
holeWidth = 40;
sideClampWidth = 2;
sideClampDepth = 15;
sideClampSlot = 12.3;
sideClampOverlap = 2;

bottClampHeight = 3;
bottClampDepth = sideClampDepth;
bottClampSlot = boardThickness;
bottClampOverlap = 2;

angle = 76;

module board(boardHeight)
{
    difference()
    {
        union()
        {
            cube([holeWidth, boardThickness, boardHeight]);
            translate([0,(boardThickness/2)-(railThickness/2),boardHeight])
                cube([holeWidth, railThickness, railHeight]);
            
            translate([-sideClampWidth,(boardThickness/2)-(sideClampDepth/2),0])
                cube([sideClampWidth+sideClampOverlap, sideClampDepth, boardHeight + railHeight]);
            
            translate([holeWidth-sideClampOverlap,(boardThickness/2)-(sideClampDepth/2),0])
                cube([sideClampWidth+sideClampOverlap, sideClampDepth, boardHeight + railHeight]);
            
            translate([-sideClampWidth,(boardThickness/2)-(bottClampDepth/2),-bottClampHeight])
                cube([sideClampWidth+holeWidth+sideClampWidth, bottClampDepth, bottClampHeight+bottClampOverlap]);
        }
    
        translate([holeWidth+20,boardThickness/2,boardHeight+railHeight-6])
            rotate([0,-90,0])
            rotate([0, 0, -angle/2])
            rotate_extrude(angle = angle)
            square([10, holeWidth+40]);
            
        translate([-20,(boardThickness/2)-(railThickness/2),-20])
            cube([20,railThickness,100]);
            
        translate([holeWidth,(boardThickness/2)-(railThickness/2),-20])
            cube([20,railThickness,100]);
        
        
        translate([-50,(boardThickness/2)-(bottClampSlot/2),-bottClampHeight])
            cube([100,bottClampSlot,bottClampHeight]);
    }

}



board(39.5-railHeight);
translate([0, 20, 0])
    board(37.5-railHeight);