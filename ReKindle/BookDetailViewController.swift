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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
