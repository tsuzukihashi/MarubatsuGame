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
                        ItemCell(
                            isSelected: viewModel.isSelected(at: index),
                            state: viewModel.moves[index],
                            size: geometry.size.width / 4
                        )
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
            Alert(
                title: Text("終了"),
                message: Text(viewModel.message),
                dismissButton: .destructive(
                    Text("もう一度？"),
                    action: {
                        withAnimation(Animation.easeIn(duration: 0.5)) {
                            viewModel.retry()
                        }
                    }
                )
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
