import SwiftUI


struct GuidedScreen: View {
    let genres = [
        "另類和龐克", "氛圍", "兒童", "電影配樂", "古典",
        "鄉村和民謠", "舞曲和電音", "嘻哈和饒舌", "節慶",
        "爵士和藍調", "流行", "節奏藍調和靈魂樂", "雷鬼", "搖滾"
    ]
    
    @State private var selectedGenres = Set<String>()
    @State private var hasContinued = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                GlowingView(color: Color(red: 1, green: 0.9, blue: 0.24))
                    .frame(width: 241.04556, height: 241.04556)
                    .offset(y: -300)
                
                VStack {
                    HStack {
//                        Image(systemName: "chevron.backward")
//                            .frame(width: 20, height: 20)
//                            .foregroundColor(.white)
//                        Spacer()
//                        Image(systemName: "chevron.forward")
//                            .frame(width: 20, height: 20)
//                            .foregroundColor(hasContinued ? .white : .gray)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("您平時喜歡的音樂風格是？")
                            .font(Font.custom("Poppins", size: 24).weight(.semibold))
                            .foregroundColor(.white)
                        
                        Text("您的回答可幫助我們更好地為您準備個人化音樂體驗 \n*可多選")
                            .font(Font.custom("Inter", size: 14))
                            .foregroundColor(.white.opacity(0.7))
                            .frame(width: 325, alignment: .leading)
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(genres, id: \.self) { genre in
                                Button(action: {
                                    if selectedGenres.contains(genre) {
                                        selectedGenres.remove(genre)
                                    } else {
                                        selectedGenres.insert(genre)
                                    }
                                }) {
                                    HStack {
                                        if selectedGenres.contains(genre) {
                                            Image(systemName: "music.note")
                                                .foregroundColor(.yellow)
                                        }
                                        Text(genre)
                                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                                            .foregroundColor(Color(red: 0.98, green: 0.98, blue: 0.98))
                                    }
                                    .frame(width: 340, height: 88)
                                    .background(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.4))
                                    .cornerRadius(19.32368)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 19.32368)
                                            .stroke(selectedGenres.contains(genre) ? Color.yellow : Color.clear, lineWidth: 2)
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
                                    NavigationLink(destination: Guided2Screen().navigationBarBackButtonHidden(true)) {
                                        Text("繼續")
                                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                                            .foregroundColor(.black)
                                            .frame(width: 287, height: 56)
                                            .background(selectedGenres.isEmpty ? Color.gray : Color(red: 0.49, green: 0.49, blue: 0.49))
                                            .cornerRadius(10)
                                    }
                                    .disabled(selectedGenres.isEmpty)
                                    .simultaneousGesture(TapGesture().onEnded {
                                        if !selectedGenres.isEmpty {
                                            hasContinued = true
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
            .padding(.top, 50)
        }
    }
}



struct GuidedScreen_Previews: PreviewProvider {
    static var previews: some View {
        GuidedScreen()
    }
}
