//
//  ApiResponse.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 16.05.24.
//

import Foundation

struct ApiResponse: Codable{
    let ticker: String
    let results: [ResultsItem]
}

struct ResultsItem: Codable{
    let v: Int
    let vw: Double
    let o: Double
    let c: Double
    let h: Double
    let l: Double
    let t: Int64
    let n: Int
}

func getStock(symbols: String) async throws -> ApiResponse {
    let date = Calendar.current.date(byAdding: .day, value: -5, to: Date())
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    var formattedDate : String = formatter.string(from: date!) //"2024-05-10"
    let endpoint = "https://api.polygon.io/v2/aggs/ticker/\(symbols)/range/1/day/\(formattedDate)/\(formattedDate)?adjusted=true&sort=asc&limit=120&apiKey=H1KXq7xnepqsiR6kI8VXha_aBykXh2Sz"
    /*guard*/ let url = URL(string: endpoint)
    let(data, response) = try await URLSession.shared.data(from: url!)
    
    do {
        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(ApiResponse.self, from: data)
    }
}
