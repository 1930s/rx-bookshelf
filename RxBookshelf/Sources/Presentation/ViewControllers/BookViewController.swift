//
//  BookViewController.swift
//  RxBookshelf
//
//  Created by Mario on 27/4/18.
//  Copyright © 2018 Mario Negro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BookViewController: UIViewController, ActivityIndicatorHandler, AlertHandler {
    private let disposeBag = DisposeBag()
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var toolbar: UIToolbar!
    var addBarButtonItem: UIBarButtonItem!
    var removeBarButtonItem: UIBarButtonItem!
    var markReadBarButtonItem: UIBarButtonItem!
    var markUnreadBarButtonItem: UIBarButtonItem!
    var bookViewModel: BookViewModel!
}

extension BookViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
}

private extension BookViewController {
    func setupView() {
        title = L10n.detail.localized
        setupToolbarButtons()
    }
    
    func setupToolbarButtons() {
        addBarButtonItem = UIBarButtonItem(title: L10n.add.localized, style: .plain, target: nil, action: nil)
        removeBarButtonItem = UIBarButtonItem(title: L10n.remove.localized, style: .plain, target: nil, action: nil)
        markReadBarButtonItem = UIBarButtonItem(title: L10n.markRead.localized, style: .plain, target: nil, action: nil)
        markUnreadBarButtonItem = UIBarButtonItem(title: L10n.markUnread.localized, style: .plain, target: nil, action: nil)
    }
}

private extension BookViewController {
    func bindViewModel() {
        bookViewModel.book
            .observeOn(MainScheduler.instance)
            .hideActivityIndicator(in: self)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let book):
                    self?.populate(with: book)
                case .error(_):
                    self?.showErrorAlert(withMessage: L10n.errorExecutingOperation.localized)
                }
            })
            .disposed(by: disposeBag)
        
        addBarButtonItem.rx.tap.asObservable()
            .showActivityIndicator(in: self)
            .bind(to: bookViewModel.addBook)
            .disposed(by: disposeBag)
        
        removeBarButtonItem.rx.tap.asObservable()
            .showActivityIndicator(in: self)
            .bind(to: bookViewModel.removeBook)
            .disposed(by: disposeBag)
        
        markReadBarButtonItem.rx.tap.asObservable()
            .showActivityIndicator(in: self)
            .bind(to: bookViewModel.markRead)
            .disposed(by: disposeBag)
        
        markUnreadBarButtonItem.rx.tap.asObservable()
            .showActivityIndicator(in: self)
            .bind(to: bookViewModel.markUnread)
            .disposed(by: disposeBag)
    }
}

private extension BookViewController {
    func populate(with book: Book) {
        titleLabel.text = book.title
        authorsLabel.text = book.authorsString
        publisherLabel.text = book.publisher
        publishedDateLabel.text = book.publishedDate
        descriptionLabel.text = book.description
        markReadBarButtonItem.isEnabled = book.isInShelf
        coverImageView.populateCoverImage(book)
        setToolbarItems(for: book)
    }
    
    func setToolbarItems(for book: Book) {
        var items = [UIBarButtonItem]()
        
        if book.isInShelf {
            items.append(removeBarButtonItem)
        } else {
            items.append(addBarButtonItem)
        }
        
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        
        if book.isRead {
            items.append(markUnreadBarButtonItem)
        } else {
            items.append(markReadBarButtonItem)
        }
        
        toolbar.setItems(items, animated: false)
    }
}
