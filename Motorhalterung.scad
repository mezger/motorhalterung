$fn=100;
wand=3;
motord=40;
seite=10;
luecke=2;

translate([wand,0,motord+wand+luecke]) rotate([-90,0,0]) motorteil();
halter();

module motorteil()
{
    translate([wand,0,0]) motorplatte();
    motorplatteseitenteil();
    translate([wand+motord,0,0]) motorplatteseitenteil();
}

module motorplatte()
{
    difference()
    {
        cube([motord,motord,wand]);
        translate([motord/2,motord/2,0]) cylinder(d=13,h=wand);
        translate([motord/2-12.5,motord/2,0]) cylinder(d=3,h=wand);
        translate([motord/2+12.5,motord/2,0]) cylinder(d=3,h=wand);
    }
}

module motorplatteseitenteil()
{
    difference()
    {
        cube([wand,motord,seite]);
        translate([0,5,(seite-wand)/2+wand]) rotate([0,90,0]) cylinder(d=3,h=wand);
        translate([0,motord-5,(seite-wand)/2+wand]) rotate([0,90,0]) cylinder(d=3,h=wand);
    }
}

module halter()
{
    halterseitenteil();
    translate([wand,0,0]) halterplatte();
    translate([motord+3*wand,0,0]) halterseitenteil();
}

module halterplatte()
{
    x=motord+2*wand;
    y=motord+wand+luecke;
    difference()
    {
        cube([x, y, wand]);
        translate([x/2-12.5,y/2-12.5,0]) cylinder(d=3.5,h=wand);
        translate([x/2-12.5,y/2+12.5,0]) cylinder(d=3.5,h=wand);
        translate([x/2+12.5,y/2-12.5,0]) cylinder(d=3.5,h=wand);
        translate([x/2+12.5,y/2+12.5,0]) cylinder(d=3.5,h=wand);
    }
}

module halterseitenteil()
{
    rotate([0,90,0])
    difference()
    {
        //cube([motord,motord,wand]);
        sector(wand, 2*(motord+wand+luecke), 90, 180);
        translate([-motord-wand-luecke+5,(seite-wand)/2+wand,0]) halterausschnitte();
    }
}

module halterausschnitte()
{
    difference()
    {
        sector(wand, 2*(motord-10)+3, -5, 40);
        sector(wand, 2*(motord-10)-3, -5, 40);
    }
    cylinder(d=3,h=wand);
}

//cylinder sector https://gist.github.com/plumbum/78e3c8281e1c031601456df2aa8e37c6
module sector(h, d, a1, a2) 
{
    if (a2 - a1 > 180) 
    {
        difference() 
        {
            cylinder(h=h, d=d);
            translate([0,0,-0.5]) sector(h+1, d+1, a2-360, a1); 
        }
    } 
    else 
    {
        difference() 
        {
            cylinder(h=h, d=d);
            rotate([0,0,a1]) translate([-d/2, -d/2, -0.5]) cube([d, d/2, h+1]);
            rotate([0,0,a2]) translate([-d/2, 0, -0.5]) cube([d, d/2, h+1]);
        }
    }
}