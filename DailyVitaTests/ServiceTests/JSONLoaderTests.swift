//
//  JSONLoaderTests.swift
//  DailyVitaTests
//
//  Created by Kaung Khant Si Thu on 14/11/2024.
//

import XCTest
@testable import DailyVita

// Mock file loader for testing purposes
class MockFileLoader: FileLoader {
    
    func loadData(from filename: String, withExtension ext: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: filename, withExtension: ext) else {
            throw JSONDecoderError.fileNotFound
        }
        return try Data(contentsOf: url)
    }
}

final class JSONLoaderTests: XCTestCase {
    
    func testDecode_SuccessfulDecoding() throws {
        // Arrange
        let mockFileLoader = MockFileLoader()
        
        let jsonLoader = JSONLoader(fileLoader: mockFileLoader)
        
        // Act
        let result = try jsonLoader.decode(GenericResponse<Diet>.self, from: "ValidDietJSON")
        
        // Assert
        XCTAssertEqual(result.data[0].id, 1)
        XCTAssertEqual(result.data[0].name, "Vegan")
    }
    
    func testDecode_FileNotFound() {
        // Arrange
        let mockFileLoader = MockFileLoader()
        let jsonLoader = JSONLoader(fileLoader: mockFileLoader)
        
        // Act & Assert
        XCTAssertThrowsError(try jsonLoader.decode(GenericResponse<Diet>.self, from: "NonExistentFile")) { error in
            XCTAssertEqual(error as? JSONDecoderError, JSONDecoderError.fileNotFound)
        }
    }
    
    func testDecode_DecodingError() {
        // Arrange
        let mockFileLoader = MockFileLoader()
        let jsonLoader = JSONLoader(fileLoader: mockFileLoader)
        
        // Act & Assert
        XCTAssertThrowsError(try jsonLoader.decode(GenericResponse<Diet>.self, from: "InvalidDietJSON")) { error in
            XCTAssertEqual(error as? JSONDecoderError, JSONDecoderError.decodingError)
        }
    }
}

