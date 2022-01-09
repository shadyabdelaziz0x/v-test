//
//  MoviesListViewController.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import UIKit

class MoviesListViewController: UIViewController {

    var presenter: MoviesListViewToPresenter!
    @IBOutlet private weak var moviesTableView: UITableView!
    @IBOutlet private weak var navigationHeader: NavigationHeader!
    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var emptyLabel: UILabel!
    private struct constants {
        static let tableViewTopEdgeInset: CGFloat = -40
        static let tableViewCellHeight: CGFloat = 250
        static let tableViewSectionHeaderHeight: CGFloat = 70
        static let spinnerFrameHeight: CGFloat = 44
    }
    let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationHeader.bindData(title: R.string.strings.moviesListTitle(), delegate: nil)
        moviesTableView.contentInset = UIEdgeInsets(top: constants.tableViewTopEdgeInset, left: 0, bottom: 0, right: 0)
        spinner.hidesWhenStopped = true
        spinner.frame = CGRect(x: 0, y: 0, width: moviesTableView.bounds.width, height: constants.spinnerFrameHeight)
        moviesTableView.tableFooterView = spinner
        emptyView.isHidden = presenter.moviesSectionsCount > 0
        emptyLabel.text = R.string.strings.emptyTitle()
    }

}

// MARK:- MoviesListPresenterToView
extension MoviesListViewController: MoviesListPresenterToView {
    func reloadTable() {
        moviesTableView.reloadData()
        setSpinnerVisibility(hidden: true)
    }
    
    func setError(error: Error) {
        //TODO:- handle error using certain design
        setSpinnerVisibility(hidden: true)
    }
    
    private func setSpinnerVisibility(hidden: Bool) {
        if hidden {
            spinner.stopAnimating()
        } else {
            spinner.startAnimating()
        }
        moviesTableView.tableFooterView?.isHidden = hidden
    }
}

// MARK:- UITableViewDelegate
extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = moviesTableView.cellForRow(at: indexPath) as? MovieTableViewCell, let image = cell.getImage()
        else {
            return
        }
        presenter.navigateToMovieDetails(for: indexPath.row, with: image)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return constants.tableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        let isLastCell: Bool = indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex
        if isLastCell {
            presenter.fetchMoreMovies()
            setSpinnerVisibility(hidden: false)
        }
    }
}

// MARK:- UITableViewDataSource
extension MoviesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getMoviesRowsPerSection(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.moviesSectionsCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section > 0 else {
            return nil
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: constants.tableViewSectionHeaderHeight))
        view.backgroundColor = R.color.redE60000()
        let label = UILabel(frame: view.bounds)
        label.text = R.string.strings.adPlaceHolderText()
        view.addSubview(label)
        label.center = view.center
        label.textColor = UIColor.white
        label.textAlignment = .center
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section > 0 else {
            return 0
        }
        return constants.tableViewSectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell, let movie = presenter.getMovie(section: indexPath.section, index: indexPath.row) else { return UITableViewCell() }
        cell.bind(movie: movie)
        return cell
    }
}
