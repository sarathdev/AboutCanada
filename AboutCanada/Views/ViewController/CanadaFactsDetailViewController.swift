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
    static func viewController(selectedFacts facts: Row) -> CanadaFactsDetailViewController{
        let viewController = CanadaFactsDetailViewController()
        viewController.selectedDetails = facts
        return viewController
    }
    let infoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "placeholder-image.png"))
      
//        if let imageString = selectedDetails?.imageHref{
//            imageView.loadThumbnail(urlSting: imageString)
//        }
        
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
        
        // Do any additional setup after loading the view.
        view.addSubview(infoImageView)
        view.addSubview(descriptionTextView)
        setupLayout()
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

