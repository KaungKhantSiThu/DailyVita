//
//  UserChoicesTests.swift
//  DailyVitaTests
//
//  Created by Kaung Khant Si Thu on 14/11/2024.
//

import XCTest
@testable import DailyVita

final class UserChoicesTests: XCTestCase {
    var userChoices: UserChoices!

    override func setUp() {
        super.setUp()
        userChoices = UserChoices()
    }

    func testInitialValues() {
        XCTAssertTrue(userChoices.selectedConcerns.isEmpty)
        XCTAssertTrue(userChoices.selectedDiets.isEmpty)
        XCTAssertTrue(userChoices.selectedAllergies.isEmpty)
        XCTAssertFalse(userChoices.isDailyExposure)
        XCTAssertFalse(userChoices.isSmoke)
        XCTAssertEqual(userChoices.alcohol, "")
    }

    func testUpdateValues() {
        userChoices.selectedConcerns = ["Heart Health"]
        userChoices.isDailyExposure = true
        userChoices.alcohol = "2 - 5"

        XCTAssertEqual(userChoices.selectedConcerns, ["Heart Health"])
        XCTAssertTrue(userChoices.isDailyExposure)
        XCTAssertEqual(userChoices.alcohol, "2 - 5")
    }
} 
