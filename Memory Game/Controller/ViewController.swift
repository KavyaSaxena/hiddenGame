//
//  ViewController.swift
//  Memory Game
//
//  Created by kavya saxena on 26/11/19.
//  Copyright © 2019 kavya saxena. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var rowText: UITextField! // number of rows in game
    @IBOutlet weak var columnText: UITextField! // number of columns in game
    
    var mul:Int = 9 // if invalid input by user then default value of number of cells
    override func viewDidLoad() {
        super.viewDidLoad()
        rowText.delegate = self
        columnText.delegate = self
    }

    @IBAction func playButtonPressed(_ sender: UIButton) {
        //checking if row and columns text have valid input
        if(rowText.hasText && columnText.hasText && Int(rowText.text!)! < 4 && Int(rowText.text!)! > 2 && Int(columnText.text!)! > 2 && Int(columnText.text!)! < 9){
            let row = Int(rowText.text!)
            let column = Int(columnText.text!)
            mul = row!*column!
        }
        // moving from GameViewController
        let next = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        next.noOfCells = mul
        self.present(next, animated: true, completion: nil)
        
    }

    // Allows only 1 number as input in UITextFields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        if currentText.count == 1 {
            textField.resignFirstResponder()
        }
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        if updatedText.count == 1{
            showToast(message: "Press any key to dismiss keyboard", font: UIFont(name: "Helvetica Neue", size: 10)!)
        }
        // make sure the result is under 1 characters
        return updatedText.count <= 1
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: 100, width: 200, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

