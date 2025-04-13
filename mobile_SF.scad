module holes(x, y, z, month){
    
    
    hole_radius = x/13/4;
    if (hole_radius > x/18/4) { hole_radius = x/14;};
    if (hole_radius < 2){ hole_radius = 2; };
    
    for ( i = [1 : 1 : month]) {
        
        //translate([x - (i-1)*4*hole_radius , 0 , 4*hole_radius])
        //rotate([90,0,0])
        //cylinder(h = z*day, r1 = hole_radius, r2 = hole_radius, center = true, $fn=100);
        
        //translate([x - (i-1)*4*hole_radius , 0 , 0])
        //rotate([90,0,0])
        //cylinder(h = z*day, r1 = hole_radius, r2 = hole_radius, center = true, $fn=100);
        
        translate([x - (i-1)*4*hole_radius -2*hole_radius, -hole_radius*3, i*hole_radius*1.5+2*hole_radius])
        rotate([0, 90, 90])
        panel(x, 2*hole_radius, hole_radius*10);
        
        }
        
    translate([x - 2*hole_radius - 3*hole_radius , 0 , 8*hole_radius])
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
    
    temp_adjusted = temp*0.95;
    
    radius = 2*(x) - temp_adjusted * (x);
    
    y = 2*y;
    
    color([.20 , .20 , .20 , 0.25]) 
    
    
    difference(){
        
        translate([0,-y/4,0])
        
        panel(x, y, 2*z);
        
        translate([x , z/2 , z-radius])
        rotate([90,0,0])
        cylinder(h = z, r1 = radius, r2 = radius, center = false, $fn=500);
        
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
    
    
    for (i = [0.1 : .1 : .3]) {
        
        rr = x/2+day*1/temp*5;
        xx = 15*y*i;
        yy = sqrt(rr*rr - xx*xx);
        
        translate([x - xx  , 0 , 1*z*.65+yy ])
        rotate([90,0,0])
        cylinder(h = z*day, r1 = y/2, r2 = y/2, center = true, $fn=200);
    } 
    
    }


x = 60; y = 5; z = x*2;
noon = 0.5; day = .75; month = 12;
precip = 1; temp = 1;
    
//arc(x, y, z, precip);
//cutout(x, y, z, temp);


torus_radius = x*1.43/2;

rotate_extrude(convexity = 100)
translate([torus_radius, z/3, 5])
circle(r = 8, $fn = 100);


//j = 52;
//for (i = [ 1 : 1 : 1]) {
    
    //translate([0,0,0])
    //rotate([0,0,i*360/j])
    
    //web(x, y, z, noon, day, month, precip, temp);
    
 //}






// begin python script inserts variables 

// 2023-10-01 
// Temperature = 20.67142857142857 | i = 1.0 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 0.0])
web(x, y, z, 0.541 , 0.4917 , 10 ,  0.0 , 1.0 ); 


// 2023-10-08 
// Temperature = 18.1 | i = 0.7574 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 6.9231])
web(x, y, z, 0.5396 , 0.4799 , 10 ,  0.0 , 0.7574 ); 


// 2023-10-15 
// Temperature = 18.87142857142857 | i = 0.8302 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 13.8462])
web(x, y, z, 0.5382 , 0.4681 , 10 ,  0.0 , 0.8302 ); 


// 2023-10-22 
// Temperature = 16.014285714285712 | i = 0.5606 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 20.7692])
web(x, y, z, 0.5375 , 0.4569 , 10 ,  0.0 , 0.5606 ); 


// 2023-10-29 
// Temperature = 17.1 | i = 0.6631 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 27.6923])
web(x, y, z, 0.5368 , 0.4465 , 10 ,  0.0 , 0.6631 ); 


// 2023-11-05 
// Temperature = 15.814285714285717 | i = 0.5418 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 1.0 | i = 0.0337 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 34.6154])
web(x, y, z, 0.4951 , 0.4361 , 11 ,  0.0217 , 0.5418 ); 


// 2023-11-12 
// Temperature = 16.414285714285715 | i = 0.5984 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 41.5385])
web(x, y, z, 0.4951 , 0.4264 , 11 ,  0.4508 , 0.5984 ); 


// 2023-11-19 
// Temperature = 14.414285714285716 | i = 0.4097 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 48.4615])
web(x, y, z, 0.4965 , 0.4181 , 11 ,  0.0 , 0.4097 ); 


// 2023-11-26 
// Temperature = 13.257142857142856 | i = 0.3005 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 55.3846])
web(x, y, z, 0.4979 , 0.4111 , 11 ,  0.1469 , 0.3005 ); 


// 2023-12-03 
// Temperature = 13.271428571428572 | i = 0.3019 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 62.3077])
web(x, y, z, 0.4993 , 0.4049 , 12 ,  0.0518 , 0.3019 ); 


// 2023-12-10 
// Temperature = 12.314285714285717 | i = 0.2116 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 69.2308])
web(x, y, z, 0.5014 , 0.4007 , 12 ,  0.0 , 0.2116 ); 


// 2023-12-17 
// Temperature = 14.2 | i = 0.3895 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 1.8 | i = 0.0607 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 76.1538])
web(x, y, z, 0.5035 , 0.3986 , 12 ,  1.0 , 0.3895 ); 


// 2023-12-24 
// Temperature = 12.914285714285716 | i = 0.2682 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 83.0769])
web(x, y, z, 0.5062 , 0.3979 , 12 ,  0.5893 , 0.2682 ); 


// 2023-12-31 
// Temperature = 12.042857142857144 | i = 0.186 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 90.0])
web(x, y, z, 0.5083 , 0.4 , 12 ,  0.2471 , 0.186 ); 


// 2024-01-07 
// Temperature = 10.071428571428571 | i = 0.0 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 96.9231])
web(x, y, z, 0.5104 , 0.4035 , 1 ,  0.3656 , 0.0 ); 


// 2024-01-14 
// Temperature = 12.171428571428573 | i = 0.1981 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 1.0 | i = 0.0337 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 103.8462])
web(x, y, z, 0.5125 , 0.4097 , 1 ,  0.4157 , 0.1981 ); 


// 2024-01-21 
// Temperature = 13.142857142857142 | i = 0.2898 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 10.2 | i = 0.3434 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 110.7692])
web(x, y, z, 0.5146 , 0.416 , 1 ,  0.6277 , 0.2898 ); 


// 2024-01-28 
// Temperature = 13.171428571428573 | i = 0.2925 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 117.6923])
web(x, y, z, 0.5153 , 0.425 , 1 ,  0.9549 , 0.2925 ); 


// 2024-02-04 
// Temperature = 10.742857142857144 | i = 0.0633 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 29.7 | i = 1.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 124.6154])
web(x, y, z, 0.516 , 0.434 , 2 ,  0.6694 , 0.0633 ); 


// 2024-02-11 
// Temperature = 11.514285714285714 | i = 0.1361 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 131.5385])
web(x, y, z, 0.5167 , 0.4444 , 2 ,  0.2087 , 0.1361 ); 


// 2024-02-18 
// Temperature = 12.828571428571427 | i = 0.2601 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 8.1 | i = 0.2727 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 138.4615])
web(x, y, z, 0.516 , 0.4556 , 2 ,  0.4658 , 0.2601 ); 


// 2024-02-25 
// Temperature = 12.4 | i = 0.2197 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 145.3846])
web(x, y, z, 0.516 , 0.4667 , 2 ,  0.6845 , 0.2197 ); 


// 2024-03-03 
// Temperature = 11.457142857142856 | i = 0.1307 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 4.6 | i = 0.1549 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 152.3077])
web(x, y, z, 0.5146 , 0.4778 , 3 ,  0.2287 , 0.1307 ); 


// 2024-03-10 
// Temperature = 13.985714285714286 | i = 0.3693 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 1.5 | i = 0.0505 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 159.2308])
web(x, y, z, 0.5556 , 0.4903 , 3 ,  0.1002 , 0.3693 ); 


// 2024-03-17 
// Temperature = 13.5 | i = 0.3235 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 166.1538])
web(x, y, z, 0.5542 , 0.5021 , 3 ,  0.1185 , 0.3235 ); 


// 2024-03-24 
// Temperature = 12.214285714285714 | i = 0.2022 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 3.3 | i = 0.1112 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 173.0769])
web(x, y, z, 0.5528 , 0.5139 , 3 ,  0.4624 , 0.2022 ); 


// 2024-03-31 
// Temperature = 12.214285714285714 | i = 0.2022 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 180.0])
web(x, y, z, 0.5507 , 0.525 , 3 ,  0.212 , 0.2022 ); 


// 2024-04-07 
// Temperature = 13.214285714285714 | i = 0.2965 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 186.9231])
web(x, y, z, 0.5493 , 0.5375 , 4 ,  0.0935 , 0.2965 ); 


// 2024-04-14 
// Temperature = 13.728571428571428 | i = 0.345 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 1.3 | i = 0.0437 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 193.8462])
web(x, y, z, 0.5486 , 0.5486 , 4 ,  0.0217 , 0.345 ); 


// 2024-04-21 
// Temperature = 14.814285714285717 | i = 0.4474 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 200.7692])
web(x, y, z, 0.5472 , 0.5597 , 4 ,  0.0 , 0.4474 ); 


// 2024-04-28 
// Temperature = 13.814285714285717 | i = 0.3531 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 207.6923])
web(x, y, z, 0.5465 , 0.5701 , 4 ,  0.4023 , 0.3531 ); 


// 2024-05-05 
// Temperature = 16.1 | i = 0.5687 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 214.6154])
web(x, y, z, 0.5458 , 0.5806 , 5 ,  0.0 , 0.5687 ); 


// 2024-05-12 
// Temperature = 14.8 | i = 0.4461 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 221.5385])
web(x, y, z, 0.5458 , 0.5896 , 5 ,  0.0 , 0.4461 ); 


// 2024-05-19 
// Temperature = 14.642857142857142 | i = 0.4313 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 228.4615])
web(x, y, z, 0.5458 , 0.5979 , 5 ,  0.0 , 0.4313 ); 


// 2024-05-26 
// Temperature = 15.514285714285714 | i = 0.5135 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 235.3846])
web(x, y, z, 0.5458 , 0.6042 , 5 ,  0.0 , 0.5135 ); 


// 2024-06-02 
// Temperature = 16.0 | i = 0.5593 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 242.3077])
web(x, y, z, 0.5465 , 0.6097 , 6 ,  0.0 , 0.5593 ); 


// 2024-06-09 
// Temperature = 15.214285714285714 | i = 0.4852 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 249.2308])
web(x, y, z, 0.5479 , 0.6132 , 6 ,  0.0 , 0.4852 ); 


// 2024-06-16 
// Temperature = 14.357142857142858 | i = 0.4043 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 256.1538])
web(x, y, z, 0.5486 , 0.6153 , 6 ,  0.0 , 0.4043 ); 


// 2024-06-23 
// Temperature = 15.171428571428573 | i = 0.4811 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 263.0769])
web(x, y, z, 0.55 , 0.616 , 6 ,  0.0 , 0.4811 ); 


// 2024-06-30 
// Temperature = 18.97142857142857 | i = 0.8396 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 270.0])
web(x, y, z, 0.5507 , 0.6139 , 6 ,  0.0 , 0.8396 ); 


// 2024-07-07 
// Temperature = 16.914285714285715 | i = 0.6456 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 276.9231])
web(x, y, z, 0.5514 , 0.6104 , 7 ,  0.0 , 0.6456 ); 


// 2024-07-14 
// Temperature = 16.557142857142857 | i = 0.6119 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 283.8462])
web(x, y, z, 0.5521 , 0.6056 , 7 ,  0.0 , 0.6119 ); 


// 2024-07-21 
// Temperature = 16.571428571428573 | i = 0.6132 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 290.7692])
web(x, y, z, 0.5528 , 0.5986 , 7 ,  0.0 , 0.6132 ); 


// 2024-07-28 
// Temperature = 15.328571428571427 | i = 0.496 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 297.6923])
web(x, y, z, 0.5528 , 0.591 , 7 ,  0.0 , 0.496 ); 


// 2024-08-04 
// Temperature = 15.8 | i = 0.5404 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 304.6154])
web(x, y, z, 0.5521 , 0.5819 , 8 ,  0.0 , 0.5404 ); 


// 2024-08-11 
// Temperature = 15.528571428571428 | i = 0.5148 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 311.5385])
web(x, y, z, 0.5521 , 0.5722 , 8 ,  0.0 , 0.5148 ); 


// 2024-08-18 
// Temperature = 16.571428571428573 | i = 0.6132 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 318.4615])
web(x, y, z, 0.5507 , 0.5618 , 8 ,  0.0417 , 0.6132 ); 


// 2024-08-25 
// Temperature = 17.771428571428572 | i = 0.7264 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 325.3846])
web(x, y, z, 0.5493 , 0.5507 , 8 ,  0.0 , 0.7264 ); 


// 2024-09-01 
// Temperature = 16.485714285714288 | i = 0.6051 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 332.3077])
web(x, y, z, 0.5479 , 0.5396 , 9 ,  0.0 , 0.6051 ); 


// 2024-09-08 
// Temperature = 14.87142857142857 | i = 0.4528 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 339.2308])
web(x, y, z, 0.5465 , 0.5285 , 9 ,  0.0 , 0.4528 ); 


// 2024-09-15 
// Temperature = 15.12857142857143 | i = 0.4771 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 346.1538])
web(x, y, z, 0.5444 , 0.5174 , 9 ,  0.0 , 0.4771 ); 


// 2024-09-22 
// Temperature = 17.142857142857142 | i = 0.6671 | Max = 20.67142857142857 | Min = 10.071428571428571  
// Precipitation = 0.0 | i = 0.0 | Max = 29.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 353.0769])
web(x, y, z, 0.5431 , 0.5056 , 9 ,  0.0 , 0.6671 ); 

// end python script insertion of variable 