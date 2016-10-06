//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Zach Zeleznick on 9/20/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Width and Height of Screen for Layout
    var w: CGFloat!
    var h: CGFloat!
    

    // IMPORTANT: Do NOT modify the name or class of resultLabel.
    //            We will be using the result label to run autograded tests.
    // MARK: The label to display our calculations
    var resultLabel = UILabel()
    
    // TODO: This looks like a good place to add some data structures.
    //       One data structure is initialized below for reference.
    var someDataStructure: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        w = view.bounds.size.width
        h = view.bounds.size.height
        navigationItem.title = "Calculator"
        // IMPORTANT: Do NOT modify the accessibilityValue of resultLabel.
        //            We will be using the result label to run autograded tests.
        resultLabel.accessibilityValue = "resultLabel"
        makeButtons()
        // Do any additional setup here.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: A method to update your data structure(s) would be nice.
    //       Modify this one or create your own.
    func updateSomeDataStructure(_ content: String) {
        if (content == "=") {
            if (someDataStructure[1] == "/" && Int(someDataStructure[0])! % Int(someDataStructure[2])! != 0) {
                let value = doubleCalculate(a: someDataStructure[0], b: someDataStructure[2], operation: "/")
                updateResultLabel(String(value))
                someDataStructure.removeAll()
                someDataStructure.append(String(value))
            } else {
                if (Int(someDataStructure[0]) == nil || Int(someDataStructure[2]) == nil ) {
                    let value = doubleCalculate(a: someDataStructure[0], b: someDataStructure[2], operation: someDataStructure[1])
                    updateResultLabel(String(value))
                    someDataStructure.removeAll()
                    someDataStructure.append(String(value))
                } else {
                    let value = calculate()
                    updateResultLabel(value)
                    someDataStructure.removeAll()
                    someDataStructure.append(value)
                }
            }
        } else if (content == "+/-") {
            let number = Int(someDataStructure[someDataStructure.count - 1])
            someDataStructure.popLast()
            let modifiedNumber = number! * -1
            let numberStr = String(modifiedNumber)
            updateSomeDataStructure(numberStr)
            updateResultLabel(numberStr)
        } else if (content == "C") {
            someDataStructure.removeAll()
            updateResultLabel("0")
        } else if (someDataStructure.count == 0) {
            someDataStructure.append(content)
            updateResultLabel(content)
            print(someDataStructure)
        }else if (someDataStructure[someDataStructure.count-1] == "."){
            if (resultLabel.text!.characters.count == 7) {
                return
            }
            let element = someDataStructure[someDataStructure.count - 1]
            if (someDataStructure.count >= 2) {
                let element2  = someDataStructure[someDataStructure.count - 2]
                someDataStructure.popLast()
                print(someDataStructure)
                someDataStructure.popLast()
                print(someDataStructure)
                if (someDataStructure.count == 0) {
                    someDataStructure.append(element2 + element + content)
                    updateResultLabel(someDataStructure[0])
                    print(someDataStructure)
                } else {
                    if (Int(someDataStructure[someDataStructure.count - 1]) == nil && Float(someDataStructure[someDataStructure.count - 1]) == nil) {
                        someDataStructure.append(element2 + element + content)
                        updateResultLabel(someDataStructure[someDataStructure.count - 1])
                        print(someDataStructure)
                    }
                    someDataStructure[someDataStructure.count - 1] = element2 + element + content
                    updateResultLabel(someDataStructure[someDataStructure.count - 1])
                    print(someDataStructure)
                }
            } else {
                someDataStructure[someDataStructure.count - 1] = element + content
                updateResultLabel(someDataStructure[someDataStructure.count - 1])
                print(someDataStructure)
            }
        } else if (Int(someDataStructure[someDataStructure.count-1]) == nil && Int(content) == nil && Float(someDataStructure[someDataStructure.count - 1]) == nil) {
            someDataStructure.popLast()
            someDataStructure.append(content)
        } else if (someDataStructure.count == 3 && Int(someDataStructure[0]) != nil &&
            Int(someDataStructure[1]) == nil && Int(someDataStructure[2]) != nil && Int(content) == nil) {
            if (someDataStructure[1] == "/" && Int(someDataStructure[0])! % Int(someDataStructure[2])! != 0) {
                let value = doubleCalculate(a: someDataStructure[0], b: someDataStructure[2], operation: "/")
                updateResultLabel(String(value))
                someDataStructure.removeAll()
                someDataStructure.append(String(value))
                someDataStructure.append(content)
            } else {
                if (Int(someDataStructure[0]) == nil || Int(someDataStructure[2]) == nil ) {
                    let value = doubleCalculate(a: someDataStructure[0], b: someDataStructure[2], operation: someDataStructure[1])
                    updateResultLabel(String(value))
                    someDataStructure.removeAll()
                    someDataStructure.append(String(value))
                    someDataStructure.append(content)
                } else {
                    let value = calculate()
                    updateResultLabel(value)
                    someDataStructure.removeAll()
                    someDataStructure.append(value)
                    someDataStructure.append(content)
                }
            }
        } else if (Int(someDataStructure[someDataStructure.count - 1]) != nil && Int(content) != nil) {
            if (resultLabel.text!.characters.count == 7) {
                return
            }
            let element = someDataStructure[someDataStructure.count - 1]
            someDataStructure[someDataStructure.count - 1] = element + content
            updateResultLabel(someDataStructure[someDataStructure.count - 1])
            print(someDataStructure)
        } else if (Float(someDataStructure[someDataStructure.count - 1]) != nil && Int(content) != nil) {
            if (resultLabel.text!.characters.count == 7) {
                return
            }
            let element = someDataStructure[someDataStructure.count - 1]
            someDataStructure[someDataStructure.count - 1] = element + content
            updateResultLabel(someDataStructure[someDataStructure.count - 1])
            print(someDataStructure)
        } else {
            someDataStructure.append(content)
            updateResultLabel(content)
            print(someDataStructure)
        }
    }
    
    // TODO: Ensure that resultLabel gets updated.
    //       Modify this one or create your own.
    func updateResultLabel(_ content: String) {
        resultLabel.text = content
    }
    
    
    // TODO: A calculate method with no parameters, scary!
    //       Modify this one or create your own.
    func calculate() -> String {
        let x = Int(someDataStructure[0])
        let y = Int(someDataStructure[2])
        let op = someDataStructure[1]
        return String(intCalculate(a: x!, b: y!, operation: op))
    }
    
    // TODO: A simple calculate method for integers.
    //       Modify this one or create your own.
    func intCalculate(a: Int, b:Int, operation: String) -> Int {
        if (operation == "+") {
            return a + b
        } else if (operation == "-") {
            return a - b
        } else if (operation == "/") {
            return a/b
        } else {
            return a * b
        }
    }
    
    // TODO: A general calculate method for doubles
    //       Modify this one or create your own.
    func doubleCalculate(a: String, b:String, operation: String) -> Double {
        if (operation == "/") {
            return Double(a)! / Double(b)!
        } else if (operation == "-") {
            return Double(a)! - Double(b)!
        } else if (operation == "*") {
            return Double(a)! * Double(b)!
        } else {
            return Double(a)! + Double(b)!
        }
    }
    
    // REQUIRED: The responder to a number button being pressed.
    func numberPressed(_ sender: CustomButton) {
        guard Int(sender.content) != nil else { return }
        //print("The number \(sender.content) was pressed")
        updateSomeDataStructure(sender.content)
    }
    
    // REQUIRED: The responder to an operator button being pressed.
    func operatorPressed(_ sender: CustomButton) {
        updateSomeDataStructure(sender.content)
    }
    
    // REQUIRED: The responder to a number or operator button being pressed.
    func buttonPressed(_ sender: CustomButton) {
       // Fill me in!
        updateSomeDataStructure(sender.content)
    }
    
    // IMPORTANT: Do NOT change any of the code below.
    //            We will be using these buttons to run autograded tests.
    
    func makeButtons() {
        // MARK: Adds buttons
        let digits = (1..<10).map({
            return String($0)
        })
        let operators = ["/", "*", "-", "+", "="]
        let others = ["C", "+/-", "%"]
        let special = ["0", "."]
        
        let displayContainer = UIView()
        view.addUIElement(displayContainer, frame: CGRect(x: 0, y: 0, width: w, height: 160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }
        displayContainer.addUIElement(resultLabel, text: "0", frame: CGRect(x: 70, y: 70, width: w-70, height: 90)) {
            element in
            guard let label = element as? UILabel else { return }
            label.textColor = UIColor.white
            label.font = UIFont(name: label.font.fontName, size: 60)
            label.textAlignment = NSTextAlignment.right
        }
        
        let calcContainer = UIView()
        view.addUIElement(calcContainer, frame: CGRect(x: 0, y: 160, width: w, height: h-160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }

        let margin: CGFloat = 1.0
        let buttonWidth: CGFloat = w / 4.0
        let buttonHeight: CGFloat = 100.0
        
        // MARK: Top Row
        for (i, el) in others.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Second Row 3x3
        for (i, digit) in digits.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: digit), text: digit,
            frame: CGRect(x: x, y: y+101.0, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
            }
        }
        // MARK: Vertical Column of Operators
        for (i, el) in operators.enumerated() {
            let x = (CGFloat(3) + 1.0) * margin + (CGFloat(3) * buttonWidth)
            let y = (CGFloat(i) + 1.0) * margin + (CGFloat(i) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.backgroundColor = UIColor.orange
                button.setTitleColor(UIColor.white, for: .normal)
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Last Row for big 0 and .
        for (i, el) in special.enumerated() {
            let myWidth = buttonWidth * (CGFloat((i+1)%2) + 1.0) + margin * (CGFloat((i+1)%2))
            let x = (CGFloat(2*i) + 1.0) * margin + buttonWidth * (CGFloat(i*2))
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: 405, width: myWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }

}

