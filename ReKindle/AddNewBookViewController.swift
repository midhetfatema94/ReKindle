//
//  AddNewBookViewController.swift
//  ReKindle
//
//  Created by Midhet Sulemani on 4/16/21.
//

import UIKit

class AddNewBookViewController: UIViewController {

    @IBOutlet weak var bookTitleTF: UITextField!
    @IBOutlet weak var bookAuthorTF: UITextField!
    @IBOutlet weak var bookEditionTF: UITextField!
    @IBOutlet weak var bookImageTF: UITextField!
    @IBOutlet weak var imageUploadButton: UIButton!
    
    weak var dataDelegate: DataUpdateProtocol?
    var userId: String?
    
    @IBAction func uploadImage(_ sender: UIButton) {
    }
    
    @IBAction func addBookDetails(_ sender: UIButton) {
        
        if validateForm() {
            var bookDetails: [String: Any] = [:]
            bookDetails["title"] = bookTitleTF.text
            bookDetails["author"] = bookAuthorTF.text
            bookDetails["bookImageUrl"] = bookImageTF.text ?? ""
            bookDetails["edition"] = bookEditionTF.text
            bookDetails["ownerId"] = userId ?? ""
            
            submitBookDetails(details: bookDetails)
        } else {
            print("form details are not correct")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func submitBookDetails(details: [String: Any]) {
        WebService.shared.newBook(bookData: details) {[weak self] (response) in
            DispatchQueue.main.async {
                if let error = response as? Error {
                    print("Failed to add new book", error.localizedDescription)
                } else {
                    self?.dataDelegate?.reloadTable()
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func validateForm() -> Bool {
        guard let title = bookTitleTF.text else { return false }
        
        guard let author = bookAuthorTF.text else { return false }
        
        guard let edition = bookEditionTF.text else { return false }
        
        if title.isEmpty { return false }
        
        if author.isEmpty { return false }
        
        if edition.isEmpty { return false }
        
        return true
    }
}
