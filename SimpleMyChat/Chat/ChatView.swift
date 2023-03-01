import SwiftUI

struct ChatView: View {
    @State private var typeingMessage: String = ""
    @StateObject private var manager = ChatDataManager.shared
    @FocusState private var msgIsFocus: Bool
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView {
                    VStack {
                        ForEach(manager.msgList) {
                            MessageView(currentMessage: $0).id($0.id)
                        }
                    }
                    .onChange(of: manager.lastMsgID) { newValue in
                        withAnimation {
                            scrollView.scrollTo(newValue, anchor: .bottom)
                        }
                    }
                }
                .padding()
                
                Spacer()
                HStack {
                    TextField("Message...", text: $typeingMessage, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Send") {
                        sendMessage()
                    }
                }
                .padding()
            }
            .onTapGesture {
                msgIsFocus = false
            }
        }
    }
    
    func sendMessage() {
        let msg = Message(id: UUID().uuidString, text: typeingMessage, received: false, timestamp: Date(), user: manager.userId)
        ChatDataManager.shared.sendMessage(msg)
        
        typeingMessage = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
