import SwiftUI

struct HomeView: View {
    @State var moves: [String] = Array(repeating: "", count: 9)
    @State var isPlaying = false
    var body: some View {
        VStack {
            GeometryReader { geometry in
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible() ,spacing: 4), count: 3),
                    spacing: 16
                ) {
                    ForEach(0..<9, id: \.self) { index in
                        ZStack {
                            Color.blue
                            
                            Color.white
                                .opacity(moves[index] == "" ? 1 : 0)
                            Text(moves[index])
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .opacity(moves[index] != "" ? 1 : 0)
                        }
                        .frame(width: geometry.size.width / 4, height: geometry.size.width / 4)
                        .rotation3DEffect(
                            .init(degrees: moves[index] != "" ? 180 : 0),
                            axis: (x: 0.0, y: 1.0, z: 0.0),
                            anchor: .center,
                            anchorZ: 0.0,
                            perspective: 1.0
                        )
                        .cornerRadius(16)
                        .onTapGesture(perform: {
                            withAnimation(Animation.easeIn(duration: 0.5)) {
                                if moves[index] == "" {
                                    moves[index] = isPlaying ? "X" : "O"
                                    isPlaying.toggle()
                                }
                            }
                        })
                    }
                }.padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
