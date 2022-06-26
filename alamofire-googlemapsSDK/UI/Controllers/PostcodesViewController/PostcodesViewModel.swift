//
//  PostcodesViewModel.swift
//  alamofire-googlemapsSDK
//
//  Created by Oleksiy Humenyuk on 24.06.2022.
//

import Foundation
import Alamofire

protocol PostcodesViewModel {
    var shouldReload: (() -> Void)? { get set }
    var postcodes: [Postcode] { get set }
    
    func madePostcodesRequest()
    func getPostcodes()
    func addToFavorites(path: IndexPath)
    func deletePostcode(path: IndexPath)
}

class PostcodesViewModelImpl: PostcodesViewModel {
    
    var shouldReload: (() -> Void)?
    var postcodes: [Postcode] = []
    
    func madePostcodesRequest() {
        PostcodesService.shared.postcodesGetRequest(completion: { (postcodes, error) in
            guard let postcodes = postcodes else { return }
            self.postcodes = postcodes
            self.shouldReload?()
        })
    }
    
    func getPostcodes() {
        self.postcodes = PostcodesService.shared.getPostcodes()
        
        let postcodes = PostcodesService.shared.getAddedPostcodesFromStorage()
        if !postcodes.isEmpty {
            for i in postcodes{
                self.postcodes.append(i)
            }
        }
        
        self.shouldReload?()
    }
    
    func addToFavorites(path: IndexPath) {
        PostcodesService.shared.addFavoritePostcode(self.postcodes[path.row])
    }
    
    func deletePostcode(path: IndexPath) {
        self.postcodes.remove(at: path.row)
        shouldReload?()
    }
}

