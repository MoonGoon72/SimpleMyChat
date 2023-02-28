import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatDataManager: ObservableObject {
    static var shared = ChatDataManager()
    private init() {
        
    }
    
    @Published var msgList: [Message] = []
    @Published var lastMsgID: String = ""
    static let CHAT_USER_KEY = "UserNID"
    @Published var userId: Int = 1
    
    let db = Firestore.firestore()
    
    static let DB_MSG_KEY = "messages"
    
}
