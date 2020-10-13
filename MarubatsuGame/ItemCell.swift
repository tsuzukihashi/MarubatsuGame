import SwiftUI

struct ItemCell: View {
    var isSelected: Bool
    var state: String
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Color.orange
            Color.white
                .opacity(isSelected ? 0 : 1)
            Text(state)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .opacity(isSelected ? 1 : 0)
        }
        .frame(width: size, height: size)
        .rotation3DEffect(
            .init(degrees: isSelected ? 180 : 0),
            axis: (x: 0.0, y: 1.0, z: 0.0),
            anchor: .center,
            anchorZ: 0.0,
            perspective: 1.0
        )
        .cornerRadius(16)
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(isSelected: false, state: "", size: 100)
            .preferredColorScheme(.dark)
    }
}
