//
//  OnboardingStepTests.swift
//  DailyVitaTests
//
//  Created by Kaung Khant Si Thu on 14/11/2024.
//

import XCTest
@testable import DailyVita

final class OnboardingStepTests: XCTestCase {
    func testNextStep() {
        XCTAssertEqual(OnboardingStep.welcome.next(), .healthConcerns)
        XCTAssertNil(OnboardingStep.lifestyleQuestions.next())
    }

    func testPreviousStep() {
        XCTAssertEqual(OnboardingStep.lifestyleQuestions.previous(), .allergies)
        XCTAssertNil(OnboardingStep.welcome.previous())
    }

    func testTitles() {
        XCTAssertEqual(OnboardingStep.welcome.title, "Welcome to DailyVita")
        XCTAssertEqual(OnboardingStep.healthConcerns.title, "Select your top health concerns")
    }
} 
