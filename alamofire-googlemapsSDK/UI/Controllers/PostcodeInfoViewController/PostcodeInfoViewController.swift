//
//  PostcodeInfoViewController.swift
//  alamofire-googlemapsSDK
//
//  Created by Oleksiy Humenyuk on 26.06.2022.
//

import UIKit

class PostcodeInfoViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
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
        label.textAlignment = .left
        label.minimumScaleFactor = 0.4
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var latitude: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.minimumScaleFactor = 0.4
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Bundle.main.loadNibNamed("PostcodeInfoView", owner: self, options: nil)
        setUpViews()
        setGesture()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpInfo(postcode: Postcode) {
        self.postcode.text = "postcode: \(postcode.postcode)"
        self.region.text = "region: \(postcode.region)"
        self.adminCounty.text = "admin county: \(postcode.adminCounty)"
        self.longitude.text = "longitude: \(postcode.longitude)"
        self.latitude.text = "latitude: \(postcode.latitude)"
    }
    
    private func setUpViews() {
        self.view.backgroundColor = .clear
        
        self.view.addSubview(mainView)
        mainView.frame = self.view.bounds
        mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.mainView.backgroundColor = .clear
        
        self.view.addSubview(infoView)
        self.infoView.layout {
            $0.constraint(to: self.view, by: .top(200), .trailing(-25), .leading(25), .bottom(-400))
        }
        
        self.view.addSubview(postcode)
        postcode.layout {
            $0.constraint(to: infoView, by: .top(10), .leading(10))
            $0.size(.width(150), .height(20))
        }
        
        self.view.addSubview(region)
        region.layout {
            $0.top.constraint(to: postcode, by: .bottom(15))
            $0.constraint(to: infoView, by: .leading(10))
            $0.size(.width(150), .height(20))
        }
        
        self.view.addSubview(longitude)
        longitude.layout {
            $0.top.constraint(to: region, by: .bottom(15))
            $0.leading.constraint(to: infoView, by: .leading(10))
            $0.size(.width(150), .height(25))
        }
        
        self.view.addSubview(latitude)
        latitude.layout {
            $0.top.constraint(to: (longitude), by: .bottom(15))
            $0.leading.constraint(to: infoView, by: .leading(10))
            $0.size(.width(150), .height(25))
        }
        
        self.view.addSubview(adminCounty)
        adminCounty.layout {
            $0.bottom.constraint(to: infoView, by: .bottom(-10))
            $0.constraint(to: infoView, by: .leading(10))
            $0.size(.width(150), .height(20))
        }
    }
    
    private func setGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
}

extension PostcodeInfoViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.infoView) == true {
            return false
        }
        return true
    }
}
