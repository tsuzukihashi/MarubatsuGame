import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
 
    var body: some View {
        VStack {
            GeometryReader { geometry in
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible() ,spacing: 4), count: 3),
                    spacing: 16
                ) {
                    ForEach(0..<9, id: \.self) { index in
                        ZStack {
                            Color.orange
                            Color.white
                                .opacity(viewModel.isSelected(at: index) ? 0 : 1)
                            Text(viewModel.moves[index])
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .opacity(viewModel.isSelected(at: index) ? 1 : 0)
                        }
                        .frame(width: geometry.size.width / 4, height: geometry.size.width / 4)
                        .rotation3DEffect(
                            .init(degrees: viewModel.isSelected(at: index) ? 180 : 0),
                            axis: (x: 0.0, y: 1.0, z: 0.0),
                            anchor: .center,
                            anchorZ: 0.0,
                            perspective: 1.0
                        )
                        .cornerRadius(16)
                        .onTapGesture(perform: {
                            withAnimation(Animation.easeIn(duration: 0.5)) {
                                viewModel.onTapGesture(at: index)
                            }
                        })
                    }
                }.padding()
            }
        }.onChange(of: viewModel.moves) { value in
            viewModel.checkWinner()
        }.alert(isPresented: $viewModel.isGameOver) {
            Alert(title: Text("終了"), message: Text(viewModel.message), dismissButton: .destructive(Text("もう一度？"), action: {
                withAnimation(Animation.easeIn(duration: 0.5)) {
                    viewModel.retry()
                }
            }))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
