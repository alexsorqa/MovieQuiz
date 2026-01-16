//
//  ViewController.swift
//  NewApp
//
//  Created by Alexey Sorokin on 12/31/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var skyImageView: UIImageView!
    @IBOutlet weak var changeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skyImageView.image = UIImage(systemName: "moon")
        skyImageView.tintColor = .gray
        changeButton.backgroundColor = .green
    }

    @IBAction func buttonDidTap(_ sender: Any) {
        print("Нажатие")
        if isSun { // 1
            skyImageView.image = UIImage(systemName: "moon") // 2
        } else {
            skyImageView.image = UIImage(systemName: "sun.max") // 3
        }
        isSun.toggle() // 4
    }
    
    @IBAction func buttonTouchDown(_ sender: Any) {
        print("button touch down")
    }
    
    private var isSun: Bool = false
    
}

