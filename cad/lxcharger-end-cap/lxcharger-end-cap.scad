$fn = $preview ? 16 : 64;

// for LXCHARGER H65AC

profileSize = [33.6, 15.5];
profileSizeInner = [29.2, 11.4];

module profileCorner(){
    polygon([
        [0, profileSize.y/2],
        [profileSizeInner.x/2, profileSize.y/2],
        [profileSize.x/2, profileSizeInner.y/2],
        [profileSize.x/2, 0],
        [0,0]
        ]);
}

module profile(){
    profileCorner();
    mirror([1,0])
        profileCorner();
    mirror([0,1]){
        profileCorner();
        mirror([1,0])
            profileCorner();
    }
}

module hole(holeDiameter, headDiameter, topDiameter, extraSink)
{
    cylinder(h=100, d=topDiameter);
    translate([0,0,-100])
    cylinder(h=100, d=holeDiameter);
    translate([0, 0, -((headDiameter-holeDiameter)/2*1.14)- extraSink])
        cylinder(h=(headDiameter-holeDiameter)/2*1.14, d1=holeDiameter, d2=headDiameter);
    translate([0, 0, -extraSink-0.01])
        cylinder(h=extraSink+0.02, d=headDiameter);
}

capDepth = 1.5;

holeYOffset = 0.3;
holeDistance = 30;
holeDiameter = 2.2;

xt30Size = [10, 5];
xt30Pos = [5.1, 3.1];
xt30Clearance = 0.3;

module cap(){
    difference()
    {
        linear_extrude(capDepth)
            profile();
        translate([holeDistance/2, holeYOffset, capDepth])
            hole(holeDiameter,3.2,holeDiameter,0.3);
        translate([-holeDistance/2, holeYOffset, capDepth])
            hole(holeDiameter,3.2,holeDiameter,0.3);
        translate([-profileSize.x/2 + xt30Pos.x, -profileSize.y/2 + xt30Pos.y, -0.01])
            minkowski(){
                cube([xt30Size.x, xt30Size.y, 5]);
                sphere(r=xt30Clearance);
            }
    }
}

cap();