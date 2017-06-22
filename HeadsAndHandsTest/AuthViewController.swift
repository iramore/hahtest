//
//  AuthViewController.swift
//  HeadsAndHandsTest
//
//  Created by infuntis on 21/06/17.
//  Copyright © 2017 gala. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, UITextFieldDelegate{
    
    private let wrongPass = "Невалидный пароль (1 число, 1 строчная, 1 прописная)"
    private let wrongEmail = "Невалидная почта"
    private let usualPass = "Пароль"
    private let usualEmail = "Почта"
    
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var signInBtn: UIButton!
    
    var weaterDataModel = WeaterDataModel()
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Погода", message: "Погода на сегодня в \(weaterDataModel.location!): \n  \(weaterDataModel.temp!), \(weaterDataModel.weather!)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func bPressed(_ sender: Any) {
        print("pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTF.addBorderBottom(height: 1.0, color: UIColor(hex:"#CCCCCC"))
        passwordTF.addBorderBottom(height: 1.0, color: UIColor(hex:"#CCCCCC"))
        
        
        forgetBtn.backgroundColor = .clear
        forgetBtn.layer.cornerRadius = 3
        forgetBtn.layer.borderWidth = 1
        forgetBtn.layer.borderColor = UIColor(hex:"#CCCCCC").cgColor
        
        signInBtn.layer.cornerRadius = 20
        
        NotificationCenter.default.addObserver(self, selector:  #selector(self.keyboardWillShow(sender:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(sender:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        weaterDataModel.downloadWeather()
        emailTF.delegate = self
        passwordTF.delegate = self
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        if let id = textField.accessibilityIdentifier {
            if id == "emailTF"{
                if !validateEmail(enteredEmail: textField.text!){
                    emailLbl.textColor = UIColor.red
                    emailLbl.text = wrongEmail
                } else{
                    emailLbl.textColor = UIColor(hex: "#8E8E8E")
                    emailLbl.text = usualEmail
                }
            }
            if id == "passTF"{
                if !validatePass(enteredPass: textField.text!){
                    passwordLbl.textColor = UIColor.red
                    passwordLbl.text = wrongPass
                } else{
                    passwordLbl.textColor = UIColor(hex: "#8E8E8E")
                    passwordLbl.text = usualPass
                }
                
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        if let id = textField.accessibilityIdentifier {
            if id == "passTF"{
                
                let maxLength = 18
                let currentString: NSString = textField.text! as NSString
                let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= maxLength
            }
        }
        return true
    }
    
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -100
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    func validatePass(enteredPass:String) -> Bool {
        
        let emailFormat = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredPass)
        
    }
}




