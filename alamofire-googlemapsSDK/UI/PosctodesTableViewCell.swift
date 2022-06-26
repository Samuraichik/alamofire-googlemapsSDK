//
//  PosctodesTableViewCell.swift
//  alamofire-googlemapsSDK
//
//  Created by Oleksiy Humenyuk on 24.06.2022.
//

import Foundation
import UIKit

class PostcodesTableViewCell: UITableViewCell, ReusableCell {

    public var postcode: Postcode?
    
    public var favouriteButtonAction: (() -> Void)?
    public var cellDidTappedAction: (() -> Void)?
    public var deleteCell: (() -> Void)?
    
    private lazy var postcodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.4
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var region: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.minimumScaleFactor = 0.4
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var adminCounty: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blue
        label.textAlignment = .left
        
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var deleteView: UIImageView = {
        let view = UIImageView()
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(deleteViewDidTapped))
        view.addGestureRecognizer(gesture)
        view.image = UIImage(named: "deleteIcon.png")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var favouriteView: UIImageView = {
        let view = UIImageView()
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favouriteButtonPressed))
        view.addGestureRecognizer(gesture)
        view.image = UIImage(named: "unfavorite.png")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    @objc private func favouriteButtonPressed() {
        self.favouriteView.image = UIImage(named: "favorite.png")
        favouriteButtonAction?()
    }
    
    @objc private func cellDidTapped() {
        cellDidTappedAction?()
    }
    
    @objc private func deleteViewDidTapped() {
        deleteCell?()
    }
    
    func setUpViews() {
        self.addSubview(postcodeLabel)
        postcodeLabel.layout {
            $0.constraint(to: self, by: .top(10), .leading(10))
            $0.size(.width(150), .height(20))
        }
        
        self.addSubview(region)
        region.layout {
            $0.top.constraint(to: postcodeLabel, by: .bottom(15))
            $0.constraint(to: self, by: .leading(10))
            $0.size(.width(150), .height(20))
        }
        
        self.addSubview(adminCounty)
        adminCounty.layout {
            $0.bottom.constraint(to: self, by: .bottom(-10))
            $0.constraint(to: self, by: .leading(10))
            $0.size(.width(150), .height(20))
        }
        
        self.addSubview(favouriteView)
        favouriteView.layout {
            $0.bottom.constraint(to: self, by: .bottom(-15))
            $0.trailing.constraint(to: self, by: .trailing(-10))
            $0.size(.width(25), .height(25))
        }
        
        self.addSubview(deleteView)
        deleteView.layout {
            $0.top.constraint(to: self, by: .top(15))
            $0.trailing.constraint(to: self, by: .trailing(-10))
            $0.size(.width(30), .height(30))
        }
        
        self.selectionStyle = .none
    }
    
    func addSelfViewGesture() {
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellDidTapped))
        self.addGestureRecognizer(gesture)
    }
    
    func setUpInfo(postcode: Postcode) {
        self.postcodeLabel.text = "postcode: \(postcode.postcode)"
        self.region.text = "region: \(postcode.region)"
        self.adminCounty.text = "admin county: \(postcode.adminCounty)"
    }
}
