//
//  PostcodesService.swift
//  alamofire-googlemapsSDK
//
//  Created by Oleksiy Humenyuk on 26.06.2022.
//

import Foundation
import UIKit
import Alamofire

fileprivate let favouritesUserDefaultsKey = "favorites_ud_key"
fileprivate let favouritesUserDefaultsLatKey = "favorites_ud_key_lat"
fileprivate let favouritesUserDefaultsLongKey = "favorites_ud_key_long"

class PostcodesService {
    
    public static let shared = PostcodesService()
    
    private var postcodes: [Postcode] = []
    private var favoritePostcodes: [Postcode] = []
    private var addedPostcodes: [Postcode] = []
    private var userDefaults: UserDefaults { UserDefaults.standard }
    
    func getPostcodes() -> [Postcode] {
        return self.postcodes
    }
    
    func getFavoritePostcodes() -> [Postcode] {
        return self.favoritePostcodes
    }
    
    func postcodesGetRequest(completion: (([Postcode]?, Error?) -> Void )?) {
        AF.request("https://api.postcodes.io/postcodes/ME121TT/nearest")
            .validate()
            .responseDecodable(of: Postcodes.self) { (response) in
                guard var postcodesFromResponse = response.value?.postcodes else { return }
                if !self.getAddedPostcodesFromStorage().isEmpty {
                    for i in self.getAddedPostcodesFromStorage(){
                        postcodesFromResponse.append(i)
                    }
                }
                self.postcodes = postcodesFromResponse
                completion?(postcodesFromResponse, nil)
            }
    }
    
    public func addPostcodeToStorage(_ postcode: Postcode){
        self.addedPostcodes.append(postcode)
        
        if var favoriteArray = UserDefaults.standard.stringArray(forKey: favouritesUserDefaultsKey) {
            if !favoriteArray.contains(postcode.postcode) {
                favoriteArray.append(postcode.postcode)
                UserDefaults.standard.set(favoriteArray, forKey: favouritesUserDefaultsKey)
            }
        } else {
            let favoriteArray = [postcode.postcode]
            UserDefaults.standard.set(favoriteArray, forKey: favouritesUserDefaultsKey)
        }
        
        UserDefaults.standard.set(postcode.longitude, forKey: favouritesUserDefaultsLongKey)
        UserDefaults.standard.set(postcode.latitude, forKey: favouritesUserDefaultsLatKey)
    }
    
    public func addFavoritePostcode(_ postcode: Postcode) {
        self.favoritePostcodes.append(postcode)
    }
    
    public func getAddedPostcodesFromStorage() -> [Postcode] {
        if let favoriteArray = UserDefaults.standard.stringArray(forKey: favouritesUserDefaultsKey) {
            return favoriteArray.map { getPostcodeById($0) }
        } else {
            return []
        }
    }
    
    private func getPostcodeById(_ id: String) -> Postcode {
        let lat = userDefaults.float(forKey: favouritesUserDefaultsLatKey)
        let long = userDefaults.float(forKey: favouritesUserDefaultsLongKey)
        
        return Postcode(postcode: id, region: "", adminCounty: "", longitude: long, latitude: lat)
    }
}

