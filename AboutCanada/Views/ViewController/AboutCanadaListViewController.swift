//
//  AboutCanadaListViewController.swift
//  AboutCanada
//
//  Created by Sarath Sasi on 19/07/20.
//  Copyright © 2020 Sarath Sasi. All rights reserved.
//

import UIKit
import SDWebImage

class AboutCanadaListViewController: UIViewController {
    var factTitle: String?
    var factArray: [Row]?
    
    let canadaFactsListTableView = UITableView()
    var refreshControl = UIRefreshControl()
    var activityView: UIActivityIndicatorView?


    var safeArea: UILayoutGuide!

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCanadaTableViewConstraints()
        self.setupTableView()
        fetchCanadaFacts()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        canadaFactsListTableView.addSubview(refreshControl) // not required when using UITableViewController
       
    }
    @objc func refresh(_ sender: AnyObject) {
      fetchCanadaFacts()
    }
     func showActivityIndicator() {
         activityView = UIActivityIndicatorView(style: .whiteLarge)
         activityView?.center = self.view.center
         self.view.addSubview(activityView!)
         activityView?.startAnimating()
     }

     func hideActivityIndicator(){
         if (activityView != nil){
             activityView?.stopAnimating()
         }
     }

    
    func setUpNavigation() {
        navigationItem.title = self.factTitle
        self.navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    private func showAlert(errorType: NetworkError) {
        //Add UIAlert after functionalty implementation
        print("Alert!!!!!!:\(errorType)")
    }
    func setupTableView(){
        // Add Refresh Control to Table View
        // Configure Refresh Control
        
        self.canadaFactsListTableView.dataSource = self
        self.canadaFactsListTableView.delegate = self
        self.canadaFactsListTableView.register(CandaInfoTableViewCell.self, forCellReuseIdentifier: "CandaInfoTableViewCell")
        canadaFactsListTableView.rowHeight = UITableView.automaticDimension
          canadaFactsListTableView.estimatedRowHeight = 420
        canadaFactsListTableView.tableFooterView = UIView()
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        fetchCanadaFacts()
    }
    func fetchCanadaFacts() {
            NetworkServiceManager.sharedInstance.fetchCanadaFacts { [weak self] result in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
            
            switch result {
            case let .success(facts): print(facts)
            // assing to variable
            self?.factTitle = facts.title
            self?.factArray = facts.rows
            //Refreshing UITableView on Main Thread
            DispatchQueue.main.async {
                self?.setUpNavigation()
                self?.canadaFactsListTableView.reloadData()
                }
            case let .failure(error): self?.showAlert(errorType: .apiError)
            }
        }
        
    }
    func layoutCanadaTableViewConstraints() {
        view.addSubview(canadaFactsListTableView)
        canadaFactsListTableView.translatesAutoresizingMaskIntoConstraints = false
        canadaFactsListTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        canadaFactsListTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        canadaFactsListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        canadaFactsListTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AboutCanadaListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = factArray{
            return array.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let canadaCell = tableView.dequeueReusableCell(withIdentifier: "CandaInfoTableViewCell", for: indexPath) as! CandaInfoTableViewCell
        if let imageStringURL = factArray?[indexPath.row].imageHref{
            canadaCell.infoImageView.sd_setImage(with: URL(string: imageStringURL), placeholderImage: UIImage(named: "placeholder-image"))
        }
        canadaCell.titleLabel.text = factArray?[indexPath.row].title
        canadaCell.detailDescriptionTextView.text = factArray?[indexPath.row].rowDescription
//        canadaCell.layoutSubviews()
//        view.layoutIfNeeded()
        canadaCell.infoImageView.clipsToBounds = true
        canadaCell.infoImageView.layer.cornerRadius = 25

        return canadaCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailvc = CanadaFactsDetailViewController.viewController(selectedFacts:(factArray?[indexPath.row])! )
               self.navigationController?.pushViewController(detailvc, animated: true)
    }
    
    
}
