import SwiftUI

struct Guided4Screen: View {
    @State private var age: Double = 18
    @State private var hasContinued = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                GlowingView(color: Color(red: 0.83, green: 0.21, blue: 0.29))
                    .frame(width: 241.04556, height: 241.04556)
                    .offset(y: -300)
                
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.backward")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("您的年齡是？")
                            .font(Font.custom("Poppins", size: 24).weight(.semibold))
                            .foregroundColor(.white)
                        
                        Text("您的回答可幫助我們更好地為您準備個人化音樂體驗")
                            .font(Font.custom("Inter", size: 14))
                            .foregroundColor(.white.opacity(0.7))
                            .frame(width: 325, alignment: .leading)
                    }
                    .padding(.top, 60)
                    
                    VStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 340, height: 131)
                            .background(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.4))
                            .cornerRadius(19.32368)
                            .overlay(
                                VStack {
                                    Text("\(Int(age))")
                                        .font(Font.custom("Inter", size: 36).weight(.medium))
                                        .foregroundColor(Color(red: 0.98, green: 0.98, blue: 0.98))
                                    
                                    Slider(value: $age, in: 0...100, step: 1)
                                        .accentColor(.white)
                                        .padding(.horizontal, 20)
                                }
                            )
                    }
                    .padding(.top, 60)
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 19.32368)
                            .stroke(Color(red: 0.97, green: 0.98, blue: 0.98).opacity(0.2), lineWidth: 2)
                            .frame(width: 370, height: 100)
                            .background(Color.black.opacity(0.001))
                            .cornerRadius(19.32368, corners: [.topLeft, .topRight])
                            .overlay(
                                HStack {
                                    Spacer()
                                    NavigationLink(destination: Guided5Screen().navigationBarBackButtonHidden(true)) {
                                        Text("繼續")
                                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                                            .foregroundColor(.black)
                                            .frame(width: 287, height: 56)
                                            .background(Color(red: 0.49, green: 0.49, blue: 0.49))
                                            .cornerRadius(10)
                                    }
                                    .simultaneousGesture(TapGesture().onEnded {
                                        hasContinued = true
                                    })
                                    Spacer()
                                }
                            )
                            .padding(.horizontal, 30)
                    }
                    .padding(.bottom, 50)
                }
                .frame(width: 394, height: 854)
            }
            .padding(.top, 50)
        }
    }
}

struct Guided4Screen_Previews: PreviewProvider {
    static var previews: some View {
        Guided4Screen()
    }
}
