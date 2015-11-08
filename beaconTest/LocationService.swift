//
//  LocationServices.swift
//  beaconTest
//
//  Created by hack on 08/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

import Foundation
import Darwin

@objc class LocationService : NSObject {
    
    //array of beacons [id,x,y,d]
    func calculateLocation() -> String
    {
        var min = 0;
        var max = 100;
        
        var beacons = [[53111,1,1],[65397,2,2],[47967,3,3]];
        
        var location = getLocation(beacons)
        
        return String(location[0]) + String(location[1]);
    }
    
    //Returns x,y
    func getLocation(beacons : [[Int]]) -> [Int]
    {
        //return "hello world"
        //P1 = (3,0) r1 = 6.4031
        //P2 = (9,0) r2 = 4.1231
        //P3 = (4,8) r3 = 5.6568
        
        //http://stackoverflow.com/questions/19424412/ble-ibeacons trilaterations
        
        //Calculation
        //P1,P2,P3 is the point and 2-dimension vector
        let P1 = [Double(beacons[0][1]), Double(beacons[0][2])]//[3.0,0.0]
        let P2 = [Double(beacons[1][1]), Double(beacons[1][2])]//[9.0,0.0]
        let P3 = [Double(beacons[1][1]), Double(beacons[2][2])]//[4.0,8.0]
        
        //this is the distance between all the points and the unknown point
        let DistA = Double(beacons[0][3])//6.4031
        let DistB = Double(beacons[1][3])//4).1231
        let DistC = Double(beacons[2][3])//5.6568
        
        //return "Hello";
        
        // ex = (P2 - P1)/(numpy.linalg.norm(P2 - P1))
        var ex = [Double]();
        var temp = 0.0;
        for i in  0..<P1.count {
            let t1 : Double = P2[i]
            let t2 : Double = P1[i]
            let t  : Double = t1 - t2
            temp += (t*t)
        }
        for i in 0..<P1.count {
            let t1 = P2[i];
            let t2 = P1[i];
            let exx = (t1 - t2)/Darwin.sqrt(temp);
            ex.append(exx);
        }
        
        // i = dot(ex, P3 - P1)
        var p3p1 = [Double]();
        for i in 0..<P3.count {
            let t1 = P3[i];
            let t2 = P1[i];
            let t3 = t1 - t2;
            p3p1.append(t3);
        }
        
        var ival = 0.0;
        for i in 0..<ex.count {
            let t1 = ex[i];
            let t2 = p3p1[i];
            ival += (t1*t2);
        }
        
        // ey = (P3 - P1 - i*ex)/(numpy.linalg.norm(P3 - P1 - i*ex))
        var ey = [Double]();
        var p3p1i = 0.0;
        for i in 0..<P3.count {
            let t1 = P3[i];
            let t2 = P1[i];
            let t3 = ex[i] * ival;
            let t = t1 - t2 - t3;
            p3p1i += (t*t);
        }
        
        for i in 0..<P3.count {
            let t1 = P3[i];
            let t2 = P1[i];
            let t3 = ex[i] * ival;
            let eyy = (t1 - t2 - t3)/Darwin.sqrt(p3p1i);
            ey.append(eyy);
        }
        
        
        // ez = numpy.cross(ex,ey)
        // if 2-dimensional vector then ez = 0
        var ez = [Double]();
        var ezx : Double;
        var ezy : Double;
        var ezz : Double;
        if (P1.count != 3){
            ezx = 0;
            ezy = 0;
            ezz = 0;
            
        }else{
            ezx = (ex[1] * ey[2]) - (ex[2] * ey[1]);
            ezy = (ex[2] * ey[0]) - (ex[0] * ey[2]);
            ezz = (ex[0] * ey[1]) - (ex[1] * ey[0]);
            
        }
        
        ez.append(ezx);
        ez.append(ezy);
        ez.append(ezz);
        
        
        // d = numpy.linalg.norm(P2 - P1)
        var d : Double = Darwin.sqrt(temp);
        
        // j = dot(ey, P3 - P1)
        var jval : Double = 0;
        for i in 0..<ey.count {
            var t1 : Double = ey[i];
            var t2 : Double = p3p1[i];
            jval += (t1*t2);
        }
        
        // x = (pow(DistA,2) - pow(DistB,2) + pow(d,2))/(2*d)
        var two = Double(2);
        var xval : Double = (pow(DistA,two) - pow(DistB,two) + pow(d,two))/(2*d);
        
        // y = ((pow(DistA,2) - pow(DistC,2) + pow(i,2) + pow(j,2))/(2*j)) - ((i/j)*x)
        var yval : Double = ((pow(DistA,2) - pow(DistC,2) + pow(ival,2) + pow(jval,2))/(2*jval)) - ((ival/jval)*xval);
        
        // z = sqrt(pow(DistA,2) - pow(x,2) - pow(y,2))
        // if 2-dimensional vector then z = 0
        var zval : Double;
        if (P1.count != 3){
            zval = 0;
        }else{
            zval = sqrt(pow(DistA,2) - pow(xval,2) - pow(yval,2));
        }
        
        // triPt = P1 + x*ex + y*ey + z*ez
        var triPt = [Double]();
        for i in 0..<P1.count {
            var t1 : Double = P1[i];
            var t2 : Double = ex[i] * xval;
            var t3 : Double  = ey[i] * yval;
            var t4 : Double  = ez[i] * zval;
            var triptx : Double  = t1+t2+t3+t4;
            triPt.append(triptx);
        }
        
        //NSLog(@"ex %@",ex);
        //NSLog(@"i %f",ival);
       //NSLog(@"ey %@",ey);
        //NSLog(@"d %f",d);
        //print(<#T##items: Any...##Any#>)(@"j %f",jval);
        //print(@"x %f",xval);
        //print(<#T##items: Any...##Any#>)(@"y %f",yval);
        //print(@"y %f",yval);
        //NSLog(@"final result %@",triPt);
        
        
        //let output = "[" + String(triPt[0]) + "," + String(triPt[1]) + ")";
        //output.append(triPt[0]:String);
        //output.append(",");
        //output.append(triPt[1]:String);
        //output.append("));"
        
/*
for i in 0..<triPt.count
        {
            output += String(format: "%@,", triPt[i])
//            output += triPt[i]
//            output += (string)triPt[i];
 //           output += ","
        }
*/
        return [Int(triPt[0]), Int(triPt[1])];
        
//        7.999978,4.000021710625001).

        
        
        //let a = 1 + 2
        //return "hello world"
    }
}

