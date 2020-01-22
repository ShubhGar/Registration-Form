//
//  RegistrationFormViewController.swift
//  TestRegistraionForm
//
//  Created by Shubham Garg on 22/01/20.
//  Copyright © 2020 Shubham Garg. All rights reserved.
//

import UIKit

class RegistrationFormViewController: UIViewController {
    @IBOutlet weak var nameErrorLbl: UILabel!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet var nameTF:UITextField?
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var emailF: UITextField!
    @IBOutlet weak var dateErrorLbl: UILabel!
    @IBOutlet weak var countryErrorLbl: UILabel!
    var datePicker = UIDatePicker()
    var viewModel = RegistrationFormViewModel()
    
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        
    }
    
    func setUp(){
        nameErrorLbl.isHidden = true
        emailErrorLbl.isHidden = true
        dateErrorLbl.isHidden = true
        countryErrorLbl.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        datePicker.datePickerMode = .date
        dateTF.inputView = datePicker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneBtnAxn))
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelBtnAxn))
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        toolBar.setItems([doneBtn,space,cancelBtn], animated: false)
        dateTF.inputAccessoryView = toolBar
        self.addKeyBoardObserver()
    }
    
    
    func addKeyBoardObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
          if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
              self.bottomConstraint.constant = keyboardSize.height + 50
          }
      }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            self.bottomConstraint.constant = 50
      
        }
    }
    
    @IBAction func submitBtnAxn(_ sender: Any) {
        if !viewModel.checkValid(name: nameTF?.text ?? ""){
            nameErrorLbl.isHidden = false
            return
        }
        else{
           nameErrorLbl.isHidden = true
        }
        if !viewModel.checkValid(country: countryTF?.text ?? ""){
            countryErrorLbl.isHidden = false
            return
        }
        else{
           countryErrorLbl.isHidden = true
        }
        if !viewModel.checkValid(date: dateTF?.text ?? ""){
            dateErrorLbl.isHidden = false
            return
        }
        else{
           dateErrorLbl.isHidden = true
        }
        if !viewModel.checkValid(email: emailF?.text ?? ""){
            emailErrorLbl.isHidden = false
            return
        }
        else{
           emailErrorLbl.isHidden = true
        }
        viewModel.submitDetail(name: nameTF?.text ?? "", country: countryTF?.text ?? "", date: dateTF?.text ?? "", email: emailF?.text ?? "")
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc func doneBtnAxn(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let date = datePicker.date
        dateTF.text = formatter.string(from: date)
    }
    
    @objc func cancelBtnAxn(){
        self.view.endEditing(true)
    }
    
}

