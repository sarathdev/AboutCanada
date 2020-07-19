//
//  CandaInfoTableViewCell.swift
//  AboutCanada
//
//  Created by Sarath Sasi on 19/07/20.
//  Copyright © 2020 Sarath Sasi. All rights reserved.
//

import UIKit

final class CandaInfoTableViewCell: UITableViewCell {
    
    var title: String?
    var infoImage: UIImage?
    var detailDescription: String?
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var infoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder-image")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var detailDescriptionTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutInfoImageView() {
        infoImageView.layer.cornerRadius = 25
        infoImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        infoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        infoImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        infoImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func layoutTitleLabel() {
        titleLabel.leftAnchor.constraint(equalTo: self.infoImageView.rightAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.detailDescriptionTextView.topAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    private func layoutDetailDescriptionTextView() {
        detailDescriptionTextView.leftAnchor.constraint(equalTo: self.infoImageView.rightAnchor).isActive = true
        detailDescriptionTextView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        detailDescriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        detailDescriptionTextView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Adding the subviews to the custom cell
        self.addSubview(titleLabel)
        self.addSubview(infoImageView)
        self.addSubview(detailDescriptionTextView)

        layoutInfoImageView()
        layoutTitleLabel()
        layoutDetailDescriptionTextView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let detailDescription = detailDescription{
            self.detailDescriptionTextView.text = detailDescription
        }
        if let image = infoImage{
            self.infoImageView.image = image
        }
        if let title = title{
            self.titleLabel.text = title
        }
    }
    
}
