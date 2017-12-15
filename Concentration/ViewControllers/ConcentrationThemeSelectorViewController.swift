//
//  ConcentrationThemeSelectorViewController.swift
//  Concentration
//
//  Created by Dumitru Gutu on 12/14/17.
//  Copyright © 2017 Dumitru Gutu. All rights reserved.
//

import UIKit

class ConcentrationThemeSelectorViewController: UIViewController {

    // MARK: - Navigation
    
    let themes = [
        "Sports": "🏐🏀🏓🎱🏈🎾⚾️⚽️🏂",
        "Faces": "🙄🙁😎🤪😡😇😵🤢🤩",
        "Animals": "🐶🐭🐷🐸🐝🦉🐬🐢🦁"
    ]

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTheme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let cvc = segue.destination as? ConcentrationViewController {
                cvc.theme = themes[themeName]
            }
        }
    }
}
