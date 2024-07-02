import SwiftUI

struct GlowingView: View {
    var color: Color
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Circle()
                .frame(width: 241.04556, height: 241.04556)
                .foregroundColor(color)
                .glow(color: color)
                .opacity(0.35)
        }
    }
}

struct Glow: ViewModifier {
    var color: Color
    @State private var throb = false
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .foregroundColor(color)
                .blur(radius: throb ? 40 : 20)
                .animation(.easeOut(duration: 10).repeatForever(), value: throb)
                .onAppear {
                    throb.toggle()
                }
        }
    }
}

extension View {
    func glow(color: Color) -> some View {
        modifier(Glow(color: color))
    }
}

struct GlowingView_Previews: PreviewProvider {
    static var previews: some View {
        GlowingView(color: Color(red: 1, green: 0.9, blue: 0.24))
            .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
