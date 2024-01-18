import SwiftUI

struct DialView: View {
    let width : CGFloat
    
    var body: some View {
        dialView
            .padding()
            .border(.red)
    }
}

private extension DialView {
    var dialView : some View {
        Circle()
            .fill(Color.gray.opacity(0.3))
            .overlay {
                // Ticks
                ForEach(0..<100) { i in
                    VStack(spacing: 10) {
                        if (i % 10 == 0) {
                            Text("\(i / 10)")
                                .font(.title)
                                .rotationEffect(.degrees(-Double(i) * 3.6 - 180))
                        }
                        
                        Rectangle()
                            .fill(i % 10 == 0 ? Color.primary : Color.gray) // Bigger tick for every 10th mark
                            .frame(width: 2, height: i % 10 == 0 ? 20 : 10)
                    }
                    .offset(y: (i % 10 == 0) ? -25 : 0)
                    .offset(y: (width - 70) / 2)
                    .rotationEffect(.degrees(Double(i) * 3.6 - 180))
                }
            }
            .overlay {
                // Knob of the lock
                Circle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 60, height: 60)
            }
    }
}
