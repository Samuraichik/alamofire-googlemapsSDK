//
//  ViewController.swift
//  alamofire-googlemapsSDK
//
//  Created by Oleksiy Humenyuk on 23.06.2022.
//

import UIKit
class PostcodesViewController: UIViewController {
    private var viewModel: PostcodesViewModel = PostcodesViewModelImpl()
    
    private lazy var postcodesTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .white
        PostcodesTableViewCell.register(for: tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        applyDefaultNavigationBar()
        self.viewModel.madePostcodesRequest()
        self.reloadTableView()
        setUpUI()
    }
    
    override func viewWillAppear( _ animated: Bool) {
        
        self.viewModel.getPostcodes()
        self.postcodesTableView.reloadData()
    }
    
    private func setUpUI() {
        view.addSubview(postcodesTableView)
        postcodesTableView.layout {
            $0.constraint(to: self.view, by: .top(0), .trailing(0), .leading(0), .bottom(0))
        }
        postcodesTableView.layoutIfNeeded()
    }
    
    private func setUpNavigationBar() {
        applyDefaultNavigationBar()
        let filterButton = UIBarButtonItem(image: nil,
                                           style: .done,
                                           target: self,
                                           action: #selector(addPostcodeButtonDidTapped))
        filterButton.title = "add postcode"
        navigationItem.rightBarButtonItem = filterButton
        
    }
    
    @objc func addPostcodeButtonDidTapped() {
        let addPostcodeVC = AddPostcodeViewController()
        self.navigationController?.pushViewController(addPostcodeVC, animated: false)
    }
    
    private func reloadTableView () {
        self.viewModel.shouldReload = {
            self.postcodesTableView.reloadData()
        }
    }
}

extension PostcodesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postcodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = PostcodesTableViewCell.deque(for: tableView, indexPath: indexPath) else {
            return UITableViewCell()
        }
        let postcode = self.viewModel.postcodes[indexPath.row]
        
        cell.setUpViews()
        cell.setUpInfo(postcode: postcode)
        cell.addSelfViewGesture()
        cell.postcode = postcode
        cell.cellDidTappedAction = { [self] in
            let infoViewController = PostcodeInfoViewController()
            infoViewController.setUpInfo(postcode: postcode)
            self.present(infoViewController, animated: true, completion: nil)
        }
        
        cell.favouriteButtonAction = { [self] in
            self.viewModel.addToFavorites(path: indexPath)
            PostcodesService.shared.addFavoritePostcode(postcode)
        }
        
        cell.deleteCell = { [self] in
            self.viewModel.deletePostcode(path: indexPath)
        }
        
        cell.contentView.isUserInteractionEnabled = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}


