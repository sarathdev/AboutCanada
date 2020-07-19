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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        NetworkServiceManager.sharedInstance.fetchCanadaFacts { [weak self] result in
            switch result {
            case let .success(facts): print(facts)
                // assing to variable
            self?.factTitle = facts.title
            self?.factArray = facts.rows
            
                DispatchQueue.main.async {
                    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
