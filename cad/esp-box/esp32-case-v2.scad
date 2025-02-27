$fn = $preview ? 16 : 64;

tolerance = 0.3;

rj45boardSize = [34.2+tolerance, 28+tolerance, 1.4+tolerance];
rj45holeDiameter = 2.8 - tolerance;
rj45holeWidthDistance = 28;
rj45hole1FrontPosition = -5.5;
rj45hole2FrontPosition = -16.5;

module rj45breakout()
{
    rj45jackCutout = 5;
    boardThickness = 1.6;
    rj45jackSize = [15.8, 18.3 + rj45jackCutout, 13.0];
    rj45jackBottomDepth = 2.5;
    rj45jackBottomExtraWidth = 4;
    
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
        translate([-rj45jackSize.x/2 - rj45jackBottomExtraWidth/2, -rj45jackSize.y, -boardThickness-rj45jackBottomDepth])
            color("grey")
            cube([rj45jackSize.x+rj45jackBottomExtraWidth, rj45jackSize.y, rj45jackBottomDepth]);
            
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

ttgo485Size = [35+tolerance, 81+tolerance];
ttgo485BoardThickness = 1.2;
ttgo485BoardTopMaxThickness = 3.3;
ttgo485BoardBottomMaxThickness = 2.5;

usbCSize = [7.4 + 10, 9.5+tolerance, 3.4+tolerance];
usbCPosY = 21.75-tolerance/2;
usbCPosX = 5.5;

connectorPins = 2.2;
connectorExtraLength = 3;

powerConnectorSize = [9, 9.2 + connectorExtraLength, ttgo485BoardThickness + 7.2];
powerConnectorPos = [9.5, 5 + connectorExtraLength, -ttgo485BoardThickness];

module ttgo485()
{    
    translate([-ttgo485Size.x/2, -ttgo485Size.y, -ttgo485BoardThickness])
        cube([ttgo485Size.x, ttgo485Size.y, ttgo485BoardThickness]);
        
    translate([-ttgo485Size.x/2 - powerConnectorSize.x + powerConnectorPos.x, -powerConnectorPos.y, powerConnectorPos.z])
        color("grey")
        minkowski()
        {
            union(){
                cube(powerConnectorSize);
                translate([0,0,-connectorPins])
                    cube([powerConnectorSize.x, powerConnectorPos.y, connectorPins]);
            }
            sphere(tolerance);
        }
    
    dataConnectorSize = [12.4, 9.2 + connectorExtraLength, ttgo485BoardThickness + 7.2];
    dataConnectorPos = [13.2, 5 + connectorExtraLength, -ttgo485BoardThickness];
    translate([ttgo485Size.x/2 - dataConnectorPos.x, -ttgo485Size.y - dataConnectorSize.y +dataConnectorPos.y, dataConnectorPos.z])
        color("grey")
        minkowski()
        {
            union(){
                cube(dataConnectorSize);
                translate([0,dataConnectorSize.y - dataConnectorPos.y,-connectorPins])
                    cube([dataConnectorSize.x, dataConnectorPos.y, connectorPins]);
            }
            sphere(tolerance);
        }
    
    translate([-ttgo485Size.x/2 + dataConnectorPos.x - dataConnectorSize.x, -ttgo485Size.y - dataConnectorSize.y +dataConnectorPos.y, dataConnectorPos.z])
        color("grey")
        minkowski()
        {
            union(){
                cube(dataConnectorSize);
                translate([0,dataConnectorSize.y - dataConnectorPos.y,-connectorPins])
                    cube([dataConnectorSize.x, dataConnectorPos.y, connectorPins]);
            }
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

caseSize = [ttgo485Size.x, ttgo485Size.y, 20];
caseThickness = 2;
module case()
{
    //ttgo485cutout
    
    ttgo485Holder1Width = 12;
    ttgo485Holder1Thickness = 4;
    
    ttgo485Holder2Width = 7;
    ttgo485Holder2Thickness = 4;
    
    
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
            translate([-ttgo485Holder1Width/2, ttgo485Size.y-ttgo485Holder1Thickness, boardPosZ])
                cube([ttgo485Holder1Width, ttgo485Holder1Thickness, caseSize.z - boardPosZ]);
            translate([-ttgo485Holder2Width/2, 0, boardPosZ])
                cube([ttgo485Holder2Width, ttgo485Holder2Thickness, caseSize.z - boardPosZ]);
        }

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
        cube([diffPartWidth, diffPartLength, 5]);

    translate([-ttgo485Size.x/2 - powerConnectorSize.x + powerConnectorPos.x, caseSize.y-powerConnectorPos.y, boardPosZ + ttgo485BoardThickness + powerConnectorPos.z])
        minkowski()
        {
            cube([powerConnectorSize.x, powerConnectorSize.y, 25]);
            sphere(tolerance);
        }
    
    translate([-diffPartInnerWidth/2,-innerEdge/2,caseSize.z - 2])
        cube([diffPartInnerWidth, diffPartInnerLength, 5]);
    
    translate([-caseSize.x/2,0,boardPosZ + ttgo485BoardThickness])
        cube([caseSize.x, ttgo485Size.y, caseSize.z]);
    
    translate([-ttgo485Size.x/2 - usbCSize.x + usbCPosX, ttgo485Size.y -usbCSize.y + -usbCPosY + 0.01, boardPosZ + ttgo485BoardThickness+0.01])
        cube([usbCSize.x, usbCSize.y -0.02, caseSize.z]);
}

if($preview){
    difference()
    {
        case();
        translate([-12, -5, caseSize.z - 5])
            cube(caseSize*2);
    }
    translate([50,0,0])
        color("red", 1)
        diffPart();
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







