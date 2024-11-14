//
//  JSONLoaderTests.swift
//  DailyVitaTests
//
//  Created by Kaung Khant Si Thu on 14/11/2024.
//

import XCTest
@testable import DailyVita

final class JSONLoaderTests: XCTestCase {
    func testDecodeValidJSON() {
        // Arrange
        let filename = "ValidDietJSON"
        // Act & Assert
        XCTAssertNoThrow(try JSONLoader.decode(GenericResponse<Diet>.self, from: filename))
    }

    func testDecodeInvalidJSON() {
        // Arrange
        let filename = "InvalidJSON"
        // Act & Assert
        XCTAssertThrowsError(try JSONLoader.decode(GenericResponse<Diet>.self, from: filename)) { error in
            XCTAssertEqual(error as? JSONDecoderError, JSONDecoderError.decodingError)
        }
    }

    func testFileNotFound() {
        // Arrange
        let filename = "NonExistentFile"
        // Act & Assert
        XCTAssertThrowsError(try JSONLoader.decode(GenericResponse<Diet>.self, from: filename)) { error in
            XCTAssertEqual(error as? JSONDecoderError, JSONDecoderError.fileNotFound)
        }
    }
} 
