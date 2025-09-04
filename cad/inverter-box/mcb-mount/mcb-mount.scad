$fn = $preview ? 16 : 64;

teWidth = 17.8;
railDepth = 7.5;
railHeightInner = 27;
railHeightOuter = 35;

lssBodySize = [90, 50.5];

module dinrail(te){
    color("grey")
        linear_extrude(te*teWidth, center=true){
            points = [
                [0, 0],
                [railHeightOuter/2, 0],
                [railHeightOuter/2, -1.2],
                [railHeightInner/2, -1.8],
                [railHeightInner/2, -railDepth],
                [0, -railDepth],
            ];
            polygon(points);
            mirror([1,0])
                polygon(points);
        }
}

module lss(te){
    lssProtrusionSize = [45, 72];
    
    color("lightgrey")
        linear_extrude(te*teWidth, center=true){
            union(){
                translate([0, 0])
                    square(lssBodySize, center = true);
                translate([-lssProtrusionSize.x/2, -lssBodySize.y/2])
                    square(lssProtrusionSize);
            }
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

holderSize = [40, 15];

topCoverThickness = 2;
topCoverWidth = 30;

module lssHolder(te){
    holderHeight = teWidth * te;

    union()
    {
        translate([0,railDepth,holderHeight / 2])
            dinrail(te);

        difference() {
            union(){
                translate([0,0,holderHeight + topCoverThickness/2])
                    cube([holderSize.x, topCoverWidth, topCoverThickness], center = true);
                translate([0, -holderSize.y/2, holderHeight / 2])
                    cube([holderSize.x, holderSize.y, teWidth * te], center = true);
            }
            translate([holderSize.x/2 - holderSize.y/2, -holderSize.y/2, 10])
                hole(4.5, 8.5, 10.4, 0.2);
            translate([-(holderSize.x/2 - holderSize.y/2), -holderSize.y/2, 10])
                hole(4.5, 8.5, 10.4, 0.2);
        }
    }
}

caseTe = 2;

if($preview){
    difference(){
        lssHolder(caseTe);
        translate([0,-22.5,0])
            cube([60, 30, 100], center=true);
    }
} else {
    lssHolder(caseTe);
}

