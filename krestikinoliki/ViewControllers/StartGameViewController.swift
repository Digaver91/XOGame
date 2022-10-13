//
//  StartGameViewController.swift
//  krestikinoliki
//
//  Created by Dmytro Gavrylov on 22.07.2022.
//

import UIKit

class StartGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? GameViewController else {
         return
        }
        if segue.identifier == "chooseX" {
            vc.user = .x
        }
        if segue.identifier == "chooseO" {
            vc.user = .o
        }
    }

}
