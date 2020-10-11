import Combine

protocol HomeViewModelProtocol {
    var moves: [String] { get set }
    var isPlaying: Bool { get set }
    func onTapGesture(at index: Int)
    func isSelected(at index: Int) -> Bool
}

final class HomeViewModel: ObservableObject, HomeViewModelProtocol {
    @Published var moves: [String] = Array(repeating: "", count: 9)
    @Published var isPlaying = false
    
    func onTapGesture(at index: Int) {
        if moves[index] == "" {
            moves[index] = isPlaying ? "×" : "○"
            isPlaying.toggle()
        }
    }
    
    func isSelected(at index: Int) -> Bool {
        moves[index] != ""
    }
}
