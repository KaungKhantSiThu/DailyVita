import Foundation

enum JSONDecoderError: Error {
    case fileNotFound
    case decodingError
}

class JSONLoader {
    static func decode<T: Decodable>(_ type: T.Type, from filename: String) throws -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw JSONDecoderError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw JSONDecoderError.decodingError
        }
    }
} 