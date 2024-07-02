//
//  finalView.swift
//  airtune2
//
//  Created by swimchichen on 2024/7/2.
//

import SwiftUI
import SDWebImageSwiftUI

struct finalViewScreen: View {
    @State private var isAnimation: Bool = false
    @State private var showText: Bool = false
    @State private var navigateToMainScreen: Bool = false
    @State private var fadeOut: Bool = false

    var body: some View {
        ZStack {
            if !fadeOut {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                AnimatedImage(name: "final.gif", isAnimating: $isAnimation)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                if showText {
                    VStack {
                        Spacer()
                        Text("AirTunes")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(10)
                            .opacity(showText ? 1 : 0)
                            .padding(.bottom, 250)
                    }
                    .transition(.opacity)
                }
            } else {
                mainScreen()
                    .transition(.opacity)
            }
        }
        .onAppear {
            self.isAnimation = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                withAnimation(.easeIn(duration: 2)) {
                    self.showText = true
                }
            }
        }
        .onTapGesture {
            withAnimation(.easeOut(duration: 2)) {
                self.fadeOut = true
            }
        }
    }
}



#Preview {
    finalViewScreen()
}
