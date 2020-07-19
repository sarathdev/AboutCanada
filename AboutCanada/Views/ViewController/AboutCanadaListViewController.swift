//
//  AboutCanadaListViewController.swift
//  AboutCanada
//
//  Created by Sarath Sasi on 19/07/20.
//  Copyright © 2020 Sarath Sasi. All rights reserved.
//
import UIKit
import SDWebImage

final class AboutCanadaListViewController: UIViewController {
   
    private var factTitle: String?
    private var factArray: [CanadaFacts]?
    private let canadaFactsListTableView = UITableView()
    private var refreshControl = UIRefreshControl()
    private var activityView = UIActivityIndicatorView()
    private var safeArea: UILayoutGuide!
    private let estimatedRowHeight = 420
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCanadaTableViewConstraints()
        setupTableView()
        fetchCanadaFacts()
        setupPullRefresh()
    }
    
    private func setupPullRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        canadaFactsListTableView.addSubview(refreshControl)
    }
    
    private func layoutCanadaTableViewConstraints() {
        view.addSubview(canadaFactsListTableView)
        canadaFactsListTableView.translatesAutoresizingMaskIntoConstraints = false
        canadaFactsListTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        canadaFactsListTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        canadaFactsListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        canadaFactsListTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    @objc
    private func refresh(_ sender: AnyObject) {
      fetchCanadaFacts()
    }
    
    private func showActivityIndicator() {
         activityView = UIActivityIndicatorView(style: .whiteLarge)
         activityView.center = view.center
         view.addSubview(activityView)
         activityView.startAnimating()
     }

    private func hideActivityIndicator(){
        activityView.stopAnimating()
     }

    private func setUpNavigation() {
        navigationItem.title = factTitle
        navigationController?.navigationBar.barTintColor = .cyan
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func showAlert(errorType: NetworkError) {
        print("Alert!!!!!!:\(errorType)")
    }
    
    private func setupTableView(){
        // Add Refresh Control to Table View
        // Configure Refresh Control
        
        canadaFactsListTableView.dataSource = self
        canadaFactsListTableView.delegate = self
        canadaFactsListTableView.register(CandaInfoTableViewCell.self, forCellReuseIdentifier: "CandaInfoTableViewCell")
        canadaFactsListTableView.rowHeight = UITableView.automaticDimension
        canadaFactsListTableView.estimatedRowHeight = CGFloat(estimatedRowHeight)
        canadaFactsListTableView.tableFooterView = UIView()
    }
    
    private func fetchCanadaFacts() {
        NetworkServiceManager.sharedInstance.fetchCanadaFacts { [weak self] result in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
            
            switch result {
            case let .success(facts): print(facts)
            self?.factTitle = facts.title
            self?.factArray = facts.rows
            
            //Refreshing UITableView on Main Thread
            DispatchQueue.main.async {
                self?.setUpNavigation()
                self?.canadaFactsListTableView.reloadData()
                }
            case .failure(_): self?.showAlert(errorType: .apiError)
            }
        }
    }
    
}
extension AboutCanadaListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = factArray {
            return array.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let canadaCell = tableView.dequeueReusableCell(withIdentifier: "CandaInfoTableViewCell", for: indexPath) as! CandaInfoTableViewCell
        if let imageStringURL = factArray?[indexPath.row].imageHref {
            canadaCell.infoImageView.sd_setImage(with: URL(string: imageStringURL), placeholderImage: UIImage(named: "placeholder-image"))
        }
        canadaCell.titleLabel.text = factArray?[indexPath.row].title
        canadaCell.detailDescriptionTextView.text = factArray?[indexPath.row].factDescription
        canadaCell.layoutSubviews()
        canadaCell.infoImageView.clipsToBounds = true
        //Move to varaible
        canadaCell.infoImageView.layer.cornerRadius = 25
        return canadaCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedFact = factArray?[indexPath.row]{
            let detailvc =
            CanadaFactsDetailViewController.viewController(selectedFacts:(selectedFact))
               self.navigationController?.pushViewController(detailvc, animated: true)
        }
    }
}
