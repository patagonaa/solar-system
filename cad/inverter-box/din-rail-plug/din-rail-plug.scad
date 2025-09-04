$fn = $preview ? 16 : 64;

teWidth = 17.8;
slotHeight = 45.4;

plateThickness = 5.4;
topBottomOverlap = 2;
insideThickness = 2.5;
outsideThickness = 1.5;

tabThickness = 4;
tabDepth = 12;
tabNoseLength = 1.5;

module tab()
{
    translate([outsideThickness/2, 0])
    {
        square([outsideThickness, slotHeight + topBottomOverlap*2], center = true);
    }
    translate([-tabDepth/2, slotHeight/2 - tabThickness/2])
    {
        square([tabDepth, tabThickness], center = true);
    }

    translate([-plateThickness, slotHeight/2])
    polygon([[-(tabDepth-plateThickness),0], [0, tabNoseLength], [0, 0]]);
}
linear_extrude(teWidth)
{
    translate([-insideThickness/2, 0])
    {
        square([insideThickness, slotHeight], center = true);
    }
    
    mirror([0,1,0])
    {
        tab();
    }
    tab();
}