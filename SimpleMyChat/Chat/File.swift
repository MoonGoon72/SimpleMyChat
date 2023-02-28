import Foundation

struct Message: Hashable, Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
    var user: Int
}

struct User: Hashable, Codable {
    var name: String
    var avatar: String
    var isCurrentUser: Bool = false
    var user_id: Int
    
    static let FirstUser = User(name: "I am", avatar: "", isCurrentUser: true , user_id: 1)
    static let SecondUser = User(name: "Stev", avatar: "", isCurrentUser: false ,user_id: 2)
}
