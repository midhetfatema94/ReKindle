//
//  YourBooksViewController.swift
//  ReKindle
//
//  Created by Midhet Sulemani on 4/16/21.
//

import UIKit

class YourBooksViewController: UIViewController {

    @IBOutlet weak var booksTable: UITableView!
    
    var userId: String = ""
    var myBooks = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        booksTable.tableFooterView = UIView()
        loadBooks()
    }
    
    func loadBooks()  {
        WebService.shared.getUserBooks(userId: userId, completion: {[weak self] (response) in
            DispatchQueue.main.async {
                if let result = response {
                    self?.myBooks = result
                    self?.booksTable.reloadData()
                } else {
                    print("Failed to receive book details")
                }
            }
        })
    }
}

extension YourBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let bookCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BooksTableViewCell {
            bookCell.configure(data: myBooks[indexPath.row])
            bookCell.selectionStyle = .none
            return bookCell
        }
        return UITableViewCell()
    }
}

extension YourBooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //On selection show detailed page of book
    }
}
