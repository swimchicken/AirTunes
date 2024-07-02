import SwiftUI

struct mainScreen: View {
    @State private var selectedTab: Int = 0
    @State private var currentTime: String = "11:30 - 12:00"
    @State private var currentActivity: String = "meditation time"
    @State private var rotation1: Double = 0
    @State private var rotation2: Double = 0

    var body: some View {
        ZStack {
            BackgroundView()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        selectedTab = 0
                    }) {
                        Text("首頁")
                            .foregroundColor(selectedTab == 0 ? .black : .white)
                            .padding()
                            .background(selectedTab == 0 ? Color.white : Color.clear)
                            .cornerRadius(15)
                    }
                    
                    Button(action: {
                        selectedTab = 1
                    }) {
                        Text("生活排程")
                            .foregroundColor(selectedTab == 1 ? .black : .white)
                            .padding()
                            .background(selectedTab == 1 ? Color.white : Color.clear)
                            .cornerRadius(15)
                    }
                    
                    Spacer()
                    
                    Image("userProfile")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .padding()
                }
                .padding(.horizontal)
                .padding(.top, 50)
                
                Spacer()
                
                ZStack {
                    CircleView(rotationAngleX: 45, rotationAngleY: 45)
                        .frame(width: 250, height: 250)
                    CircleView(rotationAngleX: -45, rotationAngleY: 60)
                        .frame(width: 250, height: 250)
                }
                
                VStack(spacing: 10) {
                    Text(currentTime)
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    Text(currentActivity)
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(15)
                .padding(.horizontal)
                
                HStack {
                    Button(action: {
                        // Handle previous action
                    }) {
                        Image(systemName: "backward.fill")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Button(action: {
                        // Handle play/pause action
                    }) {
                        Image(systemName: "pause.fill")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Button(action: {
                        // Handle stop action
                    }) {
                        Image(systemName: "stop.fill")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Button(action: {
                        // Handle next action
                    }) {
                        Image(systemName: "forward.fill")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(15)
                .padding(.horizontal)
                
                List {
                    ScheduleRow(time: "11:30 - 12:00", activity: "dinner time")
                    ScheduleRow(time: "22:30 - 23:00", activity: "sleep time")
                    ScheduleRow(time: "8:00 - 10:00", activity: "morning time (明天)")
                }
                .listStyle(PlainListStyle())
                .frame(height: 200)
                
                Spacer()
            }
        }
    }
}

struct ScheduleRow: View {
    var time: String
    var activity: String
    
    var body: some View {
        HStack {
            Text(time)
                .foregroundColor(.white)
            
            Spacer()
            
            Text(activity)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black.opacity(0.7))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

struct BackgroundView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                
                ForEach(0..<100, id: \.self) { index in
                    Circle()
                        .fill(Color.orange)
                        .frame(width: CGFloat.random(in: 2...5), height: CGFloat.random(in: 2...5))
                        .position(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: 0...geometry.size.height)
                        )
                }
                
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    path.move(to: CGPoint(x: width / 2, y: height / 4))
                    path.addCurve(to: CGPoint(x: width / 4, y: height),
                                  control1: CGPoint(x: width / 3, y: height / 2),
                                  control2: CGPoint(x: width / 2, y: 3 * height / 4))
                    path.addCurve(to: CGPoint(x: 3 * width / 4, y: height / 4),
                                  control1: CGPoint(x: width / 2, y: height / 2),
                                  control2: CGPoint(x: 2 * width / 3, y: height / 4))
                }
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
            }
        }
    }
}

struct CircleView: View {
    @State private var rotate3D = false
    var rotationAngleX: Double
    var rotationAngleY: Double
    
    var body: some View {
        Circle()
            .stroke(Color.white.opacity(0.3), lineWidth: 2)
            .rotation3DEffect(
                .degrees(rotate3D ? 360 : 0),
                axis: (x: rotationAngleX, y: rotationAngleY, z: 0)
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 20).repeatForever(autoreverses: false)) {
                    rotate3D = true
                }
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        mainScreen()
    }
}
