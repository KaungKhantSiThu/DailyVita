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
