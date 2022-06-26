//
//  AddPostcodeViewController.swift
//  alamofire-googlemapsSDK
//
//  Created by Oleksiy Humenyuk on 26.06.2022.
//

import Foundation
import UIKit


class AddPostcodeViewController: UIViewController {
    
    private var postcodeService = PostcodesService()
    
    private var postcode: Postcode?
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var addPostcodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.4
        label.adjustsFontSizeToFitWidth = true
        label.text = "Add your postcode"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var postcodeField: UITextField = {
        let searchField = UITextField()
        searchField.font = UIFont.systemFont(ofSize: 18)
        searchField.textColor = UIColor.black
        searchField.placeholder = "Enter postcode"
        searchField.textAlignment = .center
        searchField.borderStyle = UITextField.BorderStyle.line
        return searchField
    }()
    
    private lazy var regionField: UITextField = {
        let searchField = UITextField()
        searchField.font = UIFont.systemFont(ofSize: 18)
        searchField.textColor = UIColor.black
        searchField.placeholder = "Enter region"
        searchField.textAlignment = .center
        searchField.borderStyle = UITextField.BorderStyle.line
        return searchField
    }()
    
    private lazy var adminCountyField: UITextField = {
        let searchField = UITextField()
        searchField.font = UIFont.systemFont(ofSize: 18)
        searchField.textColor = UIColor.black
        searchField.placeholder = "Enter admin county"
        searchField.textAlignment = .center
        searchField.borderStyle = UITextField.BorderStyle.line
        return searchField
    }()
    
    private lazy var longitudeField: UITextField = {
        let searchField = UITextField()
        searchField.font = UIFont.systemFont(ofSize: 18)
        searchField.textColor = UIColor.black
        searchField.placeholder = "Enter longitude"
        searchField.textAlignment = .center
        searchField.borderStyle = UITextField.BorderStyle.line
        return searchField
    }()
    
    private lazy var latitudeField: UITextField = {
        let searchField = UITextField()
        searchField.font = UIFont.systemFont(ofSize: 18)
        searchField.textColor = UIColor.black
        searchField.placeholder = "Enter latitude"
        searchField.textAlignment = .center
        searchField.borderStyle = UITextField.BorderStyle.line
        return searchField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(addButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    @objc private func addButtonDidTapped() {
        guard let postcodeValue = postcodeField.text,
              !postcodeValue.isEmpty,
              let latitudeValue = Float( latitudeField.text ?? "" ),
              let longitudeValue = Float( longitudeField.text ?? "") else {
                  let alert = UIAlertController(title: "Enter postcode data", message: "", preferredStyle: UIAlertController.Style.alert)
                  alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                      
                  }))
                  self.present(alert, animated: true, completion: nil)
                  return
              }
        
        let regionValue = regionField.text ?? ""
        let adminCountyValue = adminCountyField.text ?? ""
        
        let newPostcode = Postcode(postcode: postcodeValue,
                                   region: regionValue,
                                   adminCounty: adminCountyValue,
                                   longitude: longitudeValue,
                                   latitude: latitudeValue)
        
        postcodeService.addPostcodeToStorage(newPostcode)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUpViews() {
        
        self.view.addSubview(infoView)
        self.infoView.layout {
            $0.constraint(to: self.view, by: .top(200), .trailing(-25), .leading(25), .bottom(-200))
        }
        
        self.infoView.addSubview(addPostcodeLabel)
        addPostcodeLabel.layout {
            $0.constraint(to: infoView, by: .top(10), .trailing(-10))
            $0.size(.width(100), .height(20))
        }
        
        self.infoView.addSubview(postcodeField)
        postcodeField.layout {
            $0.constraint(to: infoView, by: .top(15), .leading(10))
            $0.size(.width(160), .height(20))
        }
        
        self.infoView.addSubview(regionField)
        regionField.layout {
            $0.top.constraint(to: postcodeField, by: .bottom(15))
            $0.leading.constraint(to: infoView, by: .leading(10))
            $0.size(.width(150), .height(20))
        }
        
        self.infoView.addSubview(longitudeField)
        longitudeField.layout {
            $0.top.constraint(to: regionField, by: .bottom(15))
            $0.leading.constraint(to: infoView, by: .leading(10))
            $0.size(.width(150), .height(20))
        }
        
        self.infoView.addSubview(latitudeField)
        latitudeField.layout {
            $0.top.constraint(to: longitudeField, by: .bottom(15))
            $0.leading.constraint(to: infoView, by: .leading(10))
            $0.size(.width(150), .height(20))
        }
        
        self.infoView.addSubview(adminCountyField)
        adminCountyField.layout {
            $0.bottom.constraint(to: infoView, by: .bottom(-5))
            $0.constraint(to: infoView, by: .leading(10))
            $0.size(.width(200), .height(20))
        }
        
        self.infoView.addSubview(addButton)
        addButton.layout {
            $0.bottom.constraint(to: infoView, by: .bottom(-5))
            $0.trailing.constraint(to: infoView, by: .trailing(10))
            $0.size(.width(200), .height(20))
        }
    }
    
    private func setGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
}

extension AddPostcodeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.infoView) == true {
            return false
        }
        return true
    }
}
