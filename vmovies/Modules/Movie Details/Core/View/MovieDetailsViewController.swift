//
//  MovieDetailsViewController.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/7/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var presenter: MovieDetailsViewToPresenter!
    @IBOutlet private weak var navigationHeader: NavigationHeader!
    @IBOutlet private weak var movieImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationHeader.bindData(title: R.string.strings.movieDetailTitle(), delegate: self)
        movieImageView.backgroundColor = presenter.dominantColor
        movieImageView.image = presenter.movieAttachment
    }

}

// MARK:- MovieDetailsPresenterToViewProtocol
extension MovieDetailsViewController: MovieDetailsPresenterToView {
    
}

// MARK:- NavigationHeaderDelegate
extension MovieDetailsViewController: NavigationHeaderDelegate {
    func didClickBack() {
        presenter.didClickBack()
    }
}
