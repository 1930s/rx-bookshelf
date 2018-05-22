//
//  BookInListView.xib
//  RxBookshelf
//
//  Created by Mario on 30/4/18.
//  Copyright © 2018 Mario Negro. All rights reserved.
//

import UIKit

class BookInListView: UIView {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    
    func configure(with book: Book) {
        titleLabel.text = book.title
        authorsLabel.text = book.authorsString
        coverImageView.populateCoverImage(book)
    }
    
    func prepareForReuse() {
        titleLabel.text = nil
        authorsLabel.text = nil
        coverImageView.image = nil
    }
}
