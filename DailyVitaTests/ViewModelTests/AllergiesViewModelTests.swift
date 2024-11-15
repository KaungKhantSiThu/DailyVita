//
//  AllergiesViewModelTests.swift
//  DailyVitaTests
//
//  Created by Kaung Khant Si Thu on 14/11/2024.
//

import XCTest
@testable import DailyVita

final class AllergiesViewModelTests: XCTestCase {
    var viewModel: AllergiesViewModel!
    var mockUserChoices: UserChoices!

    override func setUp() {
        super.setUp()
        mockUserChoices = UserChoices()
        viewModel = AllergiesViewModel(userChoices: mockUserChoices)
    }

    func testLoadOptions() {
        viewModel.loadOptions()
        XCTAssertFalse(viewModel.options.isEmpty)
    }

    func testSelectAllergy() {
        let allergy = Allergy(id: 1, name: "Peanuts")
        viewModel.selectedAllergies.insert(allergy)
        XCTAssertTrue(viewModel.selectedAllergies.contains(allergy))
        XCTAssertEqual(mockUserChoices.selectedAllergies, ["Peanuts"])
    }
} 
