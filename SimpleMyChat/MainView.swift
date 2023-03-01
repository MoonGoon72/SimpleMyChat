import SwiftUI

struct MainView: View {
    @StateObject var manager: ChatDataManager = ChatDataManager.shared
    @State private var isUserSetting = false
    @State private var userNumber: String = ""
    
    func changeUserID() {
        manager.userId = Int(userNumber) ?? 1
        UserDefaults.standard.set(manager.userId, forKey: ChatDataManager.CHAT_USER_KEY)
    }
    var settingButton: some View {
        Button {
            isUserSetting = true
        } label: {
            Image(systemName: "gearshape")
        }
        .alert("사용자 번호 변경", isPresented: $isUserSetting, actions: {
            TextField("UserNumber", text: $userNumber)
                .keyboardType(.decimalPad)
            
            Button("Change") {changeUserID()}
            Button("Cancel", role: .cancel) {}
        }, message: {
            Text("자신이 사용할 사용자의 번호를 입력하세요(세 자리 이상), (현재: \(ChatDataManager.shared.userId)")
        })
    }
    
    var body: some View {
        ChatView()
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("I'm \(String(manager.userId))")
                }
                ToolbarItemGroup {
                    settingButton
                }
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainView()
        }
    }
}
