//
//  LoginViewController.swift
//  aadhrikmdbsocials
//
//  Created by Aadhrik Kuila on 2/24/19.
//  Copyright © 2019 Aadhrik Kuila. All rights reserved.
//

import UIKit
import Material
import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    var username : TextField!
    var password : TextField!
    var submitButton : Button!
    var heroImage : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styles current navcontroller
        let navLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 70))
        navLabel.center = CGPoint(x: view.frame.width/2, y: 35)
        navLabel.textColor = .blue
        navLabel.text = "Login"
        navLabel.textAlignment = .center
        self.navigationItem.titleView = navLabel
        
 


        
        
        username = TextField(frame: CGRect(x: 0, y: 0, width: 250, height: 60))
        username.center = CGPoint(x: view.frame.width/2, y: view.frame.midY + 50)
        username.placeholder = "username"
        username.textColor = .blue
        username.placeholderVerticalOffset = 10
        username.placeholderActiveColor = .blue
        username.dividerActiveColor = .blue
        username.autocapitalizationType = UITextAutocapitalizationType.none
        username.autocorrectionType = UITextAutocorrectionType.no
        
        view.addSubview(username)
        
        
        password = TextField(frame: CGRect(x: 0, y: 0, width: 250, height: 60))
        password.center = CGPoint(x: view.frame.width/2, y: username.frame.maxY + 75)
        password.placeholder = "password"
        password.textColor = .blue
        password.placeholderVerticalOffset = 10
        password.isSecureTextEntry = true
        password.placeholderActiveColor = .blue
        password.dividerActiveColor = .blue
        password.autocapitalizationType = UITextAutocapitalizationType.none
        password.autocorrectionType = UITextAutocorrectionType.no
        
        view.addSubview(password)
        
        
        submitButton = Button(frame: CGRect(x: 0, y: 0, width: 250, height: 60))
        submitButton.center = CGPoint(x: view.frame.width/2, y: password.frame.maxY + 100)
        submitButton.setTitle("Continue", for: .normal)
        submitButton.backgroundColor = .blue
        submitButton.layer.cornerRadius = submitButton.frame.height/2
        submitButton.pulseColor = .white
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        
        view.addSubview(submitButton)
        
        heroImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 300))
        heroImage.center = CGPoint(x: view.frame.width/2, y: 275)
        heroImage.image = UIImage(named: "dualipa")
        heroImage.contentMode = .scaleAspectFit
        view.addSubview(heroImage)
        
        
        
   
        

        // Do any additional setup after loading the view.
    }
    
    @objc func submit() {
        
        Database.database().reference().child("user").child(username.text!).observeSingleEvent(of: .value) { (snap) in
            guard let data = snap.value as? [String: Any?] else {return}
            
            let emailstring = data["email"] as! String
            Auth.auth().signIn(withEmail: emailstring, password: self.password.text!) { (auth, err) in
                if let error = err {
                    print(error)
                    return
                }
                self.performSegue(withIdentifier: "toFeed", sender: self)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
