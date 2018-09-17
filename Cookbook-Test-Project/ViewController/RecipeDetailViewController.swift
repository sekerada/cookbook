//
//  RecipeDetailViewController.swift
//  Cookbook
//
//  Created by Adam Sekeres on 16.9.18.
//  Copyright © 2018 Dominik Vesely. All rights reserved.
//

import UIKit
import SnapKit

class RecipeDetailViewController: UIViewController {

    weak var scrollView: UIScrollView!
    let viewModel: RecipeDetailViewModelling
    let headerImageView = UIImageView(image: #imageLiteral(resourceName: "img_big"))
    
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
            make.edges.equalToSuperview().
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
