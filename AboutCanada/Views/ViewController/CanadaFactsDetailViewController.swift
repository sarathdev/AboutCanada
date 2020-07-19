//
//  CanadaFactsDetailViewController.swift
//  AboutCanada
//
//  Created by Sarath Sasi on 19/07/20.
//  Copyright © 2020 Sarath Sasi. All rights reserved.
//

import Foundation
import UIKit

final class CanadaFactsDetailViewController: UIViewController {
    
    var selectedDetails: Row?
    static func viewController(selectedFacts facts: Row?) -> CanadaFactsDetailViewController{
        let viewController = CanadaFactsDetailViewController()
        viewController.selectedDetails = facts
        return viewController
    }
    let infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        //        textView.text = selectedDetails?.description
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigation()
        // Do any additional setup after loading the view.
        view.addSubview(infoImageView)
        view.addSubview(descriptionTextView)
        if let imageStrnig = selectedDetails?.imageHref, let imageURL = URL(string: imageStrnig){
            infoImageView.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "placeholder-image"))

        }
        descriptionTextView.text = selectedDetails?.rowDescription
        setupLayout()
    }
    func setUpNavigation() {
            navigationItem.title = selectedDetails?.title
               self.navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
               self.navigationController?.navigationBar.isTranslucent = false
        }
    private func setupLayout() {
           // Constraints for infoImageView
           infoImageView.translatesAutoresizingMaskIntoConstraints = false
           infoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           infoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 6).isActive = true

           //Constraints for details TextView
           descriptionTextView.topAnchor.constraint(equalTo: infoImageView.bottomAnchor, constant: 8).isActive = true
           descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
           descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
       }
}

