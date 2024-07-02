import SwiftUI
import FirebaseCore
import SDWebImageSwiftUI
import GoogleSignIn
import FirebaseAuth

struct loginViewScreen: View {
    @State var isAnimation: Bool = false
    @State private var navigateToLoginScreen: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                AnimatedImage(name: "start.gif", isAnimating: $isAnimation)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("隨著你的生活節奏變化")
                            .font(
                                Font.custom("Poppins", size: 24)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.white)
                            .frame(width: 306, alignment: .leading)
                            .padding(.top, 40)
                        
                        Text("播放適合的音樂，幫助你更好地安排日常生活。")
                            .font(Font.custom("Inter", size: 14))
                            .foregroundColor(.white.opacity(0.7))
                            .frame(width: 273, alignment: .leading)
                    }
                    .padding(.top, 80)
                    
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 350, height: 132)
                            .background(Color(red: 0.14, green: 0.14, blue: 0.14).opacity(0.2))
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .inset(by: 0.35)
                                    .stroke(Color(red: 0.4, green: 0.4, blue: 0.4), lineWidth: 0.69013)
                            )
                        
                        Button(action: {
                            navigateToLoginScreen = true
                        }) {
                            Text("開始")
                                .font(
                                    Font.custom("Inter", size: 16)
                                        .weight(.semibold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .frame(width: 307, height: 66)
                                .background(.white)
                                .cornerRadius(10)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0.4, green: 0.4, blue: 0.4), lineWidth: 0.5)
                        )
                    }
                    .padding(.bottom, 40)
                }
            }
            .frame(width: 394.03894, height: 854.25226)
            .background(.black)
            .navigationDestination(isPresented: $navigateToLoginScreen) {
                LoginViewScreen().navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct LoginViewScreen: View {
    @State private var isSignedIn = false
    @State private var isAnimation: Bool = false
    @State private var navigateToAnimationViewScreen: Bool = false
    @State private var userName: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                AnimatedImage(name: "animat01.gif", isAnimating: $isAnimation)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("用音樂")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 2)
                        Text("定義每個時刻。")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 30)

                    VStack(spacing: 20) {
                        LoginButton(isSignedIn: $isSignedIn, provider: "iCloud") {
                            navigateToAnimationViewScreen = true
                        }
                        .frame(width: 370, height: 50)
                        
                        LoginButton(isSignedIn: $isSignedIn, provider: "Google") {
                            signInWithGoogle()
                        }
                        .frame(width: 370, height: 50)
                    }
                    .padding(.bottom, 50)
                }
            }
            .onAppear {
                isAnimation = true
            }
            .navigationDestination(isPresented: $navigateToAnimationViewScreen) {
                AnimationView(userName: userName).navigationBarBackButtonHidden(true)
            }
        }
    }
    
    private func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // 創建 Google Sign In 配置對象
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // 開始登錄流程
        guard let presentingViewController = getRootViewController() else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            if let error = error {
                print("Error signing in with Google: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                print("Error fetching Google user")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase sign in with Google failed: \(error.localizedDescription)")
                    return
                }
                
                // 登錄成功
                DispatchQueue.main.async {
                    self.isSignedIn = true
                    self.userName = user.profile?.name ?? "Unknown User"
                    self.navigateToAnimationViewScreen = true
                }
            }
        }
    }
    
    private func getRootViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return nil }
        return windowScene.windows.first?.rootViewController
    }
}

struct LoginViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewScreen()
    }
}

struct LoginButton: View {
    @Binding var isSignedIn: Bool
    var provider: String
    var onSignIn: () -> Void
    
    var body: some View {
        Button(action: {
            onSignIn()
        }) {
            HStack {
                Image(systemName: provider == "iCloud" ? "icloud.fill" : "globe")
                    .foregroundColor(.white)
                Text("Sign in with \(provider)")
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
        }
    }
}
