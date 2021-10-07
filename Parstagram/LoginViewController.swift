//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Jarod Wellinghoff on 10/6/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
	@IBOutlet var logoImageView: UIImageView!

	@IBOutlet var usernameLabel: UILabel!
	@IBOutlet var passwordLabel: UILabel!

	@IBOutlet var usernameTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!

	@IBOutlet var signUpButton: UIButton!
	@IBOutlet var signInButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		usernameTextField.layer.cornerRadius = 16.0
		usernameTextField.layer.masksToBounds = true
		usernameTextField.layer.borderColor = UIColor.black.cgColor
		usernameTextField.layer.borderWidth = 1.0

		passwordTextField.layer.cornerRadius = usernameTextField.layer.cornerRadius
		passwordTextField.layer.masksToBounds = usernameTextField.layer.masksToBounds
		passwordTextField.layer.borderColor = usernameTextField.layer.borderColor
		passwordTextField.layer.borderWidth = usernameTextField.layer.borderWidth

    }
    
	@IBAction func onSignIn(_ sender: Any) {
		let username = usernameTextField.text!
		let password = passwordTextField.text!

		PFUser.logInWithUsername(inBackground: username, password: password) {
			(user, error) in
			if user != nil {
				self.performSegue(withIdentifier: "loginSegue", sender: nil)
			} else {
				print (error as Any)
			}
		}

	}

	@IBAction func onSiognUp(_ sender: Any) {
		let user = PFUser()
		user.username = usernameTextField.text
		user.password = passwordTextField.text

		user.signUpInBackground { (success, error)  in
			if success {
				self.performSegue(withIdentifier: "loginSegue", sender: nil)
			} else {
				print(error as Any)
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
