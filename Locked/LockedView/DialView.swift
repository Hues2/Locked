import SwiftUI

struct DialView: View {
    let width = UIScreen.main.bounds.width
    
    var body: some View {
        dialView
            .padding()
            .border(.red)
    }
}

private extension DialView {
    var dialView : some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.3))
            
            // Ticks
            ForEach(0..<100) { i in
                VStack {
                    Text("1")
                    
                    Rectangle()
                        .fill(i % 10 == 0 ? Color.primary : Color.gray) // Bigger tick for every 10th mark
                        .frame(width: 2, height: i % 10 == 0 ? 20 : 10)
//                        .offset(y: (width - 110) / 2)
//                        .rotationEffect(.degrees(Double(i) * 3.6))
                }
                .offset(y: (width - 110) / 2)
                .rotationEffect(.degrees(Double(i) * 3.6))
            }
            
            // Numbers
//            ForEach(0..<10) { number in
//                Text("\(number)")
//                    .font(.title)
////                    .rotationEffect(.degrees(Double(-number) * 36))
//                    .offset(y: -180)
//                    .rotationEffect(.degrees(Double(number) * 36))
//                    .offset
//            }
        }
        .frame(width: width - 85, height: width - 85)
    }
}
