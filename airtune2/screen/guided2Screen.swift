import SwiftUI

struct Guided2Screen: View {
    let situations = [
        "工作時", "休閒時", "運動時", "睡覺時", "開車時"
    ]
    
    @State private var selectedSituations = Set<String>()
    @State private var hasContinued = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                GlowingView(color: Color(red: 0.18, green: 0.65, blue: 0.92))
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
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("您通常在哪些情境下聽音樂？")
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
                            ForEach(situations, id: \.self) { situation in
                                Button(action: {
                                    if selectedSituations.contains(situation) {
                                        selectedSituations.remove(situation)
                                    } else {
                                        selectedSituations.insert(situation)
                                    }
                                }) {
                                    HStack {
                                        if selectedSituations.contains(situation) {
                                            Image(systemName: "music.note")
                                                .foregroundColor(.yellow)
                                        }
                                        Text(situation)
                                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                                            .foregroundColor(Color(red: 0.98, green: 0.98, blue: 0.98))
                                    }
                                    .frame(width: 340, height: 88)
                                    .background(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.4))
                                    .cornerRadius(19.32368)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 19.32368)
                                            .stroke(selectedSituations.contains(situation) ? Color.yellow : Color.clear, lineWidth: 2)
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
                                    NavigationLink(destination: Guided3Screen().navigationBarBackButtonHidden(true)) {
                                        Text("繼續")
                                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                                            .foregroundColor(.black)
                                            .frame(width: 287, height: 56)
                                            .background(selectedSituations.isEmpty ? Color.gray : Color(red: 0.49, green: 0.49, blue: 0.49))
                                            .cornerRadius(10)
                                    }
                                    .disabled(selectedSituations.isEmpty)
                                    .simultaneousGesture(TapGesture().onEnded {
                                        if !selectedSituations.isEmpty {
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

struct Guided2Screen_Previews: PreviewProvider {
    static var previews: some View {
        Guided2Screen()
    }
}
