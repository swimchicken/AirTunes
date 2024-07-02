import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State var isAnimation: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                AnimatedImage(name: "enter.gif", isAnimating: $isAnimation)
                
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("創造理想氛圍")
                            .font(
                                Font.custom("Poppins", size: 24)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.white)
                            .frame(width: 306, alignment: .leading)
                            .padding(.top, 40)  // Adjust top padding if necessary
                        
                        Text("根據你的環境和情境，實時生成和調整背景音樂，為你提供個性化的音樂體驗。")
                            .font(Font.custom("Inter", size: 14))
                            .foregroundColor(.white.opacity(0.7))
                            .frame(width: 273, alignment: .leading)
                    }
                    .padding(.top, 80)  // Adjust top padding if necessary
                    
                    Spacer()
                    
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 350, height: 132)  // Adjusted height for frosted glass effect
                            .background(Color(red: 0.14, green: 0.14, blue: 0.14).opacity(0.2))
                            .cornerRadius(15)  // Adjusted corner radius
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)  // Adjusted corner radius
                                    .inset(by: 0.35)
                                    .stroke(Color(red: 0.4, green: 0.4, blue: 0.4), lineWidth: 0.69013)
                            )
                        
                        NavigationLink(destination: viewScreen().navigationBarBackButtonHidden(true)) {
                            Text("繼續")
                                .font(
                                    Font.custom("Inter", size: 16)
                                        .weight(.semibold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .frame(width: 307, height: 66)  // Increased width and height for white area
                                .background(.white)
                                .cornerRadius(10)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0.4, green: 0.4, blue: 0.4), lineWidth: 0.5)
                        )
                    }
                    .padding(.bottom, 20)  // Adjust bottom padding to move button down
                }
                .padding(.horizontal)
            }
            .frame(width: 394.03894, height: 854.25226)
            .background(.black)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}
