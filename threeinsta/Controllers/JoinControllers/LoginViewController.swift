//
//  LoginViewController.swift
//  InstaClone
//
//  Created by Kuanish on 18.07.2023.
//
import Foundation
import UIKit
import SafariServices


class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let userEmail: UITextField = {
        let field =  UITextField()
        field.placeholder = "Username or email"
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private let creatorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Creator`s Account", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let createAccButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("No account? Create one!", for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let entranceLogo = UIImageView(image: UIImage(named: "EntranceLogo"))
        header.addSubview(entranceLogo)
        return header
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .systemBackground
        userEmail.delegate = self
        userPassword.delegate = self
        
        createAccButton.addTarget(self, action: #selector(tappedCreateAccButton), for: .touchUpInside)
        creatorButton.addTarget(self, action: #selector(tappedCreatorButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        creatorButton.frame = CGRect(x: 25,
                                     y: view.height*0.9,
                                     width: view.width-50,
                                     height: 52)
        headerView.frame = CGRect(x: 0,
                                  y: 0.0,
                                  width: view.width,
                                  height: view.height/3.0)
        userEmail.frame = CGRect(x: 25,
                                 y: headerView.bottom + 10,
                                 width: view.width - 50,
                                 height: 52.0)
        userPassword.frame = CGRect(x: 25,
                                    y: userEmail.bottom + 10,
                                    width: view.width - 50,
                                    height: 52.0)
        loginButton.frame = CGRect(x: 25,
                                   y: userPassword.bottom + 10,
                                   width: view.width - 50,
                                   height: 52.0)
        createAccButton.frame = CGRect(x: 25,
                                   y: loginButton.bottom + 10,
                                   width: view.width - 50,
                                   height: 52.0)
  
        configureEntranceView()
    
    }
    private func configureEntranceView() { // проверка на пустоту subviews y UIView и установка constraints.
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        let entranceText = UILabel()
        entranceText.text = "𝑻𝒉𝒓𝒆𝒂𝒊𝒏𝒔𝒕𝒂"
        entranceText.textColor = .white
        let labelSize = CGSize(width: 140, height: 60)
        let labelRect = CGPoint(x: headerView.width/2.6, y: headerView.height/2)
        entranceText.font = UIFont(name: "", size: 44)
        headerView.addSubview(entranceText)
        entranceText.frame = CGRect(origin: labelRect, size: labelSize)
        
    }
        private func addSubviews() {
        view.addSubview(loginButton)
        view.addSubview(userEmail)
        view.addSubview(userPassword)
        view.addSubview(headerView)
        view.addSubview(createAccButton)
        view.addSubview(creatorButton)
    }
    @objc func tappedLoginButton() {
        userPassword.resignFirstResponder()
        userEmail.resignFirstResponder()
        
        
        guard let userEmails = userEmail.text ,!userEmails.isEmpty else {
            return
        }
        
        guard let password = userPassword.text,
              !password.isEmpty, password.count >= 8 else {
            return
        }
        
       AuthManager.shared.loginNewUser(email: userEmails,password: password) { succes in
            DispatchQueue.main.async {
                if succes {
                    self.dismiss(animated: true)
                } else {
                    let alert = UIAlertController(title: "Log in Error",
                                                  message: "Something went wrong",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .cancel ,
                                                  handler: nil))
                    self.present(alert, animated: true)
                    print("fdfdfdf")
                }
            }
        }
    }
    
    @objc func tappedCreateAccButton() {
        let registrationVC = RegisterViewController()
        registrationVC.title = "Create Account"
        
        present(UINavigationController(rootViewController: registrationVC),animated: true)
    }
    @objc func tappedCreatorButton() {
        guard let URL = URL(string: "https://instagram.com/poulixiz?igshid=OGQ5ZDc2ODk2ZA%3D%3D") else {
            return
        }
        let vc = SFSafariViewController(url: URL)
        present(vc, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userEmail {
            userPassword.becomeFirstResponder()
        }
        else if textField == userPassword {
            tappedLoginButton()
        }
        return true
    }
}

