$fn = $preview ? 16 : 64;

tolerance = 0.2;

rj45boardSize = [34.2+tolerance, 28+tolerance, 1.4+tolerance];
rj45holeDiameter = 3.0 - tolerance;
rj45holeWidthDistance = 28;
rj45hole1FrontPosition = -5.5;
rj45hole2FrontPosition = -16.5;

module rj45breakout()
{
    rj45jackCutout = 5;
    boardThickness = 1.4;
    rj45jackSize = [15.8, 18.3 + rj45jackCutout, 13.0];
    rj45jackBottomDepth = 2.5;
    
    rj45PinsSize = [25, 6, 2];
    rj45PinsExtraSize = 4;
    
    difference()
    {
        union()
        {
        translate([-rj45boardSize.x/2, -rj45boardSize.y, -rj45boardSize.z])
            cube(rj45boardSize);
        translate([-rj45jackSize.x/2, -rj45jackSize.y + rj45jackCutout, 0])
            color("grey")
            cube(rj45jackSize);
        translate([-rj45jackSize.x/2, -rj45jackSize.y, -boardThickness-rj45jackBottomDepth])
            color("grey")
            cube([rj45jackSize.x, rj45jackSize.y, rj45jackBottomDepth]);
            
        translate([-rj45PinsSize.x/2,-rj45boardSize.y-rj45PinsExtraSize, -boardThickness-rj45PinsSize.z])
            color("grey")
            cube([rj45PinsSize.x, rj45PinsSize.y + rj45PinsExtraSize, rj45PinsSize.z]);
            
        }
        
        translate([rj45holeWidthDistance/2, rj45hole1FrontPosition])
            cylinder(100, d=rj45holeDiameter, center=true);
        translate([-rj45holeWidthDistance/2, rj45hole1FrontPosition])
            cylinder(100, d=rj45holeDiameter, center=true);
        translate([rj45holeWidthDistance/2, rj45hole2FrontPosition])
            cylinder(100, d=rj45holeDiameter, center=true);
        translate([-rj45holeWidthDistance/2, rj45hole2FrontPosition])
            cylinder(100, d=rj45holeDiameter, center=true);
    }
}

ttgo485Size = [35+tolerance, 80.5+tolerance];
ttgo485BoardThickness = 1.2;
ttgo485BoardTopMaxThickness = 3.3;
ttgo485BoardBottomMaxThickness = 2.5;

usbCSize = [7.4 + 10, 9+tolerance, 3.2+tolerance];
usbCPosY = 22-tolerance/2;
usbCPosX = 5.5;

module ttgo485()
{    
    translate([-ttgo485Size.x/2, -ttgo485Size.y, -ttgo485BoardThickness])
        cube([ttgo485Size.x, ttgo485Size.y, ttgo485BoardThickness]);
    
    powerConnectorSize = [9, 19, 11.2];
    powerConnectorPos = [9.5, 5, -2.2];
    translate([ttgo485Size.x/2 - powerConnectorPos.x, -powerConnectorPos.y, powerConnectorPos.z])
        color("grey")
        cube(powerConnectorSize);
    
    dataConnectorSize = [12.4, 17, 11.2];
    dataConnectorPos = [13.2, 5, -2.2];
    translate([ttgo485Size.x/2 - dataConnectorPos.x, -ttgo485Size.y - dataConnectorSize.y +dataConnectorPos.y, dataConnectorPos.z])
        color("grey")
        minkowski()
        {
            cube(dataConnectorSize);
            sphere(tolerance);
        }
    
    translate([-ttgo485Size.x/2 + dataConnectorPos.x - dataConnectorSize.x, -ttgo485Size.y - dataConnectorSize.y +dataConnectorPos.y, dataConnectorPos.z])
        color("grey")
        minkowski()
        {
            cube(dataConnectorSize);
            sphere(tolerance);
        }
    
    sdCutoutSize = [24, 44, 2.5];
    
    translate([-sdCutoutSize.x/2,-sdCutoutSize.y - 15,-sdCutoutSize.z-ttgo485BoardThickness])
        color("grey")
        cube(sdCutoutSize);
        
    translate([-ttgo485Size.x/2 - usbCSize.x + usbCPosX,-usbCSize.y + -usbCPosY, 0])
        color("grey")
        cube(usbCSize);
}

moduleDistance = 20;

boardPosZ = 4;

caseSize = [ttgo485Size.x, ttgo485Size.y + moduleDistance + rj45boardSize.y, 20];
caseThickness = 2;
module case()
{
    //ttgo485cutout
    
    rj45HolderWidth = 25;
    rj45HolderThickness = 6;
    
    ttgo485HolderWidth = 12;
    ttgo485HolderThickness = 8;
    
    
    difference()
    {
        union()
        {
            difference()
            {
            translate([-caseSize.x/2, 0, 0])
                minkowski()
                {
                    cube(caseSize);
                    sphere(caseThickness);
                }
            translate([-caseSize.x/2, 0, boardPosZ])
                cube([caseSize.x, caseSize.y, caseSize.z - boardPosZ]);
            }
            translate([-caseSize.x/2, caseSize.y - rj45HolderWidth, boardPosZ])
                cube([rj45HolderThickness, rj45HolderWidth, caseSize.z - boardPosZ]);
            translate([caseSize.x/2 - rj45HolderThickness, caseSize.y - rj45HolderWidth, boardPosZ])
                cube([rj45HolderThickness, rj45HolderWidth, caseSize.z - boardPosZ]);
            translate([-ttgo485HolderWidth/2, ttgo485Size.y-ttgo485HolderThickness/2, boardPosZ])
                cube([ttgo485HolderWidth, ttgo485HolderThickness, caseSize.z - boardPosZ]);
        }
        translate([0, ttgo485Size.y + rj45boardSize.y + moduleDistance, boardPosZ + rj45boardSize.z])
            rj45breakout();

        translate([0, ttgo485Size.y, boardPosZ + ttgo485BoardThickness])
            ttgo485();
    }

}

module diffPart()
{
    diffPartWidth = caseSize.x + caseThickness*2;
    diffPartLength = caseSize.y + caseThickness*2;
    
    innerEdge = 1.5;
    
    diffPartInnerWidth = caseSize.x + innerEdge;
    diffPartInnerLength = caseSize.y + innerEdge;
    
    translate([-diffPartWidth/2,-caseThickness,caseSize.z])
        cube([diffPartWidth, diffPartLength , 5]);
    
    translate([-diffPartInnerWidth/2,-innerEdge/2,caseSize.z - 2])
        cube([diffPartInnerWidth, diffPartInnerLength, 5]);
    
    translate([-caseSize.x/2,caseSize.y -30,boardPosZ + rj45boardSize.z])
        cube([caseSize.x, 30, caseSize.z]);
    
    translate([-caseSize.x/2,0,boardPosZ + ttgo485BoardThickness])
        cube([caseSize.x, ttgo485Size.y, caseSize.z]);
    
    translate([-ttgo485Size.x/2 - usbCSize.x + usbCPosX, ttgo485Size.y -usbCSize.y + -usbCPosY + 0.01, boardPosZ + ttgo485BoardThickness+0.01])
        cube([usbCSize.x, usbCSize.y -0.01, caseSize.z]);
}

if($preview){
    difference()
    {
        case();
        translate([0, 0, caseSize.z - 5])
            cube(caseSize*2);
    }
//    color("red", 0.1)
//        diffPart();
}

difference()
{
    case();
    diffPart();
}


translate([-60, 0, caseSize.z])
rotate([180,0,180])

intersection()
{
    case();
    diffPart();
}

//diffPart();

if($preview)
{
    translate([0, ttgo485Size.y + rj45boardSize.y + moduleDistance, boardPosZ + rj45boardSize.z])
        rj45breakout();

    translate([0, ttgo485Size.y, boardPosZ + ttgo485BoardThickness])
        ttgo485();
    
    translate([40, 0, 0])
        rj45breakout();
    translate([80, 0, 0])
        ttgo485();
}







