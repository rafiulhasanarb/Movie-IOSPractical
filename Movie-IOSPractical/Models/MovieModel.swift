//
//  MovieModel.swift
//  Movie-IOSPractical
//
//  Created by rafiul hasan on 22/8/22.
//

import Foundation

// MARK: - MovieModel
struct MovieModel: Codable, Hashable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    var posterUrl: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
    }
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//MARK: Mockdata
struct MockData {
    static let sampleMovie = MovieModel(
        adult: false,
        backdropPath: "/w2PMyoyLU22YvrGK3smVM9fW1jj.jpg",
        genreIDS: [28, 12, 878],
        id: 299537,
        originalLanguage: "en",
        originalTitle: "Captain Marvel",
        overview: "The story follows Carol Danvers as she becomes one of the universe’s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races. Set in the 1990s, Captain Marvel is an all-new adventure from a previously unseen period in the history of the Marvel Cinematic Universe.",
        popularity: 99.618,
        posterPath: "/AtsgWhDnHTq68L0lLsUrCnM7TjG.jpg",
        releaseDate: "2019-03-06",
        title: "Captain Marvel",
        video: false,
        voteAverage: 6.9,
        voteCount: 13374)
}
