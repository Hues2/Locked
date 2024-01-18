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
            // Ticks
            ForEach(0..<100) { i in
                VStack(spacing: 10) {
                    if (i % 10 == 0) {
                        Text("\(i / 10)")
                            .font(.title)
                            .foregroundStyle(.white)
                            .rotationEffect(.degrees(-Double(i) * 3.6 - 180))
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
        .frame(maxWidth: maxWidth, maxHeight: maxWidth)
        .border(.red)
        .background(
            ZStack(alignment: .center) {
                Circle()
                    .fill(Color.firstCircle)
                    .shadow(color: .black.opacity(0.5), radius: 3, x: -5, y: 5)
                Group {
                    Circle()
                        .fill(Color.black)
                        .frame(width: maxWidth / 1.9)
                        .shadow(color: .black.opacity(0.5), radius: 3, x: -5, y: 5)
                    Circle()
                        .fill(Color.secondCircle)
                        .frame(width: maxWidth / 2)
                }
                Group {
                    Circle()
                        .fill(Color.black)
                        .frame(width: maxWidth / 2.9)
                        .shadow(color: .black.opacity(0.5), radius: 3, x: -5, y: 5)
                    Circle()
                        .fill(Color.secondCircle)
                        .frame(width: maxWidth / 3.1)
                }
            }
        )
    }
}
