import SwiftUI
import SwiftData

@main
struct airtune2App: App {
//    @StateObject private var modelContainerViewModel = ModelContainerViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginViewScreen()
//                .environmentObject(modelContainerViewModel)
        }
    }
}
