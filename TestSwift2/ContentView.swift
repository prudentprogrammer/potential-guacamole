import SwiftUI

struct ContentView: View {
    // Ball Parameters
    let ballRadius = 15.0
    let ballX = 0
    let ballY = 0
    let ballDx = 5
    let ballDy = 5
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.red)
                .frame(width: ballRadius * 2, height: ballRadius * 2)
        }
    }
}

#Preview {
    ContentView()
}
