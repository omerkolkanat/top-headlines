//
//  String+Utils.swift
//  TopHeadlines
//
//  Created by Omer Kolkanat on 18.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation

extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ" ) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}
