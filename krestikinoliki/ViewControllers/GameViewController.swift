//
//  GameViewController.swift
//  krestikinoliki
//
//  Created by Dmytro Gavrylov on 22.07.2022.
//

import UIKit

class GameViewController: UIViewController {
    enum BoardType: String {
        case x = "X"
        case o = "O"
        case empty = "*"
        
        var image: UIImage? {
            switch self {
            case .x:
                return UIImage(named: "icon.x")
            case .o:
                return UIImage(named: "icon.o")
            case .empty:
                return nil
            }
        }
}
    
    private var gameStatusItems = [[BoardType]]()
         
    
    private var computer: BoardType = .o
    var user: BoardType = .x {
        didSet {
            if user == .x {
                computer = .o
            } else {
                computer = .x
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet var boardButton: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0...2 {
            gameStatusItems.append([.empty, .empty, .empty])
        }
        displayBoard()
        subtitleLabel.text = ""
        if user == .x {
            titleLabel.text = "Users turn"
        } else {
            titleLabel.text = "Computers turn"
            computerTurn()
        }
    }
    

    @IBAction func topOnBoardsButtons(_ sender: Any) {
        guard let clickedButton = sender as? UIButton else {
            return
        }
        
        let indexButton = clickedButton.tag
        let i = indexButton / 3, j = indexButton % 3
        subtitleLabel.text = ""
        
        if gameStatusItems[i][j] != .empty {
            subtitleLabel.text = "Sorry the cell is not empty"
            return
        }
        
        gameStatusItems[i][j] = user
        displayBoard()

        if checkIfWin(for: user) {
            subtitleLabel.text = "You Win!!!"
            return
        }

        if !isEmptyCell() {
            subtitleLabel.text = "No free space"
            return
        }
        computerTurn()
    }
    
    
    private func resetBoard() {
        for i in 0..<gameStatusItems.count {
            for j in 0..<gameStatusItems[i].count {
                gameStatusItems[i][j] = .empty
            }
        }
        displayBoard()
    }
    
    private func displayBoard() {
        boardButton.forEach { button in
            let buttonIndex = button.tag
            let i = buttonIndex / 3, j = buttonIndex % 3
            button.setTitle("",for: .normal)
            button.backgroundColor = .darkText.withAlphaComponent(0.5)

            button.setImage(gameStatusItems[i][j].image, for: .normal)
        
        }
    }
    
    private func checkIfWin(for type: BoardType) -> Bool {
        var diagonalCount = 0, diagonal2 = 0
        for i in 0..<gameStatusItems.count {
            var iCount = 0, jCount = 0
            for j in 0..<gameStatusItems.count {
                if gameStatusItems[i][j] == type {
                    jCount += 1
                }

                if gameStatusItems[j][i] == type {
                    iCount += 1
                }

                if i == j && gameStatusItems[j][i] == type {
                    diagonalCount += 1
                }

                if i == gameStatusItems.count - 1 - j  && gameStatusItems[j][i] == type {
                    diagonal2 += 1
                }

            }

            if iCount == 3 || jCount == 3 {
                return true
            }
        }

        if diagonalCount == 3 || diagonal2 == 3 {
            return true
        }

        return false
    }
    
    private func isEmptyCell() -> Bool {
        for i in 0..<gameStatusItems.count {
            for j in 0..<gameStatusItems[i].count {
                if gameStatusItems[i][j] == .empty {
                    return true
                }
            }
        }
        return false
    }
    
    private func computerTurn() {
        var iIndex = 0
        var jIndex = 0
        for i in 0..<gameStatusItems.count {
            for j in 0..<gameStatusItems[i].count {
                if gameStatusItems[i][j] == .empty {
                    iIndex = i
                    jIndex = j
                }
            }
        }
        gameStatusItems[iIndex][jIndex] = computer
        displayBoard()

        if checkIfWin(for: computer) {
            subtitleLabel.text = "Computer Win!!!"
            sleep(1)
            return
        }

        if !isEmptyCell() {
            subtitleLabel.text = "No free space"
            sleep(1)
            resetBoard()

            return
        }


    }
  
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
    
