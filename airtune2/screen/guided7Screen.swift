import SwiftUI
import MapKit

struct Guided7Screen: View {
    @State private var locationName: String = ""
    @State private var selectedLocation: String? = nil
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    let locations = ["家", "工作"]
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
                    }
                    .padding(.horizontal)
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    Text("現在的位置是您的什麼場域？")
                        .font(Font.custom("Poppins", size: 24).weight(.semibold))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    MapView(region: $region)
                        .frame(width: 340, height: 200)
                        .cornerRadius(19.32368)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        TextField("輸入位置名稱", text: $locationName)
                            .padding()
                            .background(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.4))
                            .cornerRadius(19.32368)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 19.32368)
                                    .stroke(locationName.isEmpty ? Color.gray.opacity(0.5) : Color.yellow, lineWidth: 2)
                            )
                            .frame(width: 340, height: 88)
                            .onTapGesture {
                                selectedLocation = nil
                            }
                        
                        ForEach(locations, id: \.self) { location in
                            Button(action: {
                                selectedLocation = location
                                locationName = ""
                            }) {
                                HStack {
                                    if selectedLocation == location {
                                        Image(systemName: "music.note")
                                            .foregroundColor(.yellow)
                                    }
                                    Text(location)
                                        .font(Font.custom("Inter", size: 16).weight(.semibold))
                                        .foregroundColor(Color(red: 0.98, green: 0.98, blue: 0.98))
                                }
                                .frame(width: 340, height: 88)
                                .background(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.4))
                                .cornerRadius(19.32368)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 19.32368)
                                        .stroke(selectedLocation == location ? Color.yellow : Color.clear, lineWidth: 2)
                                )
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 19.32368)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            .frame(width: 370, height: 100)
                            .background(Color.black.opacity(0.001))
                            .cornerRadius(19.32368, corners: [.topLeft, .topRight])
                            .overlay(
                                HStack {
                                    Spacer()
                                    NavigationLink(destination: finalViewScreen().navigationBarBackButtonHidden(true)) {
                                        Text("繼續")
                                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                                            .foregroundColor(.black)
                                            .frame(width: 287, height: 56)
                                            .background((selectedLocation != nil || !locationName.isEmpty) ? Color(red: 0.49, green: 0.49, blue: 0.49) : Color.gray)
                                            .cornerRadius(10)
                                    }
                                    .disabled(selectedLocation == nil && locationName.isEmpty)
                                    Spacer()
                                }
                            )
                            .padding(.horizontal, 30)
                    }
                    .padding(.bottom, 70)
                }
                .frame(width: 394, height: 854)
            }
        }
    }
}

struct Guided7Screen_Previews: PreviewProvider {
    static var previews: some View {
        Guided7Screen()
    }
}
