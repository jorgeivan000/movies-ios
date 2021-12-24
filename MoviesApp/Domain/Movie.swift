//
//  Movie.swift
//  MoviesApp
//
//  Created by jorgehc on 9/26/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import Foundation
import CoreData
import RealmSwift

enum MovieCategory: String {
    case latest
    case upcoming
    case popular
    case notDefined
}
struct MovieStruct {
    var id: Int?
    var posterPath: String?
    var isAdult: Bool?
    var overview: String?
    var releaseDate: Date?
    var originalTitle: String?
    var originalLanguage: String?
    var title: String?
    var backdropPath: String?
    var popularity: Double?
    var voteCount: Int?
    var video: Bool?
    var voteAverage: Double?
    var category: String? = MovieCategory.notDefined.rawValue
    
    init(id: Int?, posterPath: String?, isAdult: Bool?, overview: String?, releaseDate: Date?, originalTitle: String?, originalLanguage: String?, title: String?, backdropPath: String?, popularity: Double?, voteCount: Int?, video: Bool?, voteAverage: Double?) {
        self.id = id
        self.posterPath = posterPath
        self.isAdult = isAdult
        self.overview = overview
        self.releaseDate = releaseDate
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.backdropPath = backdropPath
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.voteAverage = voteAverage
    }
}

class Movie: Object, Codable {
    @objc dynamic var id: String?
    @objc dynamic var posterPath: String?
    @objc dynamic var isAdult: String?
    @objc dynamic var overview: String?
    @objc dynamic var releaseDate: String?
    @objc dynamic var originalTitle: String?
    @objc dynamic var originalLanguage: String?
    @objc dynamic var title: String?
    @objc dynamic var backdropPath: String?
    @objc dynamic var popularity: String?
    @objc dynamic var voteCount: String?
    @objc dynamic var video: String?
    @objc dynamic var voteAverage: String?
    @objc dynamic var category: String? = MovieCategory.notDefined.rawValue

    private enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case isAdult = "adult"
        case overview
        case releaseDate = "release_date"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
    
    convenience init(id: String?, posterPath: String?, isAdult: String?, overview: String?, releaseDate: String?, originalTitle: String?, originalLanguage: String?, title: String?, backdropPath: String?, popularity: String?, voteCount: String?, video: String?, voteAverage: String?, category: String?) {
        self.init()
        self.id = id
        self.posterPath = posterPath
        self.isAdult = isAdult
        self.overview = overview
        self.releaseDate = releaseDate
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.backdropPath = backdropPath
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.voteAverage = voteAverage
        self.category = category
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let idInt = try container.decodeIfPresent(Int.self, forKey: .id)
        self.id = String(idInt ?? 0)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        if let currentPosterPath = posterPath {
            posterPath = "https://image.tmdb.org/t/p/original" + currentPosterPath
        }
        let idIisAdultBool = try container.decode(Bool.self, forKey: .isAdult)
        self.isAdult = String(idIisAdultBool )
        overview = try container.decode(String.self, forKey: .overview)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        title =  try container.decodeIfPresent(String.self, forKey: .title)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        let popularityDouble = try container.decode(Double.self, forKey: .popularity)
        popularity = String(popularityDouble)
        let voteCountInt =  try container.decodeIfPresent(Int.self, forKey: .voteCount)
        self.voteCount = String(voteCountInt ?? 0)
        let videoBool = try container.decode(Bool.self, forKey: .video)
        video = String(videoBool)
        let voteAverageDouble = try container.decode(Double.self, forKey: .voteAverage)
        voteAverage = String(voteAverageDouble)
    }
    
    public func toStruct() -> MovieStruct {
        let date = DateHelper.date(from: self.releaseDate!) ?? Date()
        return MovieStruct(id: Int(self.id!), posterPath: self.posterPath, isAdult: NSString(string:self.isAdult!).boolValue , overview: self.overview, releaseDate: date, originalTitle: self.originalTitle, originalLanguage: self.originalLanguage, title: self.title, backdropPath: self.backdropPath, popularity: Double(self.popularity!), voteCount: Int(self.voteCount!), video: NSString(string:self.video!).boolValue, voteAverage: Double(self.voteAverage!))
    }
    
    func encode(to encoder: Encoder) throws {}
}
