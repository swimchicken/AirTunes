import SwiftUI
import AVFoundation
import CoreLocation

@available(iOS 17.0, *)
struct Guided6Screen: View {
    @State private var showAlert = false
    @State private var alertMessage = ""
    @StateObject private var locationManager = LocationManager()
    @StateObject private var micManager = MicManager()
    @State private var hasRequestedPermission = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
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
                        if micManager.isMicPermissionGranted && locationManager.isLocationPermissionGranted {
                            NavigationLink(destination: Guided7Screen().navigationBarBackButtonHidden(true)) {
                                Image(systemName: "chevron.forward")
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                            }
                        } else {
                            Image(systemName: "chevron.forward")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 50)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("最後了，")
                                .font(Font.custom("Poppins", size: 24).weight(.semibold))
                                .foregroundColor(.white)
                            Text("設定您的使用場所吧。")
                                .font(Font.custom("Poppins", size: 24).weight(.semibold))
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding([.top, .leading], 20)
                    
                    ZStack {
                        OwingView(color: micManager.isMicPermissionGranted ? Color(red: 0, green: 1, blue: 0.43) : Color(red: 0.74, green: 0.74, blue: 0.74))
                            .frame(width: 431, height: 431)
                            .offset(y: -100)
                        
                        OwingView(color: locationManager.isLocationPermissionGranted ? Color(red: 0, green: 1, blue: 0.43) : Color(red: 0.74, green: 0.74, blue: 0.74))
                            .frame(width: 431, height: 431)
                            .offset(y: 100)
                        
                        VStack(spacing: 189) {
                            Image(systemName: "mic.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(micManager.isMicPermissionGranted ? .green : .white)
                            
                            Image(systemName: "location.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(locationManager.isLocationPermissionGranted ? .green : .white)
                                .onTapGesture {
                                    locationManager.checkLocationAuthorization()
                                }
                        }
                    }
                    
                    VStack(spacing: 20) {
                        RoundedRectangle(cornerRadius: 19.32368)
                            .stroke(Color(red: 0.97, green: 0.98, blue: 0.98).opacity(0.2), lineWidth: 2)
                            .frame(width: 370, height: 250)
                            .background(Color.black.opacity(0.001))
                            .cornerRadius(19.32368, corners: [.topLeft, .topRight])
                            .overlay(
                                VStack {
                                    Spacer()
                                    Button(action: {
                                        Task {
                                            await requestMicrophonePermission()
                                        }
                                    }) {
                                        Text("開啟”麥克風”權限")
                                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                                            .foregroundColor(.black)
                                            .frame(width: 287, height: 56)
                                            .background(Color(red: 0.97, green: 0.98, blue: 0.98))
                                            .cornerRadius(10)
                                    }
                                    .disabled(micManager.isMicPermissionGranted)
                                    .opacity(micManager.isMicPermissionGranted ? 0.4 : 1)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        locationManager.checkLocationAuthorization()
                                    }) {
                                        Text("開啟”定位”權限")
                                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                                            .foregroundColor(.black)
                                            .frame(width: 287, height: 56)
                                            .background(Color(red: 0.97, green: 0.98, blue: 0.98))
                                            .cornerRadius(10)
                                    }
                                    .disabled(locationManager.isLocationPermissionGranted)
                                    .opacity(locationManager.isLocationPermissionGranted ? 0.4 : 1)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        showAlert = true
                                        alertMessage = "我們需要麥克風和位置權限來提供更好的個人化音樂體驗。"
                                    }) {
                                        Text(underlineText("了解為什麼我們需要您的授權？"))
                                            .font(Font.custom("Inter", size: 14).weight(.semibold))
                                            .foregroundColor(.white)
                                            .underline()
                                    }
                                    .padding(.bottom, 20)
                                }
                            )
                    }
                }
                .frame(width: 394, height: 854)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("麥克風權限"), message: Text(alertMessage), primaryButton: .default(Text("確認")) {
                        openAppSettings()
                    }, secondaryButton: .cancel(Text("取消")))
                }
                .onAppear {
                    if !hasRequestedPermission {
                        hasRequestedPermission = true
                        Task {
                            await requestMicrophonePermission()
                        }
                    }
                }
            }
        }
    }
    
    private func underlineText(_ text: String) -> AttributedString {
        var attributedString = AttributedString(text)
        attributedString.underlineStyle = .single
        return attributedString
    }
    
    private func requestMicrophonePermission() async {
        await micManager.requestMicPermission()
        if micManager.isMicPermissionGranted {
            showAlert = false
        } else {
            alertMessage = "請允許訪問麥克風以繼續，您可以在設置中的隱私與安全部分進行更改。"
            showAlert = true
        }
    }
    
    private func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct OwingView: View {
    var color: Color

    var body: some View {
        Circle()
            .fill(color)
            .blur(radius: 50)
            .opacity(0.3)
    }
}

@available(iOS 17.0, *)
struct Guided6Screen_Previews: PreviewProvider {
    static var previews: some View {
        Guided6Screen()
    }
}
