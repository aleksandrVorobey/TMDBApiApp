//
//  Movie.swift
//  Movies
//
//  Created by Александр Воробей on 17.10.2021.
//

import Foundation

struct MoviesData: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let backdropPath: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let voteAverage: Double?
    
    func getReleaseDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"

        if let relDate = releaseDate {
            if let date = dateFormatterGet.date(from: relDate) {
                return dateFormatterPrint.string(from: date)
            }
        }
        
        return releaseDate!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
