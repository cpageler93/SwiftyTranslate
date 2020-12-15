//
//  SwiftyTranslate.swift
//  SwiftyTranslate
//
//  Created by Christoph Pageler on 15.12.20.
//


import Foundation


public struct SwiftyTranslate {

    public enum Error: Swift.Error {

        case invalidURL
        case noData
        case invalidData

    }

    public struct Translation {

        public var origin: String
        public var translated: String

    }

    public static func translate(text: String, from: String, to: String,
                                 completion: @escaping (Result<Translation, Error>) -> Void) {
        var urlComponents = URLComponents(string: "https://translate.googleapis.com/translate_a/single")!
        urlComponents.queryItems = [
            URLQueryItem(name: "client", value: "gtx"),
            URLQueryItem(name: "sl", value: from),
            URLQueryItem(name: "tl", value: to),
            URLQueryItem(name: "dt", value: "t"),
            URLQueryItem(name: "q", value: text),
        ]
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: URLRequest(url: url))
        { (data, response, error) in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            guard let object = try? JSONSerialization.jsonObject(with: data, options: []) else {
                completion(.failure(.invalidData))
                return
            }

            // extract arrays
            guard let firstArray = object as? [Any],
                  let secondArray = firstArray.first as? [Any],
                  let thirdArray = secondArray.first as? [Any]
            else {
                completion(.failure(.invalidData))
                return
            }

            // extract result
            let result = thirdArray[0..<2]
            guard let translated = result.first as? String,
                  let origin = result.last as? String
            else {
                completion(.failure(.invalidData))
                return
            }

            completion(.success(Translation(origin: origin, translated: translated)))
        }.resume()
    }

}
