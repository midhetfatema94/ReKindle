//
//  ViewController.swift
//  ReKindle
//
//  Created by Midhet Sulemani on 4/16/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func gotoSignup(_ sender: UIButton) {
        if let booksVC = self.storyboard?.instantiateViewController(identifier: "SignupViewController") as? SignupViewController {
            self.navigationController?.pushViewController(booksVC, animated: true)
        }
    }
    
    @IBAction func loginUser(_ sender: UIButton) {
        WebService.shared.loginUser(username: usernameTF.text ?? "", password: passwordTF.text ?? "") {[weak self] (response) in
            DispatchQueue.main.async {
                if let response = response as? [String: Any] {
                    if let booksVC = self?.storyboard?.instantiateViewController(identifier: "YourBooksViewController") as? YourBooksViewController {
                        booksVC.userId = response["userId"] as? String ?? ""
                        self?.navigationController?.pushViewController(booksVC, animated: true)
                    }
                } else {
                    print("Failed to login user")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        background.layer.opacity = 0.5
    }
}

