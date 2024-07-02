//
//  LoginView.swift
//  airtune2
//
//  Created by swimchichen on 2024/6/30.
//

import SwiftUI
import AuthenticationServices

struct LoginView: UIViewRepresentable {
    @Binding var isSignedIn: Bool
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(context.coordinator, action: #selector(Coordinator.handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
        var parent: LoginView
        
        init(_ parent: LoginView) {
            self.parent = parent
        }
        
        @objc func handleAuthorizationAppleIDButtonPress() {
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                let userIdentifier = appleIDCredential.user
                let fullName = appleIDCredential.fullName
                let email = appleIDCredential.email
                
                // Save the user information or perform other operations
                print("User ID: \(userIdentifier)")
                print("Full Name: \(String(describing: fullName))")
                print("Email: \(String(describing: email))")
                
                // Set the isSignedIn state to true to trigger navigation
                DispatchQueue.main.async {
                    self.parent.isSignedIn = true
                }
            } else {
                print("Apple ID Credential is nil")
            }
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            // Handle error
            print("Authorization failed: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.parent.isSignedIn = false
            }
        }
        
        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return UIWindow()
            }
            return windowScene.windows.first { $0.isKeyWindow } ?? UIWindow()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isSignedIn: .constant(false))
            .frame(width: 280, height: 45)
            .padding()
    }
}
