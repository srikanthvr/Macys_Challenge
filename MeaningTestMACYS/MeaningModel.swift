//
//  MeaningModel.swift
//  MeaningTestMACYS
//
//  Created by srikanth reddy vangala on 4/14/17.
//  Copyright © 2017 srikanth reddy vangala. All rights reserved.
//

import UIKit

class MeaningModel: NSObject {
    
    var abbrevation : String?
    
    class func initWithDict(object: NSDictionary) -> MeaningModel{
        
        let meanObj = MeaningModel()
        
        let tempStr : String = object["lf"] as! String
        print("\(tempStr)")
        
        meanObj.abbrevation = tempStr
        
        return meanObj
        
    }
    class func meaningsWithArray(array: [NSDictionary]) -> [MeaningModel] {
        var abrevationsObject = [MeaningModel]()
        
        for item in array {
            let meanDict : NSDictionary = item as NSDictionary
            let meanObj : MeaningModel = self.initWithDict(object: meanDict) as MeaningModel
            abrevationsObject.append(meanObj)
        }
        return abrevationsObject
    }

}
