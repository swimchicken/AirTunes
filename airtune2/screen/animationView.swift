import SwiftUI
import SDWebImageSwiftUI

struct AnimationView: View {
    @State private var nameManager = "name"
    @State private var showInitialText = true
    @State private var showSecondaryContent = false
    @State private var isAnimation: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                // Animated GIF
                AnimatedImage(name: "animat02.gif", isAnimating: $isAnimation)
                    .onAppear {
                        isAnimation = true
                    }
                
                // Welcome Text
                VStack {
                    if showInitialText {
                        Text("您好~ \(nameManager)")
                            .font(
                                Font.custom("Poppins", size: 24)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.white)
                            .frame(width: 306, alignment: .topLeading)
                            .transition(AnyTransition.opacity.combined(with: .move(edge: .top)))
                            .animation(.easeIn(duration: 1), value: showInitialText)
                            .padding(.top, 90)
                    }
                    
                    if showSecondaryContent {
                        VStack {
                            Text("請回答一些問題，\n幫助我們為您創造理想氛圍")
                                .font(
                                    Font.custom("Poppins", size: 24)
                                        .weight(.semibold)
                                )
                                .foregroundColor(.white)
                                .frame(width: 306, alignment: .topLeading)
                                .transition(AnyTransition.opacity.combined(with: .move(edge: .bottom)))
                                .animation(.easeIn(duration: 1), value: showSecondaryContent)
                            
                        }
                        .padding(.top, 90)
                    }
                    
                    Spacer()
                    
                    if showSecondaryContent {
                        VStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 19.32368)
                                .stroke(Color(red: 0.97, green: 0.98, blue: 0.98).opacity(0.2), lineWidth: 2)
                                .frame(width: 370, height: 100)
                                .background(Color.black.opacity(0.001))
                                .cornerRadius(19.32368, corners: [.topLeft, .topRight])
                                .overlay(
                                    HStack {
                                        Spacer()
                                        NavigationLink(destination: GuidedScreen().navigationBarBackButtonHidden(true)) {
                                            Text("繼續")
                                                .font(Font.custom("Inter", size: 16).weight(.semibold))
                                                .foregroundColor(.black)
                                                .frame(width: 287, height: 56)
                                                .background(Color(red: 0.49, green: 0.49, blue: 0.49))
                                                .cornerRadius(10)
                                        }
                                        Spacer()
                                    }
                                )
                                .padding(.horizontal, 30)
                        }
                        .padding(.bottom, 50)
                        .transition(AnyTransition.opacity.combined(with: .move(edge: .bottom)))
                        .animation(.easeIn(duration: 1), value: showSecondaryContent)
                    }
                }
                .onAppear {
                    // Hide the initial text after 1 second and show the secondary content
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            showInitialText = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Adjust this delay as needed
                            withAnimation {
                                showSecondaryContent = true
                            }
                        }
                    }
                }
            }
        }
    }
}


// Custom UIViewRepresentable for UIVisualEffectView to apply blur
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview {
    AnimationView()
}
