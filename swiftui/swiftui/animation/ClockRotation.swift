import SwiftUI

struct ClockRotation: View {
    @State private var rotationAngle: CGFloat = 0.0

    var body: some View {
        VStack(spacing: 50) {
            Button(action: {
                withAnimation(.linear(duration: 0.6)) {
                    rotationAngle = rotationAngle + 360
                }
            }, label: {
                Text("Rotate!")
            })
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
            )
            
            Image(systemName: "arrowshape.up")
                .font(.system(size: 50))
                .rotationEffect(Angle(degrees: rotationAngle), anchor: UnitPoint.bottom)

        }
    }
}

#Preview {
    ClockRotation()
}
