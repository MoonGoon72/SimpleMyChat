import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatDataManager: ObservableObject {
    static var shared = ChatDataManager()
    private init() {
        getMessages()
        getUserId()
    }
    
    @Published var msgList: [Message] = []
    @Published var lastMsgID: String = ""
    static let CHAT_USER_KEY = "UserNID"
    @Published var userId: Int = 1
    
    let db = Firestore.firestore()
    
    static let DB_MSG_KEY = "messages"
    
    func getMessages() {
        db.collection(ChatDataManager.DB_MSG_KEY).addSnapshotListener { querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents \(String(describing: error))")
                return
            }
            
            self.msgList = documents.compactMap({ document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding document into Message:\(error)")
                    return nil
                }
            })
            self.msgList.sort { $0.timestamp < $1.timestamp }
            if let last = self.msgList.last {
                self.lastMsgID = last.id
            }
        }
    }
    
    func getUserId() {
        let key = UserDefaults.standard.integer(forKey: ChatDataManager.CHAT_USER_KEY)
        userId = key
    }
    
    func sendMessage(_ chatMsg: Message) {
        msgList.append(chatMsg)
        lastMsgID = chatMsg.id
        
        do {
            try db.collection(ChatDataManager.CHAT_USER_KEY).document().setData(from: chatMsg)
        } catch {
            print("Error adding Message to FireStore: \(error)")
        }
    }
    
    func getList() -> [Message] {
        return msgList
    }
    
}
