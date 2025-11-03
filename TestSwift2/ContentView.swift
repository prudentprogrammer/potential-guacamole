import SwiftUI

struct ContentView: View {
    // Ball Parameters
    let ballRadius = 15.0
    @State var ballX = 0.0
    @State var ballY = 0.0
    @State var ballDx = 5.0
    @State var ballDy = 5.0
    let timer = Timer.publish(every: 0.030, on: .main, in: .common)
    let paddleHeight = 150.0
    let paddleOffset = 150.0
    @State var playerPaddleY: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.red)
                .frame(width: ballRadius * 2, height: ballRadius * 2)
                .offset(x: ballX, y: ballY)
            
            Rectangle()
                .fill(.black)
                .frame(width: 30, height: paddleHeight)
                .offset(x: -paddleOffset, y: playerPaddleY)
            
            Rectangle()
                .fill(.black)
                .frame(width: 30, height: paddleHeight)
                .offset(x: paddleOffset)
            
        }.onReceive(timer.autoconnect()) {_ in
            ballX += ballDx
            ballY += ballDy
        }
    }
}

#Preview {
    ContentView()
}
