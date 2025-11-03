import SwiftUI

struct ContentView: View {
    // Ball Parameters
    let ballRadius = 15.0
    @State var ballX = 0.0
    @State var ballY = 0.0
    @State var ballDx = 0.0
    @State var ballDy = 5.0
    let timer = Timer.publish(every: 0.030, on: .main, in: .common)
    let paddleHeight = 200.0
    let paddleOffset = 150.0
    let paddleWidth = 30.0
    @State var playerPaddleY: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geo in
            let (W, H) = (geo.size.width, geo.size.height)
            let halfW = W / 2
            let halfH = H / 2
            ZStack {
                Circle()
                    .fill(Color.red)
                    .frame(width: ballRadius * 2, height: ballRadius * 2)
                    .position(x: ballX + halfW, y: ballY + halfH)
                
                Rectangle()
                    .fill(.yellow)
                    .frame(width: paddleWidth, height: paddleHeight)
                    .position(x: 30, y: halfH)
//
                Rectangle()
                    .fill(.red)
                    .frame(width: paddleWidth, height: paddleHeight)
                    .position(x: W - 30, y: halfH)
                
            }.onReceive(timer.autoconnect()) {_ in
                // Move the ball
                ballX += ballDx
                ballY += ballDy
                
                // Check for top and bottom walls for collision
//                let screenHeight = geometry.size.height
//                let halfHeight = screenHeight / 2
//                let bottomCollision = (ballY + ballRadius >= halfHeight)
//                let topCollision    = (ballY - ballRadius <= -halfHeight)
//                
//                if bottomCollision || topCollision {
//                    ballDy *= -1
//                }
            }
        }
    }
}

#Preview {
    ContentView()
}
