import Combine
import Foundation

protocol HomeViewModelProtocol {
    var moves: [String] { get set }
    var isPlaying: Bool { get set }
    var isGameOver: Bool { get set }
    var message: String { get }
    func onTapGesture(at index: Int)
    func isSelected(at index: Int) -> Bool
    func checkMoves(player: String) -> Bool
    func checkWinner()
    func retry()
}

final class HomeViewModel: ObservableObject, HomeViewModelProtocol {
    @Published var moves: [String] = Array(repeating: "", count: 9)
    @Published var isPlaying = true
    @Published var isGameOver = false
    @Published var message = ""

    func onTapGesture(at index: Int) {
        if moves[index] == "" {
            moves[index] = isPlaying ? "×" : "○"
            isPlaying.toggle()
        }
    }
    
    func isSelected(at index: Int) -> Bool {
        moves[index] != ""
    }
    
    func checkWinner() {
        if checkMoves(player: "×") {
            message = "×チームの勝ち"
            isGameOver = true
        }
        else if checkMoves(player: "○") {
            message = "○チームの勝ち"
            isGameOver = true
        }
        else {
            let isFinished = !moves.contains { move -> Bool in
                move == ""
            }
            if isFinished {
                message = "引き分け"
                isGameOver = true
            }
        }
    }
    
    func checkMoves(player: String) -> Bool {
        for i in stride(from: 0, to: 9, by: 3) {
            if moves[i] == player && moves[i+1] == player && moves[i+2] == player {
                return true
            }
        }
        for i in 0..<3 {
            if moves[i] == player && moves[i+3] == player && moves[i+6] == player {
                return true
            }
        }
        if moves[0] == player && moves[4] == player && moves[8] == player {
            return true
        }
        if moves[2] == player && moves[4] == player && moves[6] == player {
            return true
        }
        return false
    }
    
    func retry() {
        moves.removeAll()
        moves = Array(repeating: "", count: 9)
        isPlaying = true
    }
}
