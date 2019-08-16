hole_size = 3;
hole_spacing = 10;
material_thickness = 3;
stud_size = 3;
inner_bevel = 5;

function plate_size(holes) = hole_spacing  * holes ;

module plate(holes_w, holes_h)
{
    w = plate_size(holes_w);
    h = plate_size(holes_h);
    difference() {
        union() {
        cube([w,h, material_thickness],center=false);
            for (x=[0:holes_w-1]) {
                translate([x*hole_spacing + hole_spacing/2, hole_spacing/2, -stud_size])
                cylinder(d=hole_size, h = stud_size+material_thickness/2, $fn=32);
            }
        }
    
    for (x=[0:holes_w-1]) {
        for (y=[1:holes_h-1]) {
            translate([x*hole_spacing + hole_spacing/2,
                            y*hole_spacing + hole_spacing/2,
                            -material_thickness])
                cylinder(d=hole_size, h = material_thickness*3, $fn=32);
        }
    }
}
}

holes_x = 2;
holes_y_base = 4;
holes_y_side = 3;
union(){
plate(holes_x, holes_y_base);
rotate([90,0,180])
    translate([-plate_size(2),0,-material_thickness])
        plate(holes_x, holes_y_side);
translate([0, 0,material_thickness])
    {
       difference() {
           
            cube([plate_size(holes_x), inner_bevel, inner_bevel]);
           rotate([0,90,0])
           translate([-inner_bevel, inner_bevel, -1])
           cylinder(d=inner_bevel*2, h = plate_size(holes_x)+2, $fn=128);
       }
    }
}