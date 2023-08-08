//
//  RegisterViewController.swift
//  InstaClone
//
//  Created by Kuanish on 18.07.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(usernameField)
        view.addSubview(userEmail)
        view.addSubview(userPassword)
        view.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        usernameField.delegate = self
        userEmail.delegate = self
        userPassword.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 50, width: view.width - 40, height: 52)
        userEmail.frame = CGRect(x: 20, y: usernameField.bottom + 10, width: view.width - 40, height: 52)
        userPassword.frame = CGRect(x: 20, y: userEmail.bottom + 10, width: view.width - 40, height: 52)
        registerButton.frame = CGRect(x: 20, y: userPassword.bottom + 10, width: view.width - 40, height: 52)

    }
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }

    private let usernameField: UITextField = {
        let field =  UITextField()
        field.placeholder = "Username..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.layer.borderWidth = 1.0
        return field
        
    }()
    private let userEmail: UITextField = {
        let field =  UITextField()
        field.placeholder = "Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.layer.borderWidth = 1.0
        return field
    }()
    
    private let userPassword: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.layer.borderWidth = 1.0
        return field
    }()
    
    @objc func tappedRegisterButton() {
        userEmail.resignFirstResponder()
        userPassword.resignFirstResponder()
        usernameField.resignFirstResponder()
        
        guard let email = userEmail.text , !email.isEmpty ,
              let password = userPassword.text ,!password.isEmpty, password.count >= 8 ,
                let username = usernameField.text , !username.isEmpty else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { succes in
            DispatchQueue.main.async {
                if succes {
                    print("Success")
                }
                else {
                    
                }
            }
        }

    }
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()

    

}
extension RegisterViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            userEmail.becomeFirstResponder()
        }
        else if textField == userEmail {
            userPassword.becomeFirstResponder()
        }
        else {
            tappedRegisterButton()
        }
        return true
    }
}
