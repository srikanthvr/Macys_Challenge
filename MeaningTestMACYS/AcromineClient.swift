//
//  AcromineClient.swift
//  MeaningTestMACYS
//
//  Created by srikanth reddy vangala on 4/14/17.
//  Copyright © 2017 srikanth reddy vangala. All rights reserved.
//

import UIKit
var baseUrl = "http://www.nactem.ac.uk/software/acromine/dictionary.py"

class AcromineClient: NSObject {
    
    class func getDataFromAcromine(parameter: String, completion: @escaping (_ response: [MeaningModel], _ error: Error?)-> ()){
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        var meaningObj = [MeaningModel]()
        
        manager.get("\(baseUrl)?sf=\(parameter)", parameters: nil, progress: nil, success: { seesionTask, response in
            let jsonString : String = String(data: response! as! Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            let jsonArray : NSArray = self.convertToDictionary(text: jsonString)!
            if jsonArray.count > 0{
                let listDict = jsonArray[0] as! NSDictionary
                let ifsArray = listDict["lfs"] as! [NSDictionary]
                meaningObj = MeaningModel.meaningsWithArray(array: ifsArray)
                completion(meaningObj, nil)
                
            }else{
                completion(meaningObj, nil)
                
            }
            
        }, failure: {sessionTask, error in
            print("Error: \(error)")
            completion(meaningObj, error)
            
        })
    }
    
    class func convertToDictionary(text: String) -> NSArray? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSArray
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }


}
