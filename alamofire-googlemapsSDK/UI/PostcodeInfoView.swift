//
//  PostcodeInfoView.swift
//  alamofire-googlemapsSDK
//
//  Created by Oleksiy Humenyuk on 25.06.2022.
//

import UIKit

class PostcodeInfoView: UIView {
    
    @IBOutlet var mainView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder adDecoder: NSCoder) {
        super.init(coder: adDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("PostcodeInfoView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private lazy var postcode: UILabel = {
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
    
    private lazy var longitude: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.minimumScaleFactor = 0.4
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var latitude: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.minimumScaleFactor = 0.4
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    func setUpViews() {
        self.addSubview(postcode)
        postcode.layout {
            $0.constraint(to: self, by: .top(10), .leading(10))
            $0.size(.width(150), .height(20))
        }
        
        self.addSubview(region)
        region.layout {
            $0.top.constraint(to: postcode, by: .bottom(15))
            $0.constraint(to: self, by: .leading(10))
            $0.size(.width(150), .height(20))
        }
        
        self.addSubview(adminCounty)
        adminCounty.layout {
            $0.bottom.constraint(to: self, by: .bottom(-10))
            $0.constraint(to: self, by: .leading(10))
            $0.size(.width(150), .height(20))
        }
        
        self.addSubview(longitude)
        longitude.layout {
            $0.top.constraint(to: self, by: .top(15))
            $0.trailing.constraint(to: self, by: .trailing(-10))
            $0.size(.width(25), .height(25))
        }
        
        self.addSubview(latitude)
        latitude.layout {
            $0.top.constraint(to: (longitude), by: .top(15))
            $0.trailing.constraint(to: self, by: .trailing(-10))
            $0.size(.width(25), .height(25))
        }
    }
    
    func setUpInfo(postcode: Postcode) {
        self.postcode.text = "postcode: \(postcode.postcode)"
        self.region.text = "region: \(postcode.region)"
        self.adminCounty.text = "admin county: \(postcode.adminCounty)"
        self.longitude.text = "\(postcode.longitude)"
        self.latitude.text = "\(postcode.latitude)"
        
    }
}

