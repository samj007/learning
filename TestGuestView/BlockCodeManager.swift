//
//  BlockCodeManager.swift
//  Pataa
//
//  Created by admin on 01/03/22.
//  Copyright © 2022 Prefme Matrix Mac Mini. All rights reserved.
//

import Foundation
import CoreLocation

class BlockCodeManager: NSObject
{
    override init() {
       
    }
    
    func getPataaCode(cord:CLLocationCoordinate2D)->String
    {
        return self.calculatePataaCode(x:cord.latitude, y:cord.longitude, p: false)
    }
    
    func calculatePataaCode(x:Double,y:Double, p:Bool)->String
    {
        let lat1 = x.parseFloat(toFixed: 6)
        let lon1 = y.parseFloat(toFixed: 6)
        let letR = Int(((lat1 * mFact).rounded()) + (90.0 * mFact))  // 11269329
        let lonR =  Int(((lon1 * mFact).rounded()) + (180.0 * mFact))  // 25591148
        var lat = String(letR).leftPadding(toLength: 8, withPad: "0")
        var lon = String(lonR).leftPadding(toLength: 8, withPad: "0")
        let lat0 = lat.subString(from: 0, to: 1)
        let lon0 = lon.subString(from: 0, to: 1)
        var latlon_rest = lat.subString(from: 1, to: 8) + lon.subString(from: 1, to: 8)
        latlon_rest = self.shuffle(input: latlon_rest)
        lat = lat0 + latlon_rest.subString(from: 0, to: 7)
        lon = lon0 + latlon_rest.subString(from: 7, to: 14)
        let ind1 = Int(lat.subString(from: 0, to: 5))
        let ind2 = Int(lon.subString(from: 0, to: 5))
        var ind3 = lat.subString(from: 6, to: 8) + lon.subString(from: 5, to: 8)
        var checksum_digit = "" + lat.subString(from: 5, to: 6)
        if (Int(ind3)! > lFact) {
           if Int(ind3)! < cFact
           {
               ind3 = String(Int(ind3)! - lFact)
               checksum_digit = "-" + checksum_digit;
           }
           else
           {
               ind3 = String(Int(ind3)! - cFact)
               checksum_digit = "" + checksum_digit + checksum_digit;
           }
         
            ind3 = String(ind3).leftPadding(toLength: 5, withPad: "0")
            //self.pad(pad: "0", val: ind3, padLeft: true, limit: 5);
       }
        let chkSum = self.getChecksumChar(key: checksum_digit);
        let pCode = self.getWord(index: ind1!, water: false)  + "-" + getWord(index: ind2!, water: false) + "-" + getWord(index: Int(ind3)!, water: false) + chkSum;
        print(pCode)
        return pCode
    }
    
  
    
    func getLatlongFromPataaCode(words:String)
    {
        let word =  words.components(separatedBy: "-")
        if word.count <= 2{
            return
        }
        let ind1 = String(wlist.firstIndex(of: word[0])!).leftPadding(toLength: 5, withPad: "0")
        let ind2 = String(wlist.firstIndex(of: word[1])!).leftPadding(toLength: 5, withPad: "0")
        
        let word3 = (word[2]).subString(from: 0, to: 3)
        
        var ind3 = String(wlist.firstIndex(of:word3)!).leftPadding(toLength: 5, withPad: "0")
        var chkSum = self.getChecksumNum(charKey: word[2].subString(from: word[2].count - 1, to: word[2].count))
        if chkSum.firstIndex(of: "-") != nil || chkSum.count > 1
        {
            if (chkSum.count > 1) {
                ind3 = String(Int(ind3)! + cFact)
            }
            else
            {
                ind3 = String(Int(ind3)! + lFact)
            }
            ind3 = "" + ind3;
            chkSum = ("" + chkSum).subString(from: (("" + chkSum).count - 1), to:(("" + chkSum).count));
        }
        var lat = ind1 + chkSum + ind3.subString(from:0, to:2)
        var lon = ind2 + ind3.subString(from:2, to:5)

        let lat0 = lat.prefix(1)
        let lon0 = lon.prefix(1)
        var latlon_rest = lat.subString(from: 1, to: 8) + lon.subString(from: 1, to: 8)
        latlon_rest = self.unshuffle(input: latlon_rest)
        lat = lat0 + latlon_rest.subString(from: 0, to: 7)
        lon = lon0 + latlon_rest.subString(from: 7, to: 14)

        lat = String(((Double(lat)! - (Double(90) * Double(mFact))) / mFact).parseFloat(toFixed: 6))
        lon = String(((Double(lon)! - (Double(180) * Double(mFact))) / mFact).parseFloat(toFixed: 6))
        print(" Latitude :- \(lat)\n Longitude :- \(lon)")
        print("=============")
    }
    
    
    fileprivate func getWord(index:Int, water:Bool)->String
    {
        if (water) {
            return wlist[index]; // TODO need to implement a separate word list for water cases
        } else {
            return wlist[index];
        }
    }
    fileprivate func getChecksumNum(charKey:String)->String {
        var clist = [String:String]()
        for keyString in checksum.keys {
            clist[checksum[keyString]!] = keyString;
        };
        return clist[charKey]!;
    }
        
    fileprivate func getCipherBlock(L:String, R:String)-> String {
            let x = Int(L)        //parseInt(L);
            let y = Int(R)              // parseInt(R);
            let block = [[1,0,3,2,5,4,7,6,9,8],
                         [7,2,1,5,8,3,9,0,4,6],
                         [9,5,3,2,8,1,7,6,4,0],
                         [1,0,9,4,3,6,5,8,7,2],
                         [6,8,9,5,7,3,0,4,1,2],
                         [1,0,7,4,3,8,9,2,5,6],
                         [5,7,4,9,2,0,8,1,6,3],
                         [8,9,7,6,5,4,3,2,0,1],
                         [2,8,0,7,6,9,4,3,1,5],
                         [8,7,4,6,2,9,3,1,0,5]]
            
            //        return block[y][x];

            let yArray = block[y!] as [Int]
            let value = yArray[x!] as Int
            return String(value)
        };

        
    fileprivate func getFNPassCode(input:String, k:String, isForUnsuffel:Bool = false)->String
    {
        let L = input.subString(from: 0, to: 7)
        let R = input.subString(from: 7, to: 14)
        let LArray = L.compactMap{(String($0))}
        let RArray = R.compactMap{(String($0))}
        var Rout = "";
        
        var temp = ""
//        temp = self.getArbitraryNumForUnsuffel(L: R, K: k);

        if isForUnsuffel{
            temp = self.getArbitraryNumForUnsuffel(L: R, K: k);
        }
        else
        {
            temp = self.getArbitraryNum(L: R, K: k);
        }
        let tempArray = temp.compactMap{(String($0))}
        for i in 0 ..< 7
        {
            Rout = Rout + getCipherBlock(L: LArray[i], R: tempArray[i]);
        }
        print(Rout)
        return R + Rout
    }
        
    fileprivate func getArbitraryNum(L:String, K:String)->String
    {
        let x = Double(L)
        let y = Double(K)
        let temp = (x!*x!*x!*y!*Double(3)).description
        let decimalValue = NSDecimalNumber(string: temp)
        return decimalValue.stringValue.subString(from: 4, to: 11)

        //+ String((Double(23)*y!*y!*x!*x!*x!)+(y!*(x!+y!))+Double(3))
    //        return "4821717"
//            if temp.hasSuffix("e+16")
//            || temp.hasSuffix("e+17")
//            || temp.hasSuffix("e+18")
//            || temp.hasSuffix("e+19")
//            || temp.hasSuffix("e+20")
//        {
//            print("Here ->L:- \(L), K:- \(K)\n (x!*x!*x!*y!*Double(3))\nFormat Style -> \(String(format: "%f",(x!*x!*x!*y!*Double(3))))\nSubstring:- \(temp.subString(from: 5, to: 12))\n\n\n Description Style -> \(temp)\n Substring:- \(temp.subString(from: 5, to: 12))\n\n\n=======================")
//
//            return temp.subString(from: 5, to: 12)
//        }
//        else  if L.hasPrefix("00")
//        {
//            print("L:- \(L), K:- \(K)\n (x!*x!*x!*y!*Double(3))\nFormat Style -> \(String(format: "%f",(x!*x!*x!*y!*Double(3))))\nSubstring:- \(temp.subString(from: 6, to: 13))\n\n\n Description Style -> \(temp)\n Substring:- \(temp.subString(from: 6, to: 13))\n\n\n=======================")
//
//            return temp.subString(from: 6, to: 13)
//        }
//        print("L:- \(L), K:- \(K)\n (x!*x!*x!*y!*Double(3))\nFormat Style -> \(String(format: "%f",(x!*x!*x!*y!*Double(3))))\nSubstring:- \(temp.subString(from: 4, to: 11))\n\n\n Description Style -> \(temp)\n Substring:- \(temp.subString(from: 4, to: 11))\n\n\n=======================")
//
//        return temp.subString(from: 4, to: 11)
    }
    
    fileprivate func getArbitraryNumForUnsuffel(L:String, K:String)->String
    {
        let x = Double(L)
        let y = Double(K)
        let temp = (x!*x!*x!*y!*Double(3)).description
//        let decimalValue = NSDecimalNumber(string: temp)
//        return decimalValue.stringValue.subString(from: 4, to: 11)

            if temp.hasSuffix("e+15")
                || temp.hasSuffix("e+16")
                || temp.hasSuffix("e+17")
                || temp.hasSuffix("e+18")
                || temp.hasSuffix("e+19")
                || temp.hasSuffix("e+20")
        {
            print("Here ->L:- \(L), K:- \(K)\n (x!*x!*x!*y!*Double(3))\nFormat Style -> \(String(format: "%f",(x!*x!*x!*y!*Double(3))))\nSubstring:- \(temp.subString(from: 5, to: 12))\n\n\n Description Style -> \(temp)\n Substring:- \(temp.subString(from: 5, to: 12))\n\n\n=======================")

            return temp.subString(from: 5, to: 12)
        }
        
        print("L:- \(L), K:- \(K)\n (x!*x!*x!*y!*Double(3))\nFormat Style -> \(String(format: "%f",(x!*x!*x!*y!*Double(3))))\nSubstring:- \(temp.subString(from: 4, to: 11))\n\n\n Description Style -> \(temp)\n Substring:- \(temp.subString(from: 4, to: 11))\n\n\n=======================")

        return temp.subString(from: 4, to: 11)
    }
        
    fileprivate func shuffle(input:String)->String {
        var inputVal = input
        let passKeyIntArray = passkey.compactMap{(String($0))}

        for i in 0 ..< passKeyIntArray.count
        {
            inputVal = self.getFNPassCode(input: inputVal, k: passKeyIntArray[i])
        }
        return inputVal
    };
        
    fileprivate func unshuffle(input:String)->String {
        var inputVal = input.subString(from: 7, to: 14) + input.subString(from: 0, to: 7)
        let passKeyIntArray = passkey.compactMap{(String($0))}
        for i in 0 ..< passKeyIntArray.count
        {
            inputVal = getFNPassCode(input: inputVal, k: passKeyIntArray[passKeyIntArray.count - 1 - i])//, isForUnsuffel: true);
        }
        return inputVal.subString(from: 7, to: 14) + inputVal.subString(from: 0, to: 7)
    };

    func getChecksumChar(key:String)->String {
        return checksum[key]!;
    }
}


    extension Double {
//Same function already using roundTo
        func parseFloat(toFixed places:Int) -> Double {
            let divisor = pow(10.0, Double(places))
            return (self * divisor).rounded() / divisor
        }
    }


    extension String
    {
        func subString(from: Int, to: Int) -> String {
           let startIndex = self.index(self.startIndex, offsetBy: from)
           let endIndex = self.index(self.startIndex, offsetBy: to)
           return String(self[startIndex..<endIndex])
        }
        func leftPadding(toLength: Int, withPad: String) -> String {
            String(String(reversed()).padding(toLength: toLength, withPad: withPad, startingAt: 0).reversed())
        }
    }
