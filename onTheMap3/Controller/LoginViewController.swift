//
//  ViewController.swift
//  onTheMap3
//ViewController
//  Created by sid almekhlfi on 25/05/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController ,UITextFieldDelegate {
    
    @IBOutlet weak var Logininbtuuon: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    var studens : StudentLocation!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        updateTextView()
        self.passwordTextField.delegate = self
        self.emailTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    @IBAction func loginTapped(_ sender: Any) {
        
            setLogginIn(true)
        onThemapClient.logIn(username: self.emailTextField.text ?? ""
            , password: self.passwordTextField.text ?? "", completion: handleLogingResonse(success:error:))
        
    }
    
    func updateTextView(){
        let path = "https://auth.udacity.com/sign-up"
        let text = textView.text ?? ""
        let attributedString = NSAttributedString.makeHyperLink(for: path, in: text, as: "SignUp")
        textView.attributedText = attributedString
        
    }
      func handleLogingResonse(success: Bool, error: Error?) {
        
        if success {
                 setLogginIn(false)
                self.performSegue(withIdentifier:"completeLogin", sender: nil)
          
        } else {
           
            
            print( error?.localizedDescription ?? "")
            Alert.showLoginFailure(on:self, message: error?.localizedDescription ?? "")
            setLogginIn(false)
        }
        
        
      }
    
    
    
    
    func setLogginIn(_ Logging:Bool){
        if Logging{
            activityindicator.startAnimating()
            
        } else{
            activityindicator.stopAnimating()
            activityindicator.hidesWhenStopped = true
            
        }
        
        passwordTextField.isEnabled = !Logging
        emailTextField.isEnabled = !Logging
        Logininbtuuon.isEnabled = !Logging
        
        
    }
    
      
}

