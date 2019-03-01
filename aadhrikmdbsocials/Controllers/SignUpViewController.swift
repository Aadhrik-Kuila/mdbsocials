//
//  SignUpViewController.swift
//  aadhrikmdbsocials
//
//  Created by Aadhrik Kuila on 2/24/19.
//  Copyright © 2019 Aadhrik Kuila. All rights reserved.
//

import UIKit
import Material
import Firebase
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    var fullname : TextField!
    var username : TextField!
    var password : TextField!
    var email : ErrorTextField!
    
    var submitButton : Button!
    var heroImage : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styles current navcontroller
        let navLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 70))
        navLabel.center = CGPoint(x: view.frame.width/2, y: 35)
        navLabel.textColor = .blue
        navLabel.text = "Create an account"
        navLabel.textAlignment = .center
        self.navigationItem.titleView = navLabel
        

 

        
        fullname = TextField(frame: CGRect(x: 0, y: 0, width: 230, height: 50))
        fullname.center = CGPoint(x: view.frame.width/2, y: view.frame.midY - 50)
        fullname.placeholder = "full name"
        fullname.textColor = .blue
        fullname.placeholderVerticalOffset = 10
        fullname.placeholderActiveColor = .blue
        fullname.dividerActiveColor = .blue
        fullname.autocapitalizationType = UITextAutocapitalizationType.none
        fullname.autocorrectionType = UITextAutocorrectionType.no
        
        view.addSubview(fullname)
        
        username = TextField(frame: CGRect(x: 0, y: 0, width: 230, height: 50))
        username.center = CGPoint(x: view.frame.width/2, y: fullname.frame.maxY + 50)
        username.placeholder = "username"
        username.textColor = .blue
        username.placeholderVerticalOffset = 10
        username.placeholderActiveColor = .blue
        username.dividerActiveColor = .blue
        username.autocapitalizationType = UITextAutocapitalizationType.none
        username.autocorrectionType = UITextAutocorrectionType.no
        
        view.addSubview(username)
        
        password = TextField(frame: CGRect(x: 0, y: 0, width: 230, height: 50))
        password.center = CGPoint(x: view.frame.width/2, y: username.frame.maxY + 50)
        password.placeholder = "password"
        password.textColor = .blue
        password.placeholderVerticalOffset = 10
        password.isSecureTextEntry = true
        password.placeholderActiveColor = .blue
        password.dividerActiveColor = .blue
        password.autocapitalizationType = UITextAutocapitalizationType.none
        password.autocorrectionType = UITextAutocorrectionType.no
        
        view.addSubview(password)
        
        email = ErrorTextField(frame: CGRect(x: 0, y: 0, width: 230, height: 50))
        email.center = CGPoint(x: view.frame.width/2, y: password.frame.maxY + 50)
        email.placeholder = "email"
        email.textColor = .blue
        email.placeholderVerticalOffset = 10
        email.placeholderActiveColor = .blue
        email.dividerActiveColor = .blue
        email.autocapitalizationType = UITextAutocapitalizationType.none
        email.autocorrectionType = UITextAutocorrectionType.no
        email.validator.autoValidationType = .always
        email.validator.validate(message: "Must be a valid email") { text in
            return self.isValidEmail(testStr: text) // must not contain 'A'
        }
    
        view.addSubview(email)
        
        submitButton = Button(frame: CGRect(x: 0, y: 0, width: 250, height: 60))
        submitButton.center = CGPoint(x: view.frame.width/2, y: email.frame.maxY + 90)
        submitButton.setTitle("Continue", for: .normal)
        submitButton.backgroundColor = .blue
        submitButton.layer.cornerRadius = submitButton.frame.height/2
        submitButton.pulseColor = .white
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)

        view.addSubview(submitButton)
        
        heroImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 215))
        heroImage.center = CGPoint(x: view.frame.width/2, y: view.frame.height/4)
        heroImage.image = UIImage(named: "register")
        heroImage.contentMode = .scaleAspectFit
        view.addSubview(heroImage)
        
        

        // Do any additional setup after loading the view.
    }
    
    fileprivate func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @objc func submit() {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) {authResult, error in
            if let error = error {
                print(error.localizedDescription)
            }
            var values = [String: Any]()
            values["username"] = self.username.text!
            values["email"] = self.email.text!
            values["fullname"] = self.fullname.text!
            
            Database.database().reference().child("user").child(self.username.text!).setValue(values, withCompletionBlock: { (error, ref) in
                if let error = error {
                    print(error.localizedDescription)
                }
                self.performSegue(withIdentifier: "toFeed", sender: self)
                
            })
            
        }
        
    }

}
