//
//  ViewController.swift
//  HanoiTower
//
//  Created by Tengoku no Spoa on 2018/1/25.
//  Copyright © 2018年 Tengoku no Spoa. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // layers of Tower
    var towerHeight = 3
    
    // expected String for towerC
    var expectedString = ""
    
    // text fields for Towers
    @IBOutlet weak var fieldA: NSTextField!
    @IBOutlet weak var fieldB: NSTextField!
    @IBOutlet weak var fieldC: NSTextField!
    
    // if button is pressed the first time
    var towerSelected = false
    
    // name for the selected Tower
    var selectedTower = ""
    
    // Level
    @IBOutlet weak var level: NSTextField!
    
    // Status
    @IBOutlet weak var status: NSTextField!
    
    // var moves count
    @IBOutlet weak var moveCount: NSTextField!
    var count = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    func newGame(){
        level.stringValue = "Level:\(towerHeight-2)"
        count = 0
        moveCount.stringValue = "Count:0"
        towerSelected = false
        selectedTower = ""
        var i = 0
        let height = towerHeight
        fieldA.stringValue = ""
        fieldB.stringValue = ""
        fieldC.stringValue = ""
        while(i<height){
            fieldA.stringValue += "\(height-i) "
            i+=1
        }
        expectedString = fieldA.stringValue

    }
    
    @IBAction func selectionButtonDidPressed(_ sender: NSButton) {
        print(sender.title)
        if !towerSelected {
            clearStatus()
            guard towerOf(alphabet: sender.title) != [] else {
                print("No Tower in \(sender.title)")
                status.stringValue = "No Tower in \(sender.title)"
                return
            }
            status.stringValue += sender.title
            selectedTower = sender.title
        } else if selectedTower == sender.title {
            print("Same Tower!")
            status.stringValue = "Same Tower!"
        } else {
            moveTower(from: selectedTower, to: sender.title)
            
        }
        towerSelected = !towerSelected
        if(fieldC.stringValue == expectedString){
            print("LEVEL UP!")
            status.stringValue = "LEVEL UP!"
            towerHeight += 1
            towerSelected = false
            newGame()
        }
    }
    
    func clearStatus(){
        status.stringValue = "Move:"
    }
    
    
    func moveTower(from start:String, to destination:String){
        count += 1
        moveCount.stringValue = "Count:\(count)"
        print(start + " -> " + destination)
        var startArray = towerOf(alphabet: start)
        var destinationArray = towerOf(alphabet: destination)
        if destinationArray.last?.description != nil {
            guard Int(startArray.last!.description)! < Int(destinationArray.last!.description)! else {
                print("Too Big!")
                status.stringValue = "Too Big!"
                return
            }
        }
        status.stringValue += "  ->  \(destination)"
        print("\(startArray) -> \(destinationArray)")
        destinationArray.append(startArray.removeLast())
        print("\(startArray) -> \(destinationArray)")
        updateLabel(label: start, value: startArray)
        updateLabel(label: destination, value: destinationArray)
        
    }
    
    
    func updateLabel(label:String,value:[String.SubSequence]){
        let valueString = value.joined(separator: " ") + " "
        switch label {
        case "A":
            fieldA.stringValue = valueString
        case "B":
            fieldB.stringValue = valueString
        case "C":
            fieldC.stringValue = valueString
        default:
            fieldA.stringValue = valueString
        }
    }
    
    
    func towerOf(alphabet:String)->[String.SubSequence]{
        switch alphabet {
        case "A":
            return fieldA.stringValue.split(separator: " ")
        case "B":
            return fieldB.stringValue.split(separator: " ")
        case "C":
            return fieldC.stringValue.split(separator: " ")
        default:
            return fieldA.stringValue.split(separator: " ")
        }
    }
    
}

