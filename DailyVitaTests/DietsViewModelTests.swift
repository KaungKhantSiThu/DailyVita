//
//  DietsViewModelTests.swift
//  DailyVitaTests
//
//  Created by Kaung Khant Si Thu on 14/11/2024.
//

import XCTest
@testable import DailyVita

final class DietsViewModelTests: XCTestCase {
    var viewModel: DietsViewModel!
    var mockUserChoices: UserChoices!

    override func setUp() {
        super.setUp()
        mockUserChoices = UserChoices()
        viewModel = DietsViewModel(userChoices: mockUserChoices)
    }

    func testLoadOptions() {
        viewModel.loadOptions()
        XCTAssertFalse(viewModel.options.isEmpty)
    }

    func testSelectDiet() {
        let diet = Diet(id: 1, name: "Vegan", toolTip: "A diet that excludes all animal products.")
        viewModel.selectedDiets.insert(diet)
        XCTAssertTrue(viewModel.selectedDiets.contains(diet))
        XCTAssertEqual(mockUserChoices.selectedDiets, ["Vegan"])
    }
} 
