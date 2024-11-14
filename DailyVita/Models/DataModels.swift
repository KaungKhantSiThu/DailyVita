import Foundation



struct Diet: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let toolTip: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case toolTip = "tool_tip"
    }
}

struct Allergy: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

struct Question: Codable, Identifiable {
    let id: Int
    let text: String
    let answers: [String]
    let type: QuestionType
    
    enum QuestionType: Codable {
        case yesNo
        case range
    }
}

extension Question {
    static let data: [Question] = [
        Question(
            id: 1,
            text: "Is your daily exposure to sun limited?",
            answers: ["Yes", "No"],
            type: .yesNo
        ),
        Question(
            id: 2,
            text: "Do you currently smoke (tobacco or marijuana)?",
            answers: ["Yes", "No"],
            type: .yesNo
        ),
        Question(
            id: 3,
            text: "On average, how many alcoholic beverages do you have in a week?",
            answers: ["0 - 1", "2 - 5", "5 +"],
            type: .range
        )
    ]
}
