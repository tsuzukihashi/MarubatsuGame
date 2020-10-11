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
}
