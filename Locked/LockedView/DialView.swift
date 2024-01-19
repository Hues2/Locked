import SwiftUI

struct DialView: View {
    @ObservedObject private var viewModel : LockedViewModel
    @State var maxWidth : CGFloat
    let padding : CGFloat = Constants.padding
    
    // Spin movement
    @State private var angle: Double = .zero
    @State private var lastAngle: Double = .zero
    private let tickCount = Constants.numberOfTicks
    private let degreesPerTick = (360.0 / Double(Constants.numberOfTicks))
    private let spinSensitivity : Double = 2 // The lower the number, the more sensitivity
    private let snapAngles = (0..<Constants.numberOfTicks).map { Double($0 * (360 / Constants.numberOfTicks)) }
    private let hapticThreshold: Double = 5.0
    
    init(viewModel: LockedViewModel, width: CGFloat) {
        self.viewModel = viewModel
        self.maxWidth = (width - padding)
    }
    
    var body: some View {
        dialView
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        let startLocation = gesture.startLocation
                        let midScreen = UIScreen.main.bounds.width / 2
                        let isRightSideSwipe = startLocation.x > midScreen
                        
                        let verticalDrag = gesture.translation.height
                        let rotationalChange = verticalDrag / spinSensitivity
                        
                        withAnimation(.easeOut(duration: 1)) {
                            if isRightSideSwipe {
                                angle = lastAngle + rotationalChange // Spin right if swiping on the right
                            } else {
                                angle = lastAngle - rotationalChange // Spin left if swiping on the left
                            }
                        }
                        
                        let normalizedAngle = viewModel.normalize(angle: angle)
                        if snapAngles.contains(where: { abs(Double($0) - normalizedAngle) < hapticThreshold }) {
                            Utils.triggerHapticFeedback(style: .medium)
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.easeOut(duration: 1)) {
                            angle = snapToClosestAngle(to: angle)
                        }
                        lastAngle = angle
                        Utils.triggerHapticFeedback(style: .medium)
                    }
            )
    }
    
    private func snapToClosestAngle(to angle: Double) -> Double {
        let divisor = degreesPerTick
        let index = (angle / divisor).rounded()
        return index * divisor
    }
}

private extension DialView {
    var dialView : some View {
        ZStack {
            ticks
                .rotationEffect(Angle(degrees: angle))
        }
        .frame(maxWidth: maxWidth, maxHeight: maxWidth)
        .background(
            ZStack(alignment: .center) {
                baseCircle
                secondCircle
                thirdCircle
                dialButton
            }
        )
    }
    
    var ticks : some View {
        ForEach(Array(0..<Constants.numberOfTotalTicks), id: \.self) { i in
            VStack(spacing: 10) {
                if (i % Constants.numberOfTicks == 0) {
                    dialNumber(i / 10)
                        .rotationEffect(.degrees(-Double(i) * 3.6 - 180))
                }
                
                Rectangle()
                    .fill(i % Constants.numberOfTicks == 0 ? .white : .gray) // Bigger tick for every 10th mark
                    .frame(width: 3, height: i % 10 == 0 ? 20 : 10)
            }
            .offset(y: (i % Constants.numberOfTicks == 0) ? -25 : 0)
            .offset(y: (maxWidth - (padding * 2)) / 2)
            .rotationEffect(.degrees(Double(i) * 3.6 - 180))
        }
    }
    
    func dialNumber(_ number : Int) -> some View {
        Text("\(number)")
            .font(.title)
            .foregroundStyle(.white)
    }
    
    var baseCircle : some View {
        DialCircle(width: maxWidth - padding, colour: .firstCircle, shouldApplyShadow: true)
    }
    
    var secondCircle : some View {
        Group {
            DialCircle(width: maxWidth / 1.9, colour: .black, shouldApplyShadow: true)
            DialCircle(width: maxWidth / 2, colour: .secondCircle, shouldApplyShadow: false)
                .overlay(alignment: .top) {
                    redMarker
                }
        }
    }
    
    var redMarker : some View {
        Rectangle()
            .fill(.red)
            .frame(width: 3, height: (maxWidth / 2) / 2)
    }
    
    var thirdCircle : some View {
        Group {
            DialCircle(width: maxWidth / 2.9, colour: .black, shouldApplyShadow: true)
            DialCircle(width: maxWidth / 3.1, colour: .secondCircle, shouldApplyShadow: false)
        }
    }
    
    var dialButton : some View {
        Button {
            withAnimation(.spring(duration: 0.6, bounce: 0.4, blendDuration: 1)) {
                viewModel.setNumber(angle: angle)
            }
        } label: {
            ZStack {
                DialCircle(width: maxWidth / 3.9, colour: .black, shouldApplyShadow: true)
                DialCircle(width: maxWidth / 4.1, colour: .secondCircle, shouldApplyShadow: false)
            }
        }
        .buttonStyle(DialButtonModifier())
    }
}
