//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
class Player{
    var name : String
    var total_score : Int
    var round_score : Int
    init(name:String){
        self.name = name
        self.total_score = 0
        self.round_score = 0
    }
    
    func update_round_score(){
        self.total_score += self.round_score
        self.round_score = 0
//        print("\(self.name) => Total : \(self.total_score) Round: \(self.round_score)")
    }
    
    func check_the_round(dice_one:Int, dice_two:Int) -> Int{
        if (dice_one == dice_two && dice_one == 6){
            self.round_score = 0
            self.total_score = 0
            return 1
        }
        else if (dice_one == dice_two && dice_one == 1){
            self.round_score = 0
            return 1
        }
        else{
            self.round_score += (dice_one+dice_two)
            return 0
        }
    }
    
    func check_score() -> Bool{
        return self.total_score>=100 ? true : false
    }
}
class ViewController: UIViewController {

    @IBOutlet weak var dice_one: UIImageView!
    @IBOutlet weak var dice_two: UIImageView!
    @IBOutlet weak var pOneScore: UILabel!
    @IBOutlet weak var pTwoScore: UILabel!
    @IBOutlet weak var round_score: UILabel!
    var count = 0
    let num_str = ["One","Two","Three","Four","Five","Six"];
    var num_one = 0,num_two = 0
    var player_1 = Player(name: "Player_One")
    var player_2 = Player(name: "Player Two")
    var cur_player : Player?
    var scorelabel: UILabel?
    var condition = false
    var const_label  = "p"
    @IBAction func button(_ sender: UIButton) {
        scorelabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if(!player_1.check_score() && !player_2.check_score() && !condition){
            if (count%2==0){
                cur_player = player_1
                scorelabel = pOneScore
            }
            else{
                cur_player = player_2
                scorelabel = pTwoScore
            }
            scorelabel?.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            const_label = String((scorelabel?.text?.split(separator: ":")[0] ?? "NILL")+": ")
            num_one = Int.random(in: 1 ..< 7)
            num_two = Int.random(in: 1 ..< 7)
            dice_one.image = UIImage(named: "Dice"+String(num_str[num_one-1]))
            dice_two.image = UIImage(named: "Dice"+String(num_str[num_two-1]))
            count += cur_player?.check_the_round(dice_one: num_one, dice_two: num_two) ?? 0
            print("\(count)")
            round_score.text = String(cur_player?.round_score ?? 0)
            condition = cur_player?.check_score() ?? true
            print("Condition : \(condition)")
            if(condition == true){
                scorelabel?.text = "Winner!!"
                scorelabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
        else{
            print("We have a winner !!")
            scorelabel?.text = "Winner!!"
            scorelabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    @IBAction func holdbtn(_ sender: UIButton) {
        cur_player?.update_round_score()
        condition = cur_player?.check_score() ?? true
        print("Condition [inside hold function] => \(condition)")
        if(!condition){
            count+=1
            scorelabel?.text = String(const_label + String(cur_player?.total_score ?? 0))
            round_score.text = String(0)
            scorelabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        else{
            scorelabel?.text = "Winner!!"
            scorelabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            print("the Game is over !!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dice_two.image = #imageLiteral(resourceName: "DiceSix")
    }

    
    


}

