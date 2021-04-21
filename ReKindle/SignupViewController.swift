//
//  SignupViewController.swift
//  ReKindle
//
//  Created by Midhet Sulemani on 4/16/21.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var displayNameTF: UITextField!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBAction func signup(_ sender: UIButton) {
        if validateForm() {
            let details = getDictionary()
            
            WebService.shared.signUp(userDetails: details) {[weak self] (response, success) in
                if let documentId = response, success {
                    WebService.shared.getUserDetails(userId: documentId, completionHandler: {(response) in
                        DispatchQueue.main.async {
                            if let userDetails = response as? [String: Any] {
                                if let booksVC = self?.storyboard?.instantiateViewController(identifier: "YourBooksViewController") as? YourBooksViewController {
                                    booksVC.userId = userDetails["userId"] as? String ?? ""
                                    self?.navigationController?.pushViewController(booksVC, animated: true)
                                }
                            } else {
                                print(response as? String ?? "Failed to get user details")
                            }
                        }
                    })
                } else if let error = response {
                    print(error)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func getDictionary() -> [String: Any] {
        var details = [String: Any]()
        
        details["contactInfo"] = contactTF.text
        details["displayName"] = displayNameTF.text
        details["location"] = locationTF.text
        details["password"] = passwordTF.text
        details["username"] = usernameTF.text
        
        return details
    }
    
    func validateForm() -> Bool {
        
        guard let name = displayNameTF.text else { return false }
        
        if name.isEmpty { return false }
        
        guard let contact = contactTF.text else { return false }
        
        if contact.isEmpty { return false }
        
        guard let location = locationTF.text else { return false }
        
        if location.isEmpty { return false }
        
        return validateEmail() && validatePassword()
    }
    
    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: usernameTF.text)
    }
    
    func validatePassword() -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: passwordTF.text)
    }
}
