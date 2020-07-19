//
//  AboutCanadaListViewController.swift
//  AboutCanada
//
//  Created by Sarath Sasi on 19/07/20.
//  Copyright © 2020 Sarath Sasi. All rights reserved.
//

import UIKit

class AboutCanadaListViewController: UIViewController {
    var factTitle: String?
    var factArray: [Row]?
    
    let canadaFactsListTableView = UITableView()
    var safeArea: UILayoutGuide!

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCanadaTableViewConstraints()

        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        NetworkServiceManager.sharedInstance.fetchCanadaFacts { [weak self] result in
            switch result {
            case let .success(facts): print(facts)
                // assing to variable
            self?.factTitle = facts.title
            self?.factArray = facts.rows
            
                DispatchQueue.main.async {
                    self?.setupTableView()
                    self?.setUpNavigation()
                }
            case let .failure(error): self?.showAlert(errorType: .apiError)
            }
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
        self.canadaFactsListTableView.dataSource = self
        self.canadaFactsListTableView.delegate = self
        self.canadaFactsListTableView.register(CandaInfoTableViewCell.self, forCellReuseIdentifier: "CandaInfoTableViewCell")
        canadaFactsListTableView.rowHeight = UITableView.automaticDimension
          canadaFactsListTableView.estimatedRowHeight = 420
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
        return factArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let canadaCell = tableView.dequeueReusableCell(withIdentifier: "CandaInfoTableViewCell", for: indexPath) as! CandaInfoTableViewCell
        canadaCell.backgroundColor = .blue
        canadaCell.textLabel?.text = factArray?[indexPath.row].title
        canadaCell.layoutSubviews()
          
        return canadaCell
    }
    
    
}
