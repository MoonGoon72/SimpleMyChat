import SwiftUI

struct MessageView: View {
    @StateObject var manager: ChatDataManager = ChatDataManager.shared
    @State private var isDateShow = false
    var currentMessage: Message
    var body: some View {
        VStack {
            HStack(alignment: .bottom, spacing: 15) {
                let isCurrentUser = (currentMessage.user == manager.userId)
                if isCurrentUser {
                    Spacer()
                }
                else {
                    Text(String(currentMessage.user))
                        .font(.system(size: 9))
                        .frame(width: 20, height: 20)
                        .padding(10)
                        .foregroundColor(Color.black)
                        .background(isCurrentUser ? Color.blue : Color(uiColor: UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
                        .cornerRadius(10)
                }
                ContentMsgView(message: currentMessage.text, isCurrentUser: isCurrentUser)
                if !isCurrentUser {
                    Spacer()
                }
            }
            if isDateShow {
                HStack(spacing: 15) {
                    Spacer()
                    Text(currentMessage.timestamp.description)
                        .font(.system(size: 9))
                }
            }
        }
        .onTapGesture {
            isDateShow.toggle()
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        let msg = Message(id: UUID().uuidString, text: "Ther are a lot of premium iOS templates on iosapptemplates.com", received: false, timestamp: Date(), user: 4)
        MessageView(currentMessage: msg)
    }
}
