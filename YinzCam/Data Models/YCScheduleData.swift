//
//  YCScheduleData.swift
//  YinzCam
//
//  Created by Saumya Lahera on 8/31/21.
//

import Foundation

//MARK: - Main
struct YCScheduleData: Decodable {
    
    let gameList: GameList
    
    enum CodingKeys: String, CodingKey {
        case gameList = "GameList"
    }
}

// MARK: - GameList
struct GameList: Decodable {
    
    let team: Team
    let gameSections: [GameSection]
    
    enum CodingKeys: String, CodingKey {
        case team = "Team"
        case gameSections = "GameSection"
    }
}

//MARK: - Team
struct Team: Decodable {
    let triCode, fullName, name:String?
    let record:String?

    enum CodingKeys: String, CodingKey {
        case triCode = "TriCode"
        case fullName = "FullName"
        case name = "Name"
        case record = "Record"
    }
}

//MARK: - Game Section
struct GameSection: Decodable {
    let heading: String?
    let games: GameBridge

    enum CodingKeys: String, CodingKey {
        case heading = "Heading"
       case games = "Game"
    }
}

//MARK: - Game Bridge
enum GameBridge: Decodable {
    
    case gameElement(Game)
    case gameElementArray([Game])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Game].self) {
            self = .gameElementArray(x)
            return
        }
        if let x = try? container.decode(Game.self) {
            self = .gameElement(x)
            return
        }
        throw DecodingError.typeMismatch(GameBridge.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for GameUnion"))
    }
    
    var list: [Game] {
        switch self {
        case .gameElement(let Game):
            return [Game]
        case .gameElementArray(let Game):
            return Game
        }
    }
}

//MARK: - Game
struct Game: Decodable {
    let type:String?
    let homeScore:String?
    let awayScore:String?
    let gameState:String?
    let label:String?
    let date:Date?
    let opponent:Opponent?
    let week:String?
    
    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case homeScore = "HomeScore"
        case awayScore = "AwayScore"
        case gameState = "GameState"
        case label = "Label"
        case date = "Date"
        case opponent = "Opponent"
        case week = "Week"
        
    }
}

//MARK: - Game Date
struct Date: Decodable {
    let text:String?
    let time:String?
    let timeStamp:String?
    
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case time = "Time"
        case timeStamp = "Timestamp"
    }
}

//MARK: - Game Opponent
struct Opponent: Decodable {
    let triCode:String?
    let fullName:String?
    let name:String?
    let record:String?
    
    enum CodingKeys: String, CodingKey {
        case triCode = "TriCode"
        case fullName = "FullName"
        case name = "Name"
        case record = "Record"
    }
}

//MARK: - Data Holder Class
/**This class holds all the data required for the schedule games tableview by forming the exact JSON structure*/
class DataHolder {
    var sections = [GameSection]()
    var team:Team!
}

