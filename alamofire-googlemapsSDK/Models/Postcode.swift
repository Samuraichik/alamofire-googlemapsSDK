//
//  Postcode.swift
//  alamofire-googlemapsSDK
//
//  Created by Oleksiy Humenyuk on 24.06.2022.
//

import Foundation

struct Postcode: Decodable {
    var postcode: String
    var region: String
    var adminCounty: String
    var longitude: Float
    var latitude: Float
    
    enum CodingKeys: String, CodingKey {
        case postcode
        case region
        case adminCounty = "admin_county"
        case longitude
        case latitude
    }
}
