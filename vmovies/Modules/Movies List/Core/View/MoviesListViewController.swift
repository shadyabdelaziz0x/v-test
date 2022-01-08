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
    private struct constants {
        static let tableViewTopEdgeInset: CGFloat = -40
        static let tableViewCellHeight: CGFloat = 250
        static let tableViewSectionHeaderHeight: CGFloat = 70
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationHeader.bindData(title: "Movies List", delegate: nil)
        moviesTableView.contentInset = UIEdgeInsets(top: constants.tableViewTopEdgeInset, left: 0, bottom: 0, right: 0)
    }

}

// MARK:- MoviesListPresenterToView
extension MoviesListViewController: MoviesListPresenterToView {
    
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
        label.text = "Ad Placeholder"
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
        guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell, let movie = presenter.getMovie(for: indexPath.row) else { return UITableViewCell() }
        cell.bind(movie: movie)
        return cell
    }
}
