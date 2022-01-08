//
//  MoviesManagerProtocol.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/8/22.
//

import Foundation

protocol MoviesManagerProtocol: AnyObject {
    //MARK:- Delete Function
    func delete() throws
    
    // MARK: Get functions
    func getMovies() throws -> [Movie]?

    // MARK: Insert functions
    func insertMovies(_ movies: [Movie]) throws
}
