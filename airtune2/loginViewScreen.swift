//
//  LoginViewScreen.swift
//  airtune2
//
//  Created by swimchichen on 2024/6/30.
//

import SwiftUI

struct LoginViewScreen: View {
    @State private var isSignedIn = false
    
    var body: some View {
        Group {
            if isSignedIn {
                animationView()
            } else {
                ZStack {
                    // Background Gradient
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple, Color.orange]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .edgesIgnoringSafeArea(.all)
                    
                    // Text and Buttons
                    VStack {
//                        Spacer()
                        
                        // Top Text
                        VStack(alignment: .leading) {
                            Text("用音樂定義")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(.white)
                            Text("每個時刻。")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.bottom, 20)
                        }
//                        .padding(30)
                        .padding(.top, 60)
                        
                        Spacer()
                        
                        // iCloud Sign In Button
                        
                        VStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 19.32368)
                                .stroke(Color(red: 0.97, green: 0.98, blue: 0.98).opacity(0.2), lineWidth: 2)
                                .frame(width: 370, height: 100)
                                .background(Color.black.opacity(0.001))
                                .cornerRadius(19.32368, corners: [.topLeft, .topRight])
                                .padding(.bottom, 50)
                                .overlay(
                                    VStack(spacing: 20) {
                                        LoginView(isSignedIn: $isSignedIn)
                                            .frame(width: 280, height: 45)
                                            .padding(.bottom, 10)
                                    }
                                    .padding(.bottom, 50)
                                )
                                .padding(.horizontal, 30)
                            
                        }
                    }
                }
            }
        }
    }
}

struct LoginViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewScreen()
    }
}
