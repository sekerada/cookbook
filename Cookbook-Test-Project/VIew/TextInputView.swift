//
//  TextInputView.swift
//  Cookbook
//
//  Created by Adam Sekeres on 16.9.18.
//  Copyright © 2018 Dominik Vesely. All rights reserved.
//

import Foundation
import UIKit

class TextInputView: UIView {
    
    var inputVStack: UIStackView!
    var nameLabel: UILabel!
    var textField: UITextField!
    
     init() {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.cookbookBlue
        nameLabel.numberOfLines = 0
        nameLabel.text = "Neco"
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        self.nameLabel = nameLabel
        
        let textField = UITextField()
        textField.text = "Neco 333"
        textField.textColor = UIColor.cookbookBlack
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.text = "text11111"
        self.textField = textField
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.cookbookLightGray
        
        let inputVStack = UIStackView(arrangedSubviews: [
            nameLabel,
            textField,
            separatorView
            ])
        inputVStack.axis = .vertical
        inputVStack.spacing = 10
        separatorView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
        }
        
        super.init(frame: CGRect.zero)
        
        self.inputVStack = inputVStack
        self.addSubview(inputVStack)
        
        inputVStack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
