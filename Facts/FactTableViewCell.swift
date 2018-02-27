//
//  FactTableViewCell.swift
//  Facts
//
//  Created by Tahmina Khanam on 27/2/18.
//  Copyright © 2018 Cognizant. All rights reserved.
//

import UIKit
import SnapKit

class FactTableViewCell: UITableViewCell {
    let titleLabel: UILabel = UILabel()
    let descriptionLabel: UILabel = UILabel()
    let factImageView: UIImageView = UIImageView()
    var imageViewRatioConstraint: Constraint? = nil
    var imageViewHeightConstraint: Constraint? = nil
    
    static let reuseIdentifier = "FactTableViewCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    func configureViews() {
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
        factImageView.contentMode = .scaleAspectFit
        let wrapper = UIView()
        wrapper.clipsToBounds = true
        wrapper.layer.cornerRadius = 5
        wrapper.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        contentView.addSubview(wrapper)
        wrapper.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(10, 10, 10, 10))
        }
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
        verticalStackView.spacing = 10
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fill
        horizontalStackView.alignment = .center
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(factImageView)
        
        factImageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        wrapper.addSubview(horizontalStackView)
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalTo(wrapper).inset(UIEdgeInsetsMake(10, 10, 10, 10))
        }
    }
    
    func configure(_ fact: Fact) {
        titleLabel.text = fact.title
        descriptionLabel.text = fact.description ?? "No description provided"
        factImageView.kf.setImage(with: fact.imageHref)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        factImageView.kf.cancelDownloadTask()
        factImageView.image = nil
    }
}
