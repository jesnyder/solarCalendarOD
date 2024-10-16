
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
    xx = x*1/2*sqrt(temp) + 2*yy;
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
    
    
    for (i = [0 : .2 : 0]) {
        
        translate([x - 6*y , 0 , z-4*y ])
        rotate([90,0,0])
        cylinder(h = z*day, r1 = y*2/3, r2 = y*2/3, center = true, $fn=200);
    } 
    
    }


x = 60; y = 5; z = x*2-1/4*x;
noon = 0.5; day = .8; month = 12;
precip = 1; temp = 1.0;
    
//arc(x, y, z, precip);
//cutout(x, y, z, temp);


torus_radius = x*1.43/2;

rotate_extrude(convexity = 100)
translate([torus_radius, z/3, 5])
circle(r = 10, $fn = 100);


//j = 52;
//for (i = [ 1 : 1 : 1]) {
    
    //translate([0,0,0])
    //rotate([0,0,i*360/j])
    
    //web(x, y, z, noon, day, month, precip, temp);
    
 //}






// begin python script inserts variables 

// 2023-10-01 
// Temperature = 17.3 | i = 0.7056 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 0.0])
web(x, y, z, 0.5299 , 0.4896 , 10 ,  0.0 , 0.7056 ); 


// 2023-10-08 
// Temperature = 12.3 | i = 0.5597 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 6.9231])
web(x, y, z, 0.5278 , 0.4771 , 10 ,  0.0 , 0.5597 ); 


// 2023-10-15 
// Temperature = 11.5 | i = 0.5364 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 13.8462])
web(x, y, z, 0.5271 , 0.4632 , 10 ,  0.0 , 0.5364 ); 


// 2023-10-22 
// Temperature = 11.6 | i = 0.5394 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 20.7692])
web(x, y, z, 0.5257 , 0.4507 , 10 ,  0.0 , 0.5394 ); 


// 2023-10-29 
// Temperature = 11.0 | i = 0.5219 | Max = 27.4 | Min = -6.9  
// Precipitation = 19.1 | i = 0.5841 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 27.6923])
web(x, y, z, 0.525 , 0.4382 , 10 ,  0.5841 , 0.5219 ); 


// 2023-11-05 
// Temperature = 10.1 | i = 0.4956 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.8 | i = 0.0244 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 34.6154])
web(x, y, z, 0.4833 , 0.4271 , 11 ,  0.0244 , 0.4956 ); 


// 2023-11-12 
// Temperature = 1.3 | i = 0.239 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 41.5385])
web(x, y, z, 0.484 , 0.4153 , 11 ,  0.0 , 0.239 ); 


// 2023-11-19 
// Temperature = 5.5 | i = 0.3615 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 48.4615])
web(x, y, z, 0.4847 , 0.4062 , 11 ,  0.0 , 0.3615 ); 


// 2023-11-26 
// Temperature = 3.6 | i = 0.3061 | Max = 27.4 | Min = -6.9  
// Precipitation = 11.1 | i = 0.3394 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 55.3846])
web(x, y, z, 0.4861 , 0.3972 , 11 ,  0.3394 , 0.3061 ); 


// 2023-12-03 
// Temperature = 7.9 | i = 0.4315 | Max = 27.4 | Min = -6.9  
// Precipitation = 12.8 | i = 0.3915 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 62.3077])
web(x, y, z, 0.4875 , 0.3903 , 12 ,  0.3915 , 0.4315 ); 


// 2023-12-10 
// Temperature = 11.8 | i = 0.5452 | Max = 27.4 | Min = -6.9  
// Precipitation = 17.0 | i = 0.5198 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 69.2308])
web(x, y, z, 0.4896 , 0.3861 , 12 ,  0.5198 , 0.5452 ); 


// 2023-12-17 
// Temperature = 9.3 | i = 0.4723 | Max = 27.4 | Min = -6.9  
// Precipitation = 13.3 | i = 0.4068 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 76.1538])
web(x, y, z, 0.4924 , 0.3826 , 12 ,  0.4068 , 0.4723 ); 


// 2023-12-24 
// Temperature = 4.5 | i = 0.3324 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 83.0769])
web(x, y, z, 0.4944 , 0.3826 , 12 ,  0.0 , 0.3324 ); 


// 2023-12-31 
// Temperature = 3.8 | i = 0.3119 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 90.0])
web(x, y, z, 0.4965 , 0.3847 , 12 ,  0.0 , 0.3119 ); 


// 2024-01-07 
// Temperature = 1.6 | i = 0.2478 | Max = 27.4 | Min = -6.9  
// Precipitation = 6.9 | i = 0.2111 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 96.9231])
web(x, y, z, 0.4993 , 0.3896 , 1 ,  0.2111 , 0.2478 ); 


// 2024-01-14 
// Temperature = 0.7 | i = 0.2215 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.1 | i = 0.0031 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 103.8462])
web(x, y, z, 0.5007 , 0.3951 , 1 ,  0.0031 , 0.2215 ); 


// 2024-01-21 
// Temperature = -6.9 | i = 0.0 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 110.7692])
web(x, y, z, 0.5028 , 0.4035 , 1 ,  0.0 , 0.0 ); 


// 2024-01-28 
// Temperature = 3.4 | i = 0.3003 | Max = 27.4 | Min = -6.9  
// Precipitation = 32.7 | i = 1.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 117.6923])
web(x, y, z, 0.5042 , 0.4132 , 1 ,  1.0 , 0.3003 ); 


// 2024-02-04 
// Temperature = 2.4 | i = 0.2711 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 124.6154])
web(x, y, z, 0.5049 , 0.4243 , 2 ,  0.0 , 0.2711 ); 


// 2024-02-11 
// Temperature = 6.0 | i = 0.376 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 131.5385])
web(x, y, z, 0.5049 , 0.4354 , 2 ,  0.0 , 0.376 ); 


// 2024-02-18 
// Temperature = -2.2 | i = 0.137 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 138.4615])
web(x, y, z, 0.5049 , 0.4479 , 2 ,  0.0 , 0.137 ); 


// 2024-02-25 
// Temperature = -1.8 | i = 0.1487 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 145.3846])
web(x, y, z, 0.5042 , 0.4611 , 2 ,  0.0 , 0.1487 ); 


// 2024-03-03 
// Temperature = 11.6 | i = 0.5394 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.2 | i = 0.0062 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 152.3077])
web(x, y, z, 0.5035 , 0.4743 , 3 ,  0.0062 , 0.5394 ); 


// 2024-03-10 
// Temperature = 6.5 | i = 0.3907 | Max = 27.4 | Min = -6.9  
// Precipitation = 17.0 | i = 0.5198 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 159.2308])
web(x, y, z, 0.5438 , 0.4882 , 3 ,  0.5198 , 0.3907 ); 


// 2024-03-17 
// Temperature = 10.7 | i = 0.5131 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.2 | i = 0.0062 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 166.1538])
web(x, y, z, 0.5424 , 0.5014 , 3 ,  0.0062 , 0.5131 ); 


// 2024-03-24 
// Temperature = 2.0 | i = 0.2595 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 173.0769])
web(x, y, z, 0.541 , 0.5146 , 3 ,  0.0 , 0.2595 ); 


// 2024-03-31 
// Temperature = 10.6 | i = 0.5102 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 180.0])
web(x, y, z, 0.5396 , 0.5285 , 3 ,  0.0 , 0.5102 ); 


// 2024-04-07 
// Temperature = 7.8 | i = 0.4286 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 186.9231])
web(x, y, z, 0.5382 , 0.5424 , 4 ,  0.0 , 0.4286 ); 


// 2024-04-14 
// Temperature = 12.9 | i = 0.5773 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.3 | i = 0.0091 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 193.8462])
web(x, y, z, 0.5368 , 0.5549 , 4 ,  0.0091 , 0.5773 ); 


// 2024-04-21 
// Temperature = 7.2 | i = 0.411 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 200.7692])
web(x, y, z, 0.5354 , 0.5674 , 4 ,  0.0 , 0.411 ); 


// 2024-04-28 
// Temperature = 16.0 | i = 0.6676 | Max = 27.4 | Min = -6.9  
// Precipitation = 1.4 | i = 0.0428 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 207.6923])
web(x, y, z, 0.5347 , 0.5792 , 4 ,  0.0428 , 0.6676 ); 


// 2024-05-05 
// Temperature = 10.2 | i = 0.4986 | Max = 27.4 | Min = -6.9  
// Precipitation = 16.6 | i = 0.5076 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 214.6154])
web(x, y, z, 0.534 , 0.591 , 5 ,  0.5076 , 0.4986 ); 


// 2024-05-12 
// Temperature = 10.6 | i = 0.5102 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.4 | i = 0.0122 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 221.5385])
web(x, y, z, 0.534 , 0.6014 , 5 ,  0.0122 , 0.5102 ); 


// 2024-05-19 
// Temperature = 18.7 | i = 0.7464 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 228.4615])
web(x, y, z, 0.534 , 0.6111 , 5 ,  0.0 , 0.7464 ); 


// 2024-05-26 
// Temperature = 23.0 | i = 0.8718 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 235.3846])
web(x, y, z, 0.5347 , 0.6187 , 5 ,  0.0 , 0.8718 ); 


// 2024-06-02 
// Temperature = 21.1 | i = 0.8163 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 242.3077])
web(x, y, z, 0.5354 , 0.6257 , 6 ,  0.0 , 0.8163 ); 


// 2024-06-09 
// Temperature = 18.3 | i = 0.7347 | Max = 27.4 | Min = -6.9  
// Precipitation = 2.7 | i = 0.0824 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 249.2308])
web(x, y, z, 0.5361 , 0.6299 , 6 ,  0.0824 , 0.7347 ); 


// 2024-06-16 
// Temperature = 18.9 | i = 0.7522 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 256.1538])
web(x, y, z, 0.5368 , 0.6319 , 6 ,  0.0 , 0.7522 ); 


// 2024-06-23 
// Temperature = 26.2 | i = 0.965 | Max = 27.4 | Min = -6.9  
// Precipitation = 6.4 | i = 0.1958 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 263.0769])
web(x, y, z, 0.5382 , 0.6326 , 6 ,  0.1958 , 0.965 ); 


// 2024-06-30 
// Temperature = 25.2 | i = 0.9359 | Max = 27.4 | Min = -6.9  
// Precipitation = 6.3 | i = 0.1926 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 270.0])
web(x, y, z, 0.5389 , 0.6306 , 6 ,  0.1926 , 0.9359 ); 


// 2024-07-07 
// Temperature = 27.4 | i = 1.0 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.1 | i = 0.0031 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 276.9231])
web(x, y, z, 0.5403 , 0.6264 , 7 ,  0.0031 , 1.0 ); 


// 2024-07-14 
// Temperature = 26.7 | i = 0.9797 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 283.8462])
web(x, y, z, 0.541 , 0.6208 , 7 ,  0.0 , 0.9797 ); 


// 2024-07-21 
// Temperature = 25.5 | i = 0.9447 | Max = 27.4 | Min = -6.9  
// Precipitation = 1.3 | i = 0.0397 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 290.7692])
web(x, y, z, 0.541 , 0.6132 , 7 ,  0.0397 , 0.9447 ); 


// 2024-07-28 
// Temperature = 22.6 | i = 0.8601 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 297.6923])
web(x, y, z, 0.541 , 0.6035 , 7 ,  0.0 , 0.8601 ); 


// 2024-08-04 
// Temperature = 24.8 | i = 0.9242 | Max = 27.4 | Min = -6.9  
// Precipitation = 1.5 | i = 0.0459 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 304.6154])
web(x, y, z, 0.541 , 0.5931 , 8 ,  0.0459 , 0.9242 ); 


// 2024-08-11 
// Temperature = 22.1 | i = 0.8455 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 311.5385])
web(x, y, z, 0.5403 , 0.5819 , 8 ,  0.0 , 0.8455 ); 


// 2024-08-18 
// Temperature = 21.7 | i = 0.8338 | Max = 27.4 | Min = -6.9  
// Precipitation = 11.1 | i = 0.3394 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 318.4615])
web(x, y, z, 0.5396 , 0.5701 , 8 ,  0.3394 , 0.8338 ); 


// 2024-08-25 
// Temperature = 21.8 | i = 0.8368 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.6 | i = 0.0184 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 325.3846])
web(x, y, z, 0.5382 , 0.5583 , 8 ,  0.0184 , 0.8368 ); 


// 2024-09-01 
// Temperature = 23.6 | i = 0.8892 | Max = 27.4 | Min = -6.9  
// Precipitation = 1.0 | i = 0.0306 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 332.3077])
web(x, y, z, 0.5368 , 0.5451 , 9 ,  0.0306 , 0.8892 ); 


// 2024-09-08 
// Temperature = 14.4 | i = 0.621 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 339.2308])
web(x, y, z, 0.5347 , 0.5326 , 9 ,  0.0 , 0.621 ); 


// 2024-09-15 
// Temperature = 19.7 | i = 0.7755 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 346.1538])
web(x, y, z, 0.5333 , 0.5194 , 9 ,  0.0 , 0.7755 ); 


// 2024-09-22 
// Temperature = 17.6 | i = 0.7143 | Max = 27.4 | Min = -6.9  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 353.0769])
web(x, y, z, 0.5312 , 0.5056 , 9 ,  0.0 , 0.7143 ); 

// end python script insertion of variable 