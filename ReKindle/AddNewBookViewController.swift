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
    
    @IBAction func uploadImage(_ sender: UIButton) {
    }
    
    @IBAction func addBookDetails(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
