//
//  Postcodes.swift
//  alamofire-googlemapsSDK
//
//  Created by Oleksiy Humenyuk on 23.06.2022.
//

import Foundation


struct Postcodes: Decodable {
    var status: Int
    let postcodes: [Postcode]
    
    enum CodingKeys: String, CodingKey {
        case status
        case postcodes = "result"
    }
}


