//
//  BooksTableViewCell.swift
//  ReKindle
//
//  Created by Midhet Sulemani on 4/17/21.
//

import UIKit

class BooksTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookEdition: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(data: Book) {
        bookTitle.text = data.title
        bookAuthor.text = data.author
        bookEdition.text = data.edition
    }
}
