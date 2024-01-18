import SwiftUI

struct DialView: View {
    let padding : CGFloat = Constants.padding
    @State var maxWidth : CGFloat
    
    init(width: CGFloat) {
        self.maxWidth = width - padding
    }
    
    var body: some View {
        dialView
            .padding(padding)
    }
}

private extension DialView {
    var dialView : some View {
        ZStack {
            ticks
        }
        .frame(maxWidth: maxWidth, maxHeight: maxWidth)
        .background(
            ZStack(alignment: .center) {
                baseCircle
                secondCircle
                thirdCircle
            }
        )
    }
    
    var ticks : some View {
        ForEach(0..<100) { i in
            VStack(spacing: 10) {
                if (i % 10 == 0) {
                    dialNumber(i / 10)
                }
                
                Rectangle()
                    .fill(i % 10 == 0 ? .white : .gray) // Bigger tick for every 10th mark
                    .frame(width: 2, height: i % 10 == 0 ? 20 : 10)
            }
            .offset(y: (i % 10 == 0) ? -25 : 0)
            .offset(y: (maxWidth - (padding * 2)) / 2)
            .rotationEffect(.degrees(Double(i) * 3.6 - 180))
        }
    }
    
    func dialNumber(_ number : Int) -> some View {
        Text("\(number)")
            .font(.title)
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-Double(number) * 3.6 - 180))
    }
    
    var baseCircle : some View {
        DialCircle(width: maxWidth - padding, colour: .firstCircle, shouldApplyShadow: true)
    }
    
    var secondCircle : some View {
        Group {
            DialCircle(width: maxWidth / 1.9, colour: .black, shouldApplyShadow: true)
            DialCircle(width: maxWidth / 2, colour: .secondCircle, shouldApplyShadow: false)
                .overlay(alignment: .top) {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 3, height: (maxWidth / 2) / 2)
                }
        }
    }
    
    var thirdCircle : some View {
        Group {
            DialCircle(width: maxWidth / 2.9, colour: .black, shouldApplyShadow: true)
            DialCircle(width: maxWidth / 3.1, colour: .secondCircle, shouldApplyShadow: false)
        }
    }
}
