//
//  RecipeTableViewCell.swift
//  Cookbook
//
//  Created by Adam Sekeres on 16.9.18.
//  Copyright © 2018 Dominik Vesely. All rights reserved.
//

import UIKit
import SnapKit

class RecipeTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel!
    var recipeImageView: UIImageView!
    var durationLabel: UILabel!
    var scoreLabel: UILabel!
    var descriptionVStack: UIStackView!
    var separatorView: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let ratingStackSpacing:CGFloat = 2
        
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.cookbookBlue
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 17)
        self.nameLabel = nameLabel
        
        let ratingStarImageView = UIImageView(image: #imageLiteral(resourceName: "ic_star"))
        let elasticView = UIView()
        
        elasticView.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: UILayoutConstraintAxis.horizontal)
        
        let recipeImageView = UIImageView(image: #imageLiteral(resourceName: "img_small"))
        self.recipeImageView = recipeImageView
        self.addSubview(recipeImageView)
        
        let durationLabel = UILabel()
        durationLabel.textAlignment = .left
        durationLabel.textColor = UIColor.cookbookBlack
        self.durationLabel = durationLabel
        
        let scoreLabel = UILabel()
        scoreLabel.textAlignment = .left
        self.scoreLabel = scoreLabel
        scoreLabel.font = UIFont.systemFont(ofSize: 15)
        
        let descriptionVStack = UIStackView(arrangedSubviews: [
            nameLabel,
            scoreLabel,
            durationLabel
            ])
        descriptionVStack.axis = .vertical
        descriptionVStack.spacing = 3
        self.descriptionVStack = descriptionVStack
        self.addSubview(descriptionVStack)
        
        recipeImageView.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.centerY.equalToSuperview()
            //make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 96, height: 96))
        }
        
        descriptionVStack.snp.makeConstraints { (make) in
            make.top.equalTo(recipeImageView.snp.top)
            make.left.equalTo(recipeImageView.snp.right).offset(30)
            make.right.equalToSuperview().offset(-20)
        }
        
        ratingStarImageView.snp.makeConstraints { (make) in
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor.cookbookLightGray
        self.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { (make) in
            make.height.equalTo(2)
            make.bottom.equalToSuperview().offset(-2)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        self.layoutIfNeeded()
        
    }
    
    func setupView(recipe: Recipe) {
        nameLabel.text = recipe.name
        let timeAttachement = NSTextAttachment()
        timeAttachement.image = #imageLiteral(resourceName: "ic_time")
        timeAttachement.bounds = CGRect(x: 0, y: -2, width: 14, height: 14)
        let timeTitle = NSMutableAttributedString(string: "")
        timeTitle.append(NSAttributedString(attachment: timeAttachement))
        timeTitle.append(NSAttributedString(string: "  \(recipe.duration) min."))
        durationLabel.attributedText = timeTitle
        
        let scoreAttachement = NSTextAttachment()
        scoreAttachement.image = #imageLiteral(resourceName: "ic_star")
        scoreAttachement.bounds = CGRect(x: 0, y: -2, width: 16, height: 16)
        let scoreLabelTitle = NSMutableAttributedString(string: "")
        descriptionVStack.arrangedSubviews[1].isHidden = recipe.score == 0 ? true : false
        for _ in 0..<recipe.score {
            scoreLabelTitle.append(NSAttributedString(attachment: scoreAttachement))
        }
        scoreLabelTitle.append(NSAttributedString(string: " "))
        scoreLabel.attributedText = scoreLabelTitle
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
