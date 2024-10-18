
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
// Temperature = 18.7 | i = 0.7317 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 0.0])
web(x, y, z, 0.5299 , 0.4896 , 10 ,  0.3321 , 0.7317 ); 


// 2023-10-08 
// Temperature = 11.62857142857143 | i = 0.5044 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 6.9231])
web(x, y, z, 0.5278 , 0.4771 , 10 ,  0.148 , 0.5044 ); 


// 2023-10-15 
// Temperature = 13.014285714285714 | i = 0.5489 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 13.8462])
web(x, y, z, 0.5271 , 0.4632 , 10 ,  0.2751 , 0.5489 ); 


// 2023-10-22 
// Temperature = 14.642857142857142 | i = 0.6013 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 20.7692])
web(x, y, z, 0.5257 , 0.4507 , 10 ,  0.0 , 0.6013 ); 


// 2023-10-29 
// Temperature = 7.557142857142857 | i = 0.3734 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 19.1 | i = 0.5841 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 27.6923])
web(x, y, z, 0.525 , 0.4382 , 10 ,  0.2998 , 0.3734 ); 


// 2023-11-05 
// Temperature = 7.885714285714285 | i = 0.384 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.8 | i = 0.0244 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 34.6154])
web(x, y, z, 0.4833 , 0.4271 , 11 ,  0.0712 , 0.384 ); 


// 2023-11-12 
// Temperature = 5.742857142857143 | i = 0.3151 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 41.5385])
web(x, y, z, 0.484 , 0.4153 , 11 ,  0.0275 , 0.3151 ); 


// 2023-11-19 
// Temperature = 4.5285714285714285 | i = 0.2761 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 48.4615])
web(x, y, z, 0.4847 , 0.4062 , 11 ,  0.2486 , 0.2761 ); 


// 2023-11-26 
// Temperature = 4.142857142857143 | i = 0.2637 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 11.1 | i = 0.3394 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 55.3846])
web(x, y, z, 0.4861 , 0.3972 , 11 ,  0.2514 , 0.2637 ); 


// 2023-12-03 
// Temperature = 4.257142857142857 | i = 0.2673 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 12.8 | i = 0.3915 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 62.3077])
web(x, y, z, 0.4875 , 0.3903 , 12 ,  0.1214 , 0.2673 ); 


// 2023-12-10 
// Temperature = 4.728571428571429 | i = 0.2825 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 17.0 | i = 0.5198 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 69.2308])
web(x, y, z, 0.4896 , 0.3861 , 12 ,  0.2875 , 0.2825 ); 


// 2023-12-17 
// Temperature = 3.5571428571428574 | i = 0.2448 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 13.3 | i = 0.4068 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 76.1538])
web(x, y, z, 0.4924 , 0.3826 , 12 ,  0.9545 , 0.2448 ); 


// 2023-12-24 
// Temperature = 6.985714285714286 | i = 0.3551 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 83.0769])
web(x, y, z, 0.4944 , 0.3826 , 12 ,  0.4478 , 0.3551 ); 


// 2023-12-31 
// Temperature = 0.7857142857142857 | i = 0.1557 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 90.0])
web(x, y, z, 0.4965 , 0.3847 , 12 ,  0.0503 , 0.1557 ); 


// 2024-01-07 
// Temperature = 4.742857142857143 | i = 0.283 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 6.9 | i = 0.2111 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 96.9231])
web(x, y, z, 0.4993 , 0.3896 , 1 ,  1.0 , 0.283 ); 


// 2024-01-14 
// Temperature = -4.057142857142857 | i = 0.0 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.1 | i = 0.0031 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 103.8462])
web(x, y, z, 0.5007 , 0.3951 , 1 ,  0.0863 , 0.0 ); 


// 2024-01-21 
// Temperature = 2.4285714285714284 | i = 0.2085 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 110.7692])
web(x, y, z, 0.5028 , 0.4035 , 1 ,  0.2552 , 0.2085 ); 


// 2024-01-28 
// Temperature = 2.6714285714285717 | i = 0.2164 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 32.7 | i = 1.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 117.6923])
web(x, y, z, 0.5042 , 0.4132 , 1 ,  0.3435 , 0.2164 ); 


// 2024-02-04 
// Temperature = 3.2142857142857144 | i = 0.2338 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 124.6154])
web(x, y, z, 0.5049 , 0.4243 , 2 ,  0.0152 , 0.2338 ); 


// 2024-02-11 
// Temperature = 1.0285714285714287 | i = 0.1635 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 131.5385])
web(x, y, z, 0.5049 , 0.4354 , 2 ,  0.1879 , 0.1635 ); 


// 2024-02-18 
// Temperature = 0.0428571428571427 | i = 0.1318 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 138.4615])
web(x, y, z, 0.5049 , 0.4479 , 2 ,  0.0702 , 0.1318 ); 


// 2024-02-25 
// Temperature = 4.6571428571428575 | i = 0.2802 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 145.3846])
web(x, y, z, 0.5042 , 0.4611 , 2 ,  0.4175 , 0.2802 ); 


// 2024-03-03 
// Temperature = 8.542857142857143 | i = 0.4051 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.2 | i = 0.0062 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 152.3077])
web(x, y, z, 0.5035 , 0.4743 , 3 ,  0.6935 , 0.4051 ); 


// 2024-03-10 
// Temperature = 9.342857142857143 | i = 0.4309 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 17.0 | i = 0.5198 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 159.2308])
web(x, y, z, 0.5438 , 0.4882 , 3 ,  0.1613 , 0.4309 ); 


// 2024-03-17 
// Temperature = 4.6000000000000005 | i = 0.2784 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.2 | i = 0.0062 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 166.1538])
web(x, y, z, 0.5424 , 0.5014 , 3 ,  0.5806 , 0.2784 ); 


// 2024-03-24 
// Temperature = 6.685714285714285 | i = 0.3454 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 173.0769])
web(x, y, z, 0.541 , 0.5146 , 3 ,  0.2391 , 0.3454 ); 


// 2024-03-31 
// Temperature = 6.857142857142857 | i = 0.3509 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 180.0])
web(x, y, z, 0.5396 , 0.5285 , 3 ,  0.5114 , 0.3509 ); 


// 2024-04-07 
// Temperature = 12.471428571428572 | i = 0.5315 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 186.9231])
web(x, y, z, 0.5382 , 0.5424 , 4 ,  0.4668 , 0.5315 ); 


// 2024-04-14 
// Temperature = 12.014285714285714 | i = 0.5168 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.3 | i = 0.0091 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 193.8462])
web(x, y, z, 0.5368 , 0.5549 , 4 ,  0.1831 , 0.5168 ); 


// 2024-04-21 
// Temperature = 9.357142857142858 | i = 0.4313 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 200.7692])
web(x, y, z, 0.5354 , 0.5674 , 4 ,  0.0104 , 0.4313 ); 


// 2024-04-28 
// Temperature = 16.04285714285714 | i = 0.6463 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 1.4 | i = 0.0428 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 207.6923])
web(x, y, z, 0.5347 , 0.5792 , 4 ,  0.056 , 0.6463 ); 


// 2024-05-05 
// Temperature = 15.171428571428573 | i = 0.6183 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 16.6 | i = 0.5076 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 214.6154])
web(x, y, z, 0.534 , 0.591 , 5 ,  0.3378 , 0.6183 ); 


// 2024-05-12 
// Temperature = 15.885714285714286 | i = 0.6412 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.4 | i = 0.0122 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 221.5385])
web(x, y, z, 0.534 , 0.6014 , 5 ,  0.2476 , 0.6412 ); 


// 2024-05-19 
// Temperature = 20.928571428571427 | i = 0.8034 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 228.4615])
web(x, y, z, 0.534 , 0.6111 , 5 ,  0.1347 , 0.8034 ); 


// 2024-05-26 
// Temperature = 19.785714285714285 | i = 0.7667 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 235.3846])
web(x, y, z, 0.5347 , 0.6187 , 5 ,  0.3795 , 0.7667 ); 


// 2024-06-02 
// Temperature = 21.842857142857145 | i = 0.8328 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 242.3077])
web(x, y, z, 0.5354 , 0.6257 , 6 ,  0.1034 , 0.8328 ); 


// 2024-06-09 
// Temperature = 19.571428571428573 | i = 0.7598 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 2.7 | i = 0.0824 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 249.2308])
web(x, y, z, 0.5361 , 0.6299 , 6 ,  0.1167 , 0.7598 ); 


// 2024-06-16 
// Temperature = 24.842857142857145 | i = 0.9293 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 256.1538])
web(x, y, z, 0.5368 , 0.6319 , 6 ,  0.3387 , 0.9293 ); 


// 2024-06-23 
// Temperature = 23.728571428571428 | i = 0.8934 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 6.4 | i = 0.1958 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 263.0769])
web(x, y, z, 0.5382 , 0.6326 , 6 ,  0.2543 , 0.8934 ); 


// 2024-06-30 
// Temperature = 23.7 | i = 0.8925 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 6.3 | i = 0.1926 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 270.0])
web(x, y, z, 0.5389 , 0.6306 , 6 ,  0.4402 , 0.8925 ); 


// 2024-07-07 
// Temperature = 27.042857142857144 | i = 1.0 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.1 | i = 0.0031 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 276.9231])
web(x, y, z, 0.5403 , 0.6264 , 7 ,  0.1015 , 1.0 ); 


// 2024-07-14 
// Temperature = 25.514285714285712 | i = 0.9508 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 283.8462])
web(x, y, z, 0.541 , 0.6208 , 7 ,  0.2922 , 0.9508 ); 


// 2024-07-21 
// Temperature = 23.542857142857144 | i = 0.8875 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 1.3 | i = 0.0397 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 290.7692])
web(x, y, z, 0.541 , 0.6132 , 7 ,  0.1214 , 0.8875 ); 


// 2024-07-28 
// Temperature = 25.17142857142857 | i = 0.9398 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 297.6923])
web(x, y, z, 0.541 , 0.6035 , 7 ,  0.5085 , 0.9398 ); 


// 2024-08-04 
// Temperature = 23.585714285714285 | i = 0.8888 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 1.5 | i = 0.0459 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 304.6154])
web(x, y, z, 0.541 , 0.5931 , 8 ,  0.7125 , 0.8888 ); 


// 2024-08-11 
// Temperature = 22.0 | i = 0.8379 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 311.5385])
web(x, y, z, 0.5403 , 0.5819 , 8 ,  0.0123 , 0.8379 ); 


// 2024-08-18 
// Temperature = 19.685714285714287 | i = 0.7634 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 11.1 | i = 0.3394 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 318.4615])
web(x, y, z, 0.5396 , 0.5701 , 8 ,  0.1689 , 0.7634 ); 


// 2024-08-25 
// Temperature = 22.414285714285715 | i = 0.8512 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.6 | i = 0.0184 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 325.3846])
web(x, y, z, 0.5382 , 0.5583 , 8 ,  0.0152 , 0.8512 ); 


// 2024-09-01 
// Temperature = 19.228571428571428 | i = 0.7487 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 1.0 | i = 0.0306 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 332.3077])
web(x, y, z, 0.5368 , 0.5451 , 9 ,  0.0731 , 0.7487 ); 


// 2024-09-08 
// Temperature = 17.585714285714285 | i = 0.6959 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 339.2308])
web(x, y, z, 0.5347 , 0.5326 , 9 ,  0.0066 , 0.6959 ); 


// 2024-09-15 
// Temperature = 19.571428571428573 | i = 0.7598 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 346.1538])
web(x, y, z, 0.5333 , 0.5194 , 9 ,  0.0066 , 0.7598 ); 


// 2024-09-22 
// Temperature = 17.785714285714285 | i = 0.7023 | Max = 27.042857142857144 | Min = -4.057142857142857  
// Precipitation = 0.0 | i = 0.0 | Max = 32.7 | Min = 0.0  
// Noon , Day , Month , Precip , Temp 
rotate([0 , 0 , 353.0769])
web(x, y, z, 0.5312 , 0.5056 , 9 ,  0.1205 , 0.7023 ); 

// end python script insertion of variable 