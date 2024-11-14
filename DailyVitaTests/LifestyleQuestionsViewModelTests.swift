//
//  LifestyleQuestionsViewModelTests.swift
//  DailyVitaTests
//
//  Created by Kaung Khant Si Thu on 14/11/2024.
//

import XCTest
@testable import DailyVita

final class LifestyleQuestionsViewModelTests: XCTestCase {
    var viewModel: LifestyleQuestionsViewModel!
    var mockUserChoices: UserChoices!

    override func setUp() {
        super.setUp()
        mockUserChoices = UserChoices()
        viewModel = LifestyleQuestionsViewModel(userChoices: mockUserChoices)
    }

    func testLoadOptions() {
        viewModel.loadOptions()
        XCTAssertEqual(viewModel.options.count, 3)
    }

    func testUpdateAnswer() {
        let question = Question.data[0]
        viewModel.updateAnswer(for: question, with: "Yes")
        XCTAssertTrue(viewModel.isDailyExposure ?? false)
    }

    func testIsComplete() {
        viewModel.isDailyExposure = true
        viewModel.isSmoke = true
        viewModel.alcohol = "2 - 5"
        XCTAssertTrue(viewModel.isComplete)
    }
} 
