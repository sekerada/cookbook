//
//  NewRecipeViewController.swift
//  Cookbook
//
//  Created by Adam Sekeres on 16.9.18.
//  Copyright © 2018 Dominik Vesely. All rights reserved.
//

import UIKit
import SnapKit

class NewRecipeViewController: UIViewController {
   
    weak var scrollView: UIScrollView!
    let viewModel: NewRecipeViewModelling
    
    let  nameInputView = TextInputView()
    let  initialTextInputView = TextInputView()
    let  ingredientInputView = TextInputView()
    var  ingredientsVStack: UIStackView!
    var  topInformationVStack: UIStackView!
    
    let  addIngredientButton = UIButton(type: .custom)

    var  bottomInformationVStack: UIStackView!
    let  procedureInputView = TextInputView()

    
    init(viewModel: NewRecipeViewModelling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        
        let scrollView = UIScrollView()
        self.scrollView = scrollView
        scrollView.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        nameInputView.nameLabel.text = viewModel.nameLabelTitle
        initialTextInputView.nameLabel.text = viewModel.initialTextLabelTitle
        procedureInputView.nameLabel.text = viewModel.procedureLabelTitle
        ingredientInputView.nameLabel.text = viewModel.ingredientsLabelTitle
        
        
        let ingredientsVStack = UIStackView(arrangedSubviews: [ingredientInputView])
        self.ingredientsVStack = ingredientsVStack
        ingredientsVStack.axis = .vertical
        ingredientsVStack.spacing = 10
        
        //MARK: Ingredients section VStack
        addIngredientButton.setTitle("Přidat", for: .normal)
        addIngredientButton.setTitleColor(UIColor.cookbookPink, for: .normal)
        addIngredientButton.setImage(#imageLiteral(resourceName: "ic_add_small"), for: .normal)
        addIngredientButton.layer.borderColor = UIColor.cookbookPink.cgColor
        addIngredientButton.layer.borderWidth = 2
        addIngredientButton.layer.cornerRadius = 10
        
        let topInformationVStack = UIStackView(arrangedSubviews: [
            nameInputView,
            initialTextInputView,
            ingredientsVStack,
//            addIngredientButton
//            procedureInputView
            ])
        topInformationVStack.axis = .vertical
        scrollView.addSubview(topInformationVStack)
        
        nameInputView.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).offset(-40)
            make.height.equalTo(60)
        }
        
        topInformationVStack.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(addIngredientButton)
        addIngredientButton.snp.makeConstraints { (make) in
            make.top.equalTo(topInformationVStack.snp.bottom).offset(20)
            make.left.equalTo(topInformationVStack.snp.left)
            make.width.equalTo(82)
            make.height.equalTo(32)
        }
        
        
        //MARK: Time picker view layout
        let timeLabel = UILabel()
        timeLabel.text = "Čas"
        timeLabel.textColor = UIColor.cookbookBlack
        
        let timePickerTextView = UITextField()
        timePickerTextView.text = "60min."
        timePickerTextView.textAlignment = .right
        let timePicker = UIPickerView()
        timePicker.delegate = self
        timePicker.dataSource = self
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        let flexibleSeparator = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Hotovo", style: .done, target: nil, action: nil)
        toolBar.items = [flexibleSeparator, doneButton]
        timePickerTextView.inputAccessoryView = toolBar
        timePickerTextView.inputView = timePicker
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.cookbookLightGray
        
        let timeViewHStack = UIStackView(arrangedSubviews: [
                timeLabel,
                timePickerTextView
            ])
        timeViewHStack.axis = .horizontal
        
        let timeSelectionVStack = UIStackView(arrangedSubviews: [
            timeViewHStack,
            separatorView
            ])
        timeSelectionVStack.axis = .vertical
        timeSelectionVStack.spacing = 10
        
        let bottomInformationVStack = UIStackView(arrangedSubviews: [
            procedureInputView,
            timeSelectionVStack
            ])
        bottomInformationVStack.axis = .vertical
        bottomInformationVStack.spacing = 10
        scrollView.addSubview(bottomInformationVStack)
        
        separatorView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
        }
        
        procedureInputView.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).offset(-40)
            make.height.equalTo(60)
        }
        
        bottomInformationVStack.snp.makeConstraints { (make) in
            make.top.equalTo(addIngredientButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
    }
    
     required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Přidat recept"
        let rightBarButtonItem = UIBarButtonItem(title: "Přidat", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension NewRecipeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 15
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(component*10)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //viewmodel.neco...
    }
}
