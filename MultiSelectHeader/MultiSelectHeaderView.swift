
/*
 Copyright (c) 2017 Umar Farooque.
 
 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the "Software"),
 to deal in the Software without restriction, including without limitation
 the rights to use, copy, modify, merge, publish, distribute, sublicense,
 and/or sell copies of the Software, and to permit persons to whom the Software
 is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
 OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */



import UIKit

protocol sectionTappedDelegate: class {
    func sectionSelectAction(section: Int)
}

class MultiSelectHeaderView: UITableViewHeaderFooterView {
    
    
    // MARK: OUTLETS
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var teamsCountLabel: UILabel!
    @IBOutlet weak var matchesCountLabel: UILabel!
    @IBOutlet weak var headquartersLabel: UILabel!
    @IBOutlet weak var foundedLabel: UILabel!
    var isUserChecked = false
    
    // MARK: VARIABLES
    weak var delegate: sectionTappedDelegate?
    var sectionNumber: Int!
    
    // MARK: BUTTON ACTIONS
    @IBAction func checkButtonAction(_ sender: Any) {
        delegate?.sectionSelectAction(section: sectionNumber)
       
    }
    
    // MARK: CELL LAYOUT
    func setupView(leagueModel:LeagueModel) {
        let backgroundView = UIView(frame: (self.bounds))
        backgroundView.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1.00)
        self.backgroundView = backgroundView
        leagueNameLabel.text =  leagueModel.leagueName
        teamsCountLabel.text =  leagueModel.teams
        matchesCountLabel.text = leagueModel.matches
        headquartersLabel.text = leagueModel.headquarters
        foundedLabel.text = leagueModel.founded
                
        if isUserChecked == false{
            checkButton.isSelected = false
        }else{
            checkButton.isSelected = true
        }
        
        if leagueModel.teamsArr.count > 0 {
            checkButton.isHidden = false
        }else{
            checkButton.isHidden = true
        }

    }
}
