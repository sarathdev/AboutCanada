//
//  CandaInfoTableViewCell.swift
//  AboutCanada
//
//  Created by Sarath Sasi on 19/07/20.
//  Copyright © 2020 Sarath Sasi. All rights reserved.
//

import UIKit

class CandaInfoTableViewCell: UITableViewCell {
    
    var title: String?
    var infoImage: UIImage?
    var detailDescription: String?
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var infoImageView: UIImageView = {
        var imageView = UIImageView()
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Adding the subviews to the custom cell
        self.addSubview(titleLabel)
        self.addSubview(infoImageView)
        self.addSubview(detailDescriptionTextView)
        
        infoImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        infoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        infoImageView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
        //constraints for title label
        titleLabel.leftAnchor.constraint(equalTo: self.infoImageView.rightAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.detailDescriptionTextView.topAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        
        //constraints for detailDescriptionTextView
        detailDescriptionTextView.leftAnchor.constraint(equalTo: self.infoImageView.rightAnchor).isActive = true
        detailDescriptionTextView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        detailDescriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        detailDescriptionTextView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
        
        
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
