//
//  JSONLoader.swift
//  DailyVita
//
//  Created by Kaung Khant Si Thu on 13/11/2024.
//

import Foundation

// Error enum for JSON decoding errors
enum JSONDecoderError: Error {
    case fileNotFound
    case decodingError
}

// Protocol to handle file loading, allowing for dependency injection
protocol FileLoader {
    func loadData(from filename: String, withExtension ext: String) throws -> Data
}

// Default implementation of FileLoader using Bundle
class BundleFileLoader: FileLoader {
    func loadData(from filename: String, withExtension ext: String) throws -> Data {
        guard let url = Bundle.main.url(forResource: filename, withExtension: ext) else {
            throw JSONDecoderError.fileNotFound
        }
        return try Data(contentsOf: url)
    }
}

// JSONLoader class that uses dependency injection for file loading
class JSONLoader {
    private let fileLoader: FileLoader
    
    init(fileLoader: FileLoader = BundleFileLoader()) {
        self.fileLoader = fileLoader
    }
    
    func decode<T: Decodable>(_ type: T.Type, from filename: String) throws -> T {
        let data = try fileLoader.loadData(from: filename, withExtension: "json")
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw JSONDecoderError.decodingError
        }
    }
}

