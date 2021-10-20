//
//  API.swift
//  Movies
//
//  Created by Александр Воробей on 17.10.2021.
//

import Foundation

struct API {
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let apiKey = "?api_key=79d5894567be5b76ab7434fc12879584&language=en-US"
    static let imageURL = "https://image.tmdb.org/t/p/w500"
}

enum QueryMovie: String {
    case popular
    case upcoming
}
