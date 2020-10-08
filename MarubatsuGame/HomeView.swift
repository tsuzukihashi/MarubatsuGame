import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible() ,spacing: 8), count: 3),
                spacing: 8
            ) {
                ForEach(0..<9, id: \.self) { index in
                    Color.white
                }
            }.padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
