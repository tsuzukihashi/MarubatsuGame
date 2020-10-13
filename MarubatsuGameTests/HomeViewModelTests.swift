import XCTest
@testable import MarubatsuGame

class HomeViewModelTests: XCTestCase {
    var subject: HomeViewModel!

    override func setUp() {
        subject = .init()
    }
    
    func test_onTapGesture() {
        XCTContext.runActivity(named: "まだタップしていないマスのとき") { _ in
            XCTContext.runActivity(named: "isPlayingがtrueのとき") { _ in
                setUp()
                subject.isPlaying = true
                subject.onTapGesture(at: 0)
                
                XCTAssertEqual(subject.moves[0], "×")
            }
            XCTContext.runActivity(named: "isPlayingがfalseのとき") { _ in
                setUp()
                subject.isPlaying = false
                subject.onTapGesture(at: 0)
                
                XCTAssertEqual(subject.moves[0], "○")
            }
        }
    }
    
    func test_isSelected() {
        XCTContext.runActivity(named: "指定されたマスが空のとき") { _ in
            setUp()
            subject.moves[0] = ""
            
            XCTAssertFalse(subject.isSelected(at: 0))
        }
        XCTContext.runActivity(named: "指定されたマスが空のとき") { _ in
            setUp()
            subject.moves[0] = "○"
            
            XCTAssertTrue(subject.isSelected(at: 0))
        }
    }
    
    func test_retry() {
        XCTContext.runActivity(named: "リトライするときリセットされること") { _ in
            setUp()
            subject.moves.enumerated().forEach { num, move in
                subject.moves[num] = String(num)
            }
            subject.retry()
            
            subject.moves.forEach { move in
                XCTAssertEqual(move, "")
            }
            XCTAssertTrue(subject.isPlaying)
        }
    }
    
    func test_checkMoves() {
        XCTContext.runActivity(named: "何も揃っていないとき、falseになること") { _ in
            setUp()
            
            subject.moves[0] = "○"
            subject.moves[4] = ""
            subject.moves[7] = "○"
            
            XCTAssertFalse(subject.checkMoves(player: "○"))
        }
        XCTContext.runActivity(named: "横一列揃っているとき、trueになること") { _ in
            setUp()
            
            subject.moves[0] = "○"
            subject.moves[1] = "○"
            subject.moves[2] = "○"
            
            XCTAssertTrue(subject.checkMoves(player: "○"))
        }
        XCTContext.runActivity(named: "縦一列揃っているとき、trueになること") { _ in
            setUp()
            
            subject.moves[0] = "○"
            subject.moves[3] = "○"
            subject.moves[6] = "○"
            
            XCTAssertTrue(subject.checkMoves(player: "○"))
        }
        XCTContext.runActivity(named: "右斜め一列揃っているとき、trueになること") { _ in
            setUp()
            
            subject.moves[2] = "○"
            subject.moves[4] = "○"
            subject.moves[6] = "○"
            
            XCTAssertTrue(subject.checkMoves(player: "○"))
        }
        XCTContext.runActivity(named: "左斜め一列揃っているとき、trueになること") { _ in
            setUp()
            
            subject.moves[0] = "○"
            subject.moves[4] = "○"
            subject.moves[8] = "○"
            
            XCTAssertTrue(subject.checkMoves(player: "○"))
        }
    }
}
