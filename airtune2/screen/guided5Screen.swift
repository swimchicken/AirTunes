import SwiftUI

struct Guided5Screen: View {
    @State private var selectedGender: String? = nil
    @State private var otherGender: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    let genders = [
        "男性", "女性", "其他 (自行輸入)", "不願透露"
    ]

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                GlowingView(color: Color(red: 1, green: 0.99, blue: 0.98))
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
                    .padding(.top,50)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("您的性別是？")
                            .font(Font.custom("Poppins", size: 24).weight(.semibold))
                            .foregroundColor(.white)
                        
                        Text("您的回答可幫助我們更好地為您準備個人化音樂體驗")
                            .font(Font.custom("Inter", size: 14))
                            .foregroundColor(.white.opacity(0.7))
                            .frame(width: 325, alignment: .leading)
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        ForEach(genders, id: \.self) { gender in
                            if gender == "其他 (自行輸入)" {
                                HStack {
                                    TextField("其他 (自行輸入)", text: $otherGender)
                                        .padding()
                                        .background(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.4))
                                        .foregroundColor(.white)
                                        .cornerRadius(19.32368)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 19.32368)
                                                .stroke(!otherGender.isEmpty ? Color.yellow : Color.gray.opacity(0.5), lineWidth: 2)
                                        )
                                        .frame(width: 340, height: 88)
                                }
                                .background(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.4))
                                .onTapGesture {
                                    selectedGender = "其他 (自行輸入)"
                                }
                            }
                            else {
                                Button(action: {
                                    selectedGender = gender
                                    otherGender = ""
                                }) {
                                    HStack {
                                        if selectedGender == gender {
                                            Image(systemName: "music.note")
                                                .foregroundColor(.yellow)
                                        }
                                        Text(gender)
                                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                                            .foregroundColor(Color(red: 0.98, green: 0.98, blue: 0.98))
                                    }
                                    .frame(width: 340, height: 88)
                                    .background(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.4))
                                    .cornerRadius(19.32368)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 19.32368)
                                            .stroke(selectedGender == gender ? Color.yellow : Color.clear, lineWidth: 2)
                                    )
                                }
                            }
                        }
                    }
                    
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
                                    NavigationLink(destination: Guided6Screen().navigationBarBackButtonHidden(true)) {
                                        Text("繼續")
                                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                                            .foregroundColor(.black)
                                            .frame(width: 287, height: 56)
                                            .background((selectedGender != nil || !otherGender.isEmpty) ? Color(red: 0.49, green: 0.49, blue: 0.49) : Color.gray)
                                            .cornerRadius(10)
                                    }
                                    .disabled(selectedGender == nil && otherGender.isEmpty)
                                    .simultaneousGesture(TapGesture().onEnded {
                                        if selectedGender != nil || !otherGender.isEmpty {
                                            // Action to be taken when "繼續" is pressed
                                        }
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
            .padding(.top,50)
        }
    }
}

struct Guided5Screen_Previews: PreviewProvider {
    static var previews: some View {
        Guided5Screen()
    }
}
