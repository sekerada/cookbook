//
//  RecipeDetailViewController.swift
//  Cookbook
//
//  Created by Adam Sekeres on 16.9.18.
//  Copyright © 2018 Dominik Vesely. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RecipeDetailViewController: UIViewController {

    weak var scrollView: UIScrollView!
    let viewModel: RecipeDetailViewModelling
    let headerImageView = UIImageView(image: #imageLiteral(resourceName: "img_big"))
    let nameLabel = UILabel()
    let scoreLabel = UILabel()
    let durationLabel = UILabel()
    let overlayView = UIView()
    var generalInfoVStack: UIStackView!
    var ingredientsVStack: UIStackView!
    var ingredientsLabel: UILabel!
    
    let informationLabel = UILabel()
    let descriptionLabel = UILabel()
    
    init(viewModel: RecipeDetailViewModelling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        self.scrollView = scrollView
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.height.equalTo(scrollView.snp.width)
        }
        
        overlayView.backgroundColor = UIColor.cookbookBlack
        overlayView.alpha = 0.7
        scrollView.addSubview(overlayView)
        overlayView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.height.equalTo(scrollView.snp.width)
        }
        
        let headerRatingAndDurationView = UIView()
        headerRatingAndDurationView.backgroundColor = UIColor.cookbookPink
        scrollView.addSubview(headerRatingAndDurationView)
        
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        nameLabel.textColor = UIColor.white
        nameLabel.numberOfLines = 0
        scrollView.addSubview(nameLabel)
        
        headerRatingAndDurationView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalTo(headerImageView.snp.bottom)
            make.height.equalTo(60)
            make.width.equalToSuperview()
        }
        
        durationLabel.textColor = UIColor.white
        durationLabel.font = UIFont.systemFont(ofSize: 15)
        durationLabel.textAlignment = .right
        
        
        headerRatingAndDurationView.addSubview(durationLabel)
        headerRatingAndDurationView.addSubview(scoreLabel)
        
        durationLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(headerRatingAndDurationView.snp.top).offset(-20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-60)
        }
        
        scoreLabel.textAlignment = .left
        scoreLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
        }
        
        
        //MARK: General info stack
        informationLabel.tintColor = UIColor.cookbookBlack
        informationLabel.font = UIFont.systemFont(ofSize: 16)
        informationLabel.textAlignment = .left
        
        let ingredientsLabel = UILabel()
        self.ingredientsLabel = ingredientsLabel
        ingredientsLabel.text = "Ingredience"
        ingredientsLabel.textAlignment = .left
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.textColor = UIColor.cookbookBlue
        ingredientsLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        let ingredientsVStack = UIStackView(arrangedSubviews: [ingredientsLabel])
        ingredientsVStack.axis = .vertical
        ingredientsVStack.spacing = 5
        self.ingredientsVStack = ingredientsVStack
        
        let descriptionSectionTitleLabel = UILabel()
        descriptionSectionTitleLabel.textAlignment = .left
        descriptionSectionTitleLabel.textColor = UIColor.cookbookBlue
        descriptionSectionTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        descriptionSectionTitleLabel.text = "Příprava jídla"
        
        descriptionLabel.tintColor = UIColor.cookbookBlack
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        
        let descriptionSectionVStack = UIStackView(arrangedSubviews: [descriptionSectionTitleLabel, descriptionLabel])
        descriptionSectionVStack.axis = .vertical
        
         self.generalInfoVStack = UIStackView(arrangedSubviews: [
            informationLabel,
            ingredientsVStack,
            descriptionSectionVStack
        ])
        generalInfoVStack.axis = .vertical
        generalInfoVStack.spacing = 20
        scrollView.addSubview(generalInfoVStack)
        
//        descriptionLabel.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(30)
//            make.right.equalToSuperview().offset(-30)
//        }
        
        generalInfoVStack.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerRatingAndDurationView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(30)
        }
    }
    
    func setupBindings() {
       _ =  viewModel.recipe.asObservable().subscribe(onNext: { [unowned self] recipe in
            self.reloadTexts()
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("stackViewFrame: \(generalInfoVStack.frame)")
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: generalInfoVStack.bounds.height + generalInfoVStack.frame.origin.y)
    }
    
    func reloadTexts() {
        durationLabel.text = "\(viewModel.recipe.value.duration) min."
        nameLabel.text = "\(viewModel.recipe.value.name)"
        let timeAttachement = NSTextAttachment()
        timeAttachement.image = #imageLiteral(resourceName: "ic_time_white")
        timeAttachement.bounds = CGRect(x: 0, y: -2, width: 14, height: 14)
        let timeTitle = NSMutableAttributedString(string: "")
        timeTitle.append(NSAttributedString(attachment: timeAttachement))
        timeTitle.append(NSAttributedString(string: "  \(viewModel.recipe.value.duration) min."))
        durationLabel.attributedText = timeTitle
        
        let scoreAttachement = NSTextAttachment()
        scoreAttachement.image = #imageLiteral(resourceName: "ic_star_white")
        scoreAttachement.bounds = CGRect(x: 0, y: -2, width: 24, height: 24)
        let scoreLabelTitle = NSMutableAttributedString(string: "")
        for _ in 0..<viewModel.recipe.value.score {
            scoreLabelTitle.append(NSAttributedString(attachment: scoreAttachement))
        }
        scoreLabelTitle.append(NSAttributedString(string: " "))
        scoreLabel.attributedText = scoreLabelTitle
        
        //Description ~ postup
        descriptionLabel.text = viewModel.recipe.value.description
        informationLabel.text = viewModel.recipe.value.info
        
        ingredientsVStack.subviews.forEach({ $0.removeFromSuperview() })
        ingredientsVStack.addArrangedSubview(ingredientsLabel)
        
        for ingredient in viewModel.recipe.value.ingredients {
            let ingredientNameLabel = UILabel()
            ingredientNameLabel.numberOfLines = 0
            ingredientNameLabel.textAlignment = .left
            ingredientNameLabel.text = "•  \(ingredient)"
            ingredientsVStack.addArrangedSubview(ingredientNameLabel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
