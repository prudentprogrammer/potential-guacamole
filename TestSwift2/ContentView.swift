import SwiftUI

struct ContentView: View {
    // Ball Parameters
    let ballRadius = 15.0
    @State var ballX = 0.0
    @State var ballY = 0.0
    @State var ballDx = 5.0
    @State var ballDy = -6.0
    let timer = Timer.publish(every: 0.030, on: .main, in: .common)
    let paddleHeight = 200.0
    let paddleOffset = 150.0
    let paddleWidth = 30.0
    @State var playerPaddleY: CGFloat = 0.0
    // Scoring
    @State var leftScore = 0
    @State var rightScore = 0
    @State private var rightPaddleY: CGFloat = 0
    @State private var rightDir: CGFloat = 1

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
                    .position(x: 30, y: halfH + playerPaddleY)
                    .gesture(
                            // Add the DragGesture here to update playerPaddleY
                            DragGesture()
                                .onChanged { value in
                                    // Add boundary checks later. For now, just allow movement.
                                    playerPaddleY = value.location.y - halfH
                                }
                        )
                //
                Rectangle()
                    .fill(.red)
                    .frame(width: paddleWidth, height: paddleHeight)
                    .position(x: W - 30, y: halfH + rightPaddleY)

                // Scoreboard
                HStack(spacing: 24) {
                    Text("\(leftScore)")
                    Text("—")
                    Text("\(rightScore)")
                }
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .position(x: halfW, y: 40)

            }.onReceive(timer.autoconnect()) { _ in
                
                let aiSpeed: CGFloat = 6
                rightPaddleY += rightDir * aiSpeed

                // keep it on-screen and bounce at edges
                let rightLimit = CGFloat(halfH - paddleHeight/2)
                if rightPaddleY > rightLimit { rightPaddleY = rightLimit; rightDir = -1 }
                if rightPaddleY < -rightLimit { rightPaddleY = -rightLimit; rightDir =  1 }
                
                
                // Move the ball
                ballX += ballDx
                ballY += ballDy

                // Check for top and bottom walls for collision
                let bottomCollision = (ballY + ballRadius >= halfH)
                let topCollision = (ballY - ballRadius <= -halfH)
                let leftPaddleCollision = (ballX - ballRadius <= -halfW + 30)
                let rightPaddleCollision = (ballX + ballRadius >= halfW - 30)
                let halfPaddleHeight = paddleHeight / 2
                let ballHitsLeftPaddleVertically =
                    abs(ballY - playerPaddleY) <= halfPaddleHeight
                let ballHitsRightPaddleVertically =
                    abs(ballY - rightPaddleY) <= halfPaddleHeight

                if bottomCollision || topCollision {
                    ballDy *= -1
                }

                if leftPaddleCollision && ballHitsLeftPaddleVertically {
                    ballDx *= -1
                }

                if rightPaddleCollision && ballHitsRightPaddleVertically {
                    ballDx *= -1
                }

                // Simple scoring if ball goes off screen
                if ballX < -halfW {  // Right player scores
                    ballX = 0
                    ballY = 0
                    ballDx = 5  // Serve toward right
                    rightScore += 1
                }
                if ballX > halfW {  // Left player scores
                    ballX = 0
                    ballY = 0
                    ballDx = -5  // Serve toward left
                    leftScore += 1
                }
                
                

            }
        }
    }
}

#Preview {
    ContentView()
}
