//
//  JSONFileLoader.swift
//  TopHeadlines
//
//  Created by Omer Kolkanat on 19.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation

class JsonFileLoader {
    class func loadJson(fileName: String) -> Data? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                return try NSData(contentsOf: url) as Data
            } catch let error {
                print("Error!! Unable to parse \(fileName).json\n error: \(error)")
            }
            print("Error!! Unable to load  \(fileName).json")
        } else {
            print("invalid url")
        }
        return nil
    }
}
