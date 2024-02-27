//
//  InterfaceController.swift
//  LoR-RPS WatchKit Extension
//
//  Created by 张铖祺 on 2022-07-25.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    
    @IBOutlet weak var tlImg: WKInterfaceImage!
    
    
    @IBOutlet weak var tmImg: WKInterfaceImage!
    
    @IBOutlet weak var trImg: WKInterfaceImage!
    
    @IBOutlet weak var mlImg: WKInterfaceImage!
    
    
    @IBOutlet weak var mmImg: WKInterfaceImage!
    
    @IBOutlet weak var mrImg: WKInterfaceImage!
    
    @IBOutlet weak var blImg: WKInterfaceImage!
    
    @IBOutlet weak var bmImg: WKInterfaceImage!
    
    @IBOutlet weak var brImg: WKInterfaceImage!
    
    var gs = 0
    var L = 0
    var R = 0
    var OL = 0
    var OR = 0
    var tmp = 0
    
    func gamestart(){
        blImg.setImageNamed( "jd1")
        bmImg.setImageNamed( "st1")
        brImg.setImageNamed( "bu1")
        mmImg.setImageNamed("empty")
    }
    
    func gamestmpend(){
        blImg.setImageNamed( "empty")
        bmImg.setImageNamed( "restart")
        brImg.setImageNamed( "empty")
    }
    
  
    
    func showL(L:Int){
        if L == 0 {
            mlImg.setImageNamed("empty")
        }
        if L == 1 {
            mlImg.setImageNamed( "jd1")
        }
        if L == 2 {
            mlImg.setImageNamed( "st1")
        }
        if L == 3 {
            mlImg.setImageNamed( "bu1")
        }
        
    }
    
    func showR(R:Int){
        if R == 0 {
            mrImg.setImageNamed( "empty")
        }
        if R == 1 {
            mrImg.setImageNamed( "jd1")
        }
        if R == 2 {
            mrImg.setImageNamed( "st1")
        }
        if R == 3 {
            mrImg.setImageNamed( "bu1")
        }
        
    }
    
    func showOL(OL:Int){
        if OL == 0 {
            tlImg.setImageNamed( "empty")
        }
        if OL == 1 {
            tlImg.setImageNamed( "jd1")
        }
        if OL == 2 {
            tlImg.setImageNamed( "st1")
        }
        if OL == 3 {
            tlImg.setImageNamed( "bu1")
        }
        
    }
    
    func showOR(OR:Int){
        if OR == 0 {
            trImg.setImageNamed( "empty")
        }
        if OR == 1 {
            trImg.setImageNamed( "jd1")
        }
        if OR == 2 {
            trImg.setImageNamed( "st1")
        }
        if OR == 3 {
            trImg.setImageNamed( "bu1")
        }
        
    }
    
    
    
    
    
    
    func showhands(L:Int,R:Int,OL:Int,OR:Int){
        print("shcalled")
        showL(L: L)
        showR(R: R)
        showOL(OL: OL)
        showOR(OR: OR)
        
    }
    
    func findCtr (num:Int) -> Int {
        if num == 1{
            return 2
        }
        if num == 2{
            return 3
        }
        if num == 3{
            return 1
        }
        return 0
    }
    
    func findOR () {
        OR = findCtr(num: L)
        if OR == OL {
            OR = findCtr(num: OL)
        }
    }
    
    func decidedraw(){
        if (L == R) || (L+R == OL+OR){
            OL = 0
            return
        }
        
        tmp = Int.random(in:(0..<2))
        if tmp != 0 {
            OR = 0
        }else{
            OL = 0
        }
    }
    
    func reset(){
        gs = 0
        L = 0
        R = 0
        OL = 0
        OR = 0
        gamestart()
    }
    
    func nextstp (num:Int){
        print(gs)
        if gs == 3{
            reset()
            showhands(L: L, R: R, OL: OL, OR: OR)
            return
            
        }
        if (gs < 2) && (num > 3) {
            return
        }
        if (gs > 1) && (num < 4){
            return
        }
        
        if gs == 0 {
            L = num
            OL = Int.random(in: (1..<4))
            R = 0
            OR = 0
            showhands(L: L, R: R, OL: OL, OR: OR)
            gs = 1
            return
        }
        if gs == 1{
            R = num
            findOR()
            showhands(L: L, R: R, OL: OL, OR: OR)
            gs = 2
            mmImg.setImageNamed("swipe")
            return
        }
        
        if gs == 2{
            decidedraw()
            /////////////////////////////////////////////// func if win
            //////////////mmImg.setImageNamed("") show result
            if num == 4 {
                L = 0
            } else if num == 5{
                R = 0
            }
            showhands(L: L, R: R, OL: OL, OR: OR)
            gamestmpend()
            gs = 3
            return
            
        }
        
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    
    
    @IBAction func chooser(_ sender: Any) {
        nextstp(num: 4)
    }
    @IBAction func choosel(_ sender: Any) {
        nextstp(num: 5)
    }
    
    @IBAction func jd(_ sender: Any) {
        nextstp(num: 1)
    }
    @IBAction func st(_ sender: Any) {
        nextstp(num: 2)
    }
    @IBAction func bu(_ sender: Any) {
        nextstp(num: 3)
    }
    
    @IBAction func tapbu(_ sender: Any) {
        nextstp(num: 3)
    }
    @IBAction func tapst(_ sender: Any) {
        nextstp(num: 2)
    }
    @IBAction func tapjd(_ sender: Any) {
        nextstp(num: 1)
    }
    
}
