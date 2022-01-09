//
//  MovieDetailsProtocols.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/7/22.
//

import UIKit

protocol MovieDetailsViewToPresenter: AnyObject{
    var movieAuthor: String { get }
    var movieAttachment: UIImage { get }
    var dominantColor: UIColor? { get }
    func didClickBack()
}

protocol MovieDetailsPresenterToView: AnyObject{
    
}

protocol MovieDetailsPresenterToInteractor: AnyObject{
    
}

protocol MovieDetailsPresenterToRouter: AnyObject{
    func back()
}

protocol MovieDetailsInteractorToPresenter: AnyObject{

}
