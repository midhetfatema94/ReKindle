//
//  BookDetailViewController.swift
//  ReKindle
//
//  Created by Midhet Sulemani on 4/16/21.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookEdition: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var ownerContact: UILabel!
    @IBOutlet weak var ownerLocation: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var book: Book!
    var owner: User!
    var userId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        getUser()
    }
    
    func configureUI() {
        bookTitle.text = book.title
        bookAuthor.text = book.author
        bookEdition.text = book.edition
    }
    
    func configureOwner() {
        ownerName.text = owner.displayName
        ownerContact.text = owner.contact
        ownerLocation.text = owner.location
        
        loader.stopAnimating()
        ownerName.isHidden = false
        ownerContact.isHidden = false
        ownerLocation.isHidden = false
    }
    
    func getUser() {
        WebService.shared.getUserDetails(userId: userId) {[weak self] (response) in
            DispatchQueue.main.async {
                if var response = response as? [String: Any] {
                    response["id"] = self?.userId ?? ""
                    self?.owner = User(details: response)
                    self?.configureOwner()
                } else {
                    print("Failed to get user details")
                }
            }
        }
    }
}
