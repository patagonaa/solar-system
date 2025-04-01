$fn = $preview ? 16 : 64;

// V2 gedruckt am 27.02.2025
// V2.1:
// - USB-C-Position noch bisschen korrigiert
// - Position der Buchsen gefixt (fangen auf Oberseite vom Board an, nicht Unterseite)
// - Gesamthöhe reduziert (war für die Ethernet-Buchse so hoch)
// V2.2:
// - Beschriftung

tolerance = 0.3;

ttgo485Size = [35+tolerance, 81+tolerance];
ttgo485BoardThickness = 1.2;
ttgo485BoardTopMaxThickness = 3.3;
ttgo485BoardBottomMaxThickness = 2.5;

usbCSize = [7.4 + 10, 9.5+tolerance, 3.4+tolerance];
usbCPosY = 22-tolerance/2;
usbCPosX = 5.5;

connectorPins = 2.2;
connectorExtraLength = 3;

powerConnectorSize = [9, 9.2 + connectorExtraLength, 7.2];
powerConnectorPos = [9.5, 5 + connectorExtraLength, 0];

dataConnectorSize = [12.4, 9.2 + connectorExtraLength, 7.2];
dataConnectorPos = [13.2, 5 + connectorExtraLength, 0];

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
                translate([0,0,-connectorPins - ttgo485BoardThickness])
                    cube([powerConnectorSize.x, powerConnectorPos.y, connectorPins + ttgo485BoardThickness]);
            }
            sphere(tolerance);
        }

    translate([ttgo485Size.x/2 - dataConnectorPos.x, -ttgo485Size.y - dataConnectorSize.y +dataConnectorPos.y, dataConnectorPos.z])
        color("grey")
        minkowski()
        {
            union(){
                cube(dataConnectorSize);
                translate([0,dataConnectorSize.y - dataConnectorPos.y,-connectorPins - ttgo485BoardThickness])
                    cube([dataConnectorSize.x, dataConnectorPos.y, connectorPins + ttgo485BoardThickness]);
            }
            sphere(tolerance);
        }
    
    translate([-ttgo485Size.x/2 + dataConnectorPos.x - dataConnectorSize.x, -ttgo485Size.y - dataConnectorSize.y +dataConnectorPos.y, dataConnectorPos.z])
        color("grey")
        minkowski()
        {
            union(){
                cube(dataConnectorSize);
                translate([0,dataConnectorSize.y - dataConnectorPos.y,-connectorPins - ttgo485BoardThickness])
                    cube([dataConnectorSize.x, dataConnectorPos.y, connectorPins + ttgo485BoardThickness]);
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

caseSize = [ttgo485Size.x, ttgo485Size.y, 16];
caseThickness = 2;
module case()
{
    //ttgo485cutout
    
    ttgo485Holder1Width = 12;
    ttgo485Holder1Thickness = 4;
    
    ttgo485Holder2Width = 7;
    ttgo485Holder2Thickness = 4;
    
    ttgo485TextDepth = 0.5;
    
    
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
            
        translate([
            caseSize.x/2 - dataConnectorPos.x + dataConnectorSize.x/2,
            0,
            caseSize.z + caseThickness - ttgo485TextDepth])
        {
            translate([-4,0.5,0])
                rotate([0,0,90])
                linear_extrude(ttgo485TextDepth + 0.01)
                {
                    text("A", font="Liberation Mono:bold", size=5, halign="left", valign="center");
                }
            translate([0,7,0])
                rotate([0,0,90])
                linear_extrude(ttgo485TextDepth + 0.01)
                {
                    text("485", font="Liberation Mono:bold", size=5, halign="left", valign="center");
                }
            translate([4,0.5,0])
                rotate([0,0,90])
                linear_extrude(ttgo485TextDepth + 0.01)
                {
                    text("B", font="Liberation Mono:bold", size=5, halign="left", valign="center");
                }
        }
        translate([
            -caseSize.x/2 + dataConnectorPos.x - dataConnectorSize.x/2,
            0,
            caseSize.z + caseThickness - ttgo485TextDepth])
        {
            translate([-4,0.5,0])
                rotate([0,0,90])
                linear_extrude(ttgo485TextDepth + 0.01)
                {
                    text("L", font="Liberation Mono:bold", size=5, halign="left", valign="center");
                }
            translate([0,7,0])
                rotate([0,0,90])
                linear_extrude(ttgo485TextDepth + 0.01)
                {
                    text("CAN", font="Liberation Mono:bold", size=5, halign="left", valign="center");
                }
            translate([4,0.5,0])
                rotate([0,0,90])
                linear_extrude(ttgo485TextDepth + 0.01)
                {
                    text("H", font="Liberation Mono:bold", size=5, halign="left", valign="center");
                }
        }
        translate([
            -caseSize.x/2 + powerConnectorPos.x - powerConnectorSize.x/2,
            caseSize.y,
            caseSize.z + caseThickness - ttgo485TextDepth])
        {
            translate([-3,-0.5,0])
                rotate([0,0,90])
                linear_extrude(ttgo485TextDepth + 0.01)
                {
                    text("–", font="Liberation Mono:bold", size=5, halign="right", valign="center");
                }
            translate([0,-7,0])
                rotate([0,0,90])
                linear_extrude(ttgo485TextDepth + 0.01)
                {
                    text("PWR", font="Liberation Mono:bold", size=5, halign="right", valign="center");
                }
            translate([3,-0.5,0])
                rotate([0,0,90])
                linear_extrude(ttgo485TextDepth + 0.01)
                {
                    text("+", font="Liberation Mono:bold", size=5, halign="right", valign="center");
                }
        }
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
//        translate([-12, -5, caseSize.z - 5])
//            cube(caseSize*2);
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


translate([-45, 0, caseSize.z])
    rotate([180,0,180])
    intersection()
    {
        case();
        diffPart();
    }

//diffPart();

if($preview)
{
    translate([0, ttgo485Size.y, boardPosZ + ttgo485BoardThickness])
        ttgo485();

    translate([80, 0, 0])
        ttgo485();
}







