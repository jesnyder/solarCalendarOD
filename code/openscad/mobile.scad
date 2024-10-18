
module holes(x, y, z, month){
    
    
    hole_radius = x/18/4;
    if (hole_radius > x/18/4) { hole_radius = x/14;};
    if (hole_radius < 2){ hole_radius = 2; };
    
    for ( i = [1 : 1 : month]) {
        translate([x - (i-1)*4*hole_radius , 0 , 4*hole_radius])
        rotate([90,0,0])
        cylinder(h = z*day, r1 = hole_radius, r2 = hole_radius, center = true, $fn=100);
        
        translate([x - (i-1)*4*hole_radius , 0 , 0])
        rotate([90,0,0])
        cylinder(h = z*day, r1 = hole_radius, r2 = hole_radius, center = true, $fn=100);
        }
        
    translate([x - 2*hole_radius , 0 , 8*hole_radius])
    rotate([90,0,0])
    cylinder(h = z*day, r1 = hole_radius, r2 = hole_radius, center = true, $fn=100);
        
    }


module panel(x, y, z){
    
    
    union () {
        cube(size = [x,y,z], center = false);
        
        translate([0,y/2,0])
        cylinder(h = z, r1 = y/2, r2 = y/2, center = false, $fn=100);
            
        translate([x,y/2,0])
        cylinder(h = z, r1 = y/2, r2 = y/2, center = false, $fn=100);
        
        }
    }
    
    
module arc(x, y, z, temp){
    
    radius = 2*(x) - temp * (x);
    
    y = 2*y;
    
    color([.20 , .20 , .20 , 0.25]) 
    
    
    difference(){
        
        translate([0,-y/4,0])
        
        panel(x, y, 2*z);
        
        translate([x , z/2 , z-radius])
        rotate([90,0,0])
        cylinder(h = z, r1 = radius, r2 = radius, center = false, $fn=100);
        
        //translate([x , 0 , z/2])
        //panel(x, 2*y, z/2);
        
        
        //translate([0 , -3*y/4 , -z/4])
        //panel(x, 2*y, z/2);
        
        }
    }



module cutout(x, y, z, temp){
    
    
    yy = y/3;
    xx = x*1/2*temp + 2*yy;
    translate([x - xx  , yy , 0 ])
    rotate([0,0,0])
    panel(xx, yy, z);
    
    }



module web(x, y, z, noon, day, month, precip, temp){
    
    
    
    translate([x/2,-y/2,0])
    rotate([0,0,0])
    
    
    difference () {
        
        color([0 , 0 , 1 , 0.75]) 
        panel(x, y, z);
        
        translate([x+y/2,0,z*noon])
        rotate([90,0,0])
        cylinder(h = z*day, r1 = z*day/2, r2 = z*day/2, center = true, $fn=100);
            
        holes(x, y, z, month);
        
        arc(x, y, z, temp);
        
        cutout(x, y, z, precip);
        
        ring(x, y, z, noon, day, month, precip, temp);
        

    
    }
}


module ring(x, y, z, noon, day, month, precip, temp){
    
    
    for (i = [0.1 : .1 : .4]) {
        
        rr = x/2+day*1/temp*1.1;
        xx = 15*y*i;
        yy = sqrt(rr*rr - xx*xx);
        
        translate([x - xx  , 0 , 1*z*.65+yy ])
        rotate([90,0,0])
        cylinder(h = z*day, r1 = y/2, r2 = y/2, center = true, $fn=200);
    } 
    
    }


x = 60; y = 5; z = x*2-1/4*x;
noon = 0.5; day = .6; month = 12;
precip = 1; temp = 1;
    
//arc(x, y, z, precip);
//cutout(x, y, z, temp);


torus_radius = x*1.43/2;

rotate_extrude(convexity = 100)
translate([torus_radius, z/3, 5])
circle(r = 10, $fn = 100);


j = 52;
for (i = [ 1 : 1 : 1]) {
    
    translate([0,0,0])
    rotate([0,0,i*360/j])
    
    web(x, y, z, noon, day, month, precip, temp);
    
    }






// begin python script inserts variables 


// end python script insertion of variable 