
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

class MultiApprovalController: UIViewController {
    
    @IBOutlet weak var customNav: UINavigationBar!
    
    var cellSelectionArr = [TeamModel]()
    var selectionHeaderArr = [LeagueModel]()
    var leagueSectionArr = [LeagueModel]()
    
    @IBOutlet weak var multiTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        multiTable.estimatedRowHeight = 140
        multiTable.rowHeight = UITableViewAutomaticDimension
        multiTable.allowsSelection = true
        multiTable.register(UINib(nibName: "MultiSelectHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "MultiSelectHeaderView")
        multiTable.register(UINib(nibName: "MultiSelectCellView", bundle:nil),forCellReuseIdentifier: "multiselectionCell")
        customNav.layer.shadowColor = UIColor(red: 0.776, green: 0.749, blue: 0.749, alpha: 1.00).cgColor
        customNav.layer.shadowOpacity = 1
        customNav.layer.shadowOffset = CGSize(width: 1, height: 1)
        customNav.layer.shadowRadius = 3
        let attributes : [String: AnyObject] = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 18)!,NSForegroundColorAttributeName: UIColor.black]
        customNav.titleTextAttributes = attributes
        customNav.topItem?.title = "0 Team selected"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //demo data and Models
        
        let dataL1 = ["leagueName":"EPL","teams":"20","matches":"38","headquarters":"UK","founded":"1890"]
        
        var league1 = LeagueModel()
        league1 = league1.setEmptyObject()
        league1 = league1.setLeague(returnDict: dataL1)
        
        
        var team1Arr = [TeamModel]()
        
        var team1 = TeamModel()
        team1 = team1.setEmptyObject()
        team1 =  team1.setTeams(returnDict: ["teamName":"MANCHESTER UNITED","teamValue":"$3,689 M","founded":"1878"])
        
        var team2 = TeamModel()
        team2 = team2.setEmptyObject()
        team2 =  team2.setTeams(returnDict: ["teamName":"CHELSEA","teamValue":"$1,845 M","founded":"1905"])
        
        
        var team3 = TeamModel()
        team3 = team3.setEmptyObject()
        team3 =  team3.setTeams(returnDict: ["teamName":"LIVERPOOL","teamValue":"$1,492 M","founded":"1892"])
        
        
        team1Arr = [team1,team2,team3]
        league1 = league1.setChildArray(arr: team1Arr)
        leagueSectionArr.append(league1)
        
        
        
        let dataL2 = ["leagueName":"LA LIGA","teams":"20","matches":"38","headquarters":"MADRID","founded":"1929"]
        
        var league2 = LeagueModel()
        league2 = league2.setEmptyObject()
        league2 = league2.setLeague(returnDict: dataL2)
        
        
        var team2Arr = [TeamModel]()
        
        var teamL2 = TeamModel()
        teamL2 = teamL2.setEmptyObject()
        teamL2 =  teamL2.setTeams(returnDict: ["teamName":"REAL MADRID","teamValue":"$3,580 M","founded":"1902"])
        
        var teamL22 = TeamModel()
        teamL22 = teamL22.setEmptyObject()
        teamL22 =  teamL22.setTeams(returnDict: ["teamName":"BARCELONA","teamValue":"$3,635 M","founded":"1899"])
        
        
        team2Arr = [teamL2,teamL22]
        league2 = league2.setChildArray(arr: team2Arr)
        leagueSectionArr.append(league2)
        
        
        
        
        let dataL3 = ["leagueName":"BUNDESLIGA","teams":"18","matches":"34","headquarters":"FRANKFURT","founded":"1962"]
        
        var league3 = LeagueModel()
        league3 = league3.setEmptyObject()
        league3 = league3.setLeague(returnDict: dataL3)
        
        
        var team3Arr = [TeamModel]()
        
        var teamL3 = TeamModel()
        teamL3 = teamL3.setEmptyObject()
        teamL3 =  teamL3.setTeams(returnDict: ["teamName":"BAYERN MUNICH","teamValue":"$2,713 M","founded":"1900"])
        
        
        team3Arr = [teamL3]
        league3 = league3.setChildArray(arr: team3Arr)
        leagueSectionArr.append(league3)
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func cellSelectionAction(_ sender: Any){
        let selectButton = sender as! UIButton
        let cellIndex = selectButton.tag
        print("Cell Index: \(cellIndex)")
    }
}

// MARK: TABLE VIEW DELEGATE
extension MultiApprovalController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return leagueSectionArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leagueSectionArr.count == 0 {
            return leagueSectionArr.count
            
        }else{
            return leagueSectionArr[section].teamsArr.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "multiselectionCell") as? MultiSelectCellView
        
        
        var headerControlFlag = false
        if selectionHeaderArr.count > 0 {
            //check for section and if yes select all cells
            for header in selectionHeaderArr {
                for childObj in header.teamsArr {
                    
                    if isEqualTeamModel(obj1: childObj, obj2: leagueSectionArr[indexPath.section].teamsArr[indexPath.row]){
                        headerControlFlag = true
                    }
                }
                
            }
            
            if headerControlFlag == true{
                
                
                cell?.isUserSelected = true
                cell?.selectionButton.isSelected = true
                
            }else{
                var isSelected = false
                for obj in cellSelectionArr {
                    if isEqualTeamModel(obj1: obj, obj2: leagueSectionArr[indexPath.section].teamsArr[indexPath.row]) {
                        //contains
                        isSelected = true
                    }
                }
                if isSelected == false {
                    cell?.isUserSelected = false
                    cell?.selectionButton.isSelected = false
                    
                }else{
                    cell?.isUserSelected = true
                    cell?.selectionButton.isSelected = true
                }
                
                
                
            }
            
        }else{
            var isSelected = false
            for obj in cellSelectionArr {
                if isEqualTeamModel(obj1: obj, obj2: leagueSectionArr[indexPath.section].teamsArr[indexPath.row]) {
                    //contains
                    isSelected = true
                }
            }
            if isSelected == false {
                cell?.isUserSelected = false
                cell?.selectionButton.isSelected = false
                
            }else{
                cell?.isUserSelected = true
                cell?.selectionButton.isSelected = true
            }
            
        }
        
        cell?.setUpView(model: leagueSectionArr[indexPath.section].teamsArr[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MultiSelectHeaderView") as? MultiSelectHeaderView
        headerView!.delegate = self
        headerView!.sectionNumber = section
        var containsFlag = false
        for obj in selectionHeaderArr {
            if isEqualLeagueModel(obj1: obj, obj2: leagueSectionArr[section]){
                //contains
                containsFlag = true
            }
        }
        if containsFlag == true {
            headerView?.isUserChecked = true
        }else{
            headerView?.isUserChecked = false
        }
        
        
        headerView!.setupView(leagueModel:leagueSectionArr[section])
        return headerView!
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var containsFlag = false
        if cellSelectionArr.count > 0 {
            
            
            for (index,obj) in cellSelectionArr.enumerated() {
                if isEqualTeamModel(obj1: obj, obj2: leagueSectionArr[indexPath.section].teamsArr[indexPath.row]) {
                    //contains
                    containsFlag = true
                    cellSelectionArr.remove(at: index)
                    break
                }else{
                    //doesnt contain
                }
            }
            
            if containsFlag == false {
                //add
                cellSelectionArr.append(leagueSectionArr[indexPath.section].teamsArr[indexPath.row])
            }
            
            var isNotFullFlag = false
            //check for all cell in the section
            for obj in leagueSectionArr[indexPath.section].teamsArr {
                
                if cellSelectionArr.contains(where: { (model) -> Bool in
                    return isEqualTeamModel(obj1: model, obj2: obj)
                }) {
                    //contains
                    
                }else{
                    isNotFullFlag = true
                    
                }
                
            }
            
            
            if isNotFullFlag == false {
                //select the header
                var containsFlag = false
                var preModel = LeagueModel()
                if selectionHeaderArr.count > 0 {
                    for obj in selectionHeaderArr {
                        
                        if isEqualLeagueModel(obj1: obj, obj2:leagueSectionArr[indexPath.section]){
                            containsFlag = true
                            preModel = obj
                            break
                        }
                    }
                    
                    if containsFlag == false {
                        selectionHeaderArr.append(leagueSectionArr[indexPath.section])
                    }else{
                        //remove
                        let idx = selectionHeaderArr.index(where: { (model) -> Bool in
                            return isEqualLeagueModel(obj1: model, obj2: preModel)
                        })
                        selectionHeaderArr.remove(at: idx!)
                    }
                    
                }else{
                    
                    //append
                    selectionHeaderArr.append(leagueSectionArr[indexPath.section])
                    
                }
            }else{
                //check if already in header arr and remove
                //remove
                for obj in selectionHeaderArr {
                    if isEqualLeagueModel(obj1: obj, obj2: leagueSectionArr[indexPath.section]){
                        //contains
                        //remove
                        let idx = selectionHeaderArr.index(where: { (model) -> Bool in
                            return isEqualLeagueModel(obj1: model, obj2: obj)
                        })
                        selectionHeaderArr.remove(at: idx!)
                        
                    }
                }
            }
            
        }else{
            
            //add
            cellSelectionArr.append(leagueSectionArr[indexPath.section].teamsArr[indexPath.row])
            //check for header selection
            var isNotFullFlag = false
            //check for all cell in the section
            for obj in leagueSectionArr[indexPath.section].teamsArr {
                
                if cellSelectionArr.contains(where: { (model) -> Bool in
                    return isEqualTeamModel(obj1: model, obj2: obj)
                }) {
                    //contains
                    
                }else{
                    isNotFullFlag = true
                    
                }
                
            }
            
            
            if isNotFullFlag == false {
                //select the header
                var containsFlag = false
                var preModel = LeagueModel()
                if selectionHeaderArr.count > 0 {
                    for obj in selectionHeaderArr {
                        
                        if isEqualLeagueModel(obj1: obj, obj2:leagueSectionArr[indexPath.section]){
                            containsFlag = true
                            preModel = obj
                            break
                        }
                    }
                    
                    if containsFlag == false {
                        selectionHeaderArr.append(leagueSectionArr[indexPath.section])
                    }else{
                        //remove
                        let idx = selectionHeaderArr.index(where: { (model) -> Bool in
                            return isEqualLeagueModel(obj1: model, obj2: preModel)
                        })
                        selectionHeaderArr.remove(at: idx!)
                    }
                    
                }else{
                    
                    //append
                    selectionHeaderArr.append(leagueSectionArr[indexPath.section])
                    
                }
            }else{
                //check if already in header arr and remove
                //remove
                for obj in selectionHeaderArr {
                    if isEqualLeagueModel(obj1: obj, obj2: leagueSectionArr[indexPath.section]){
                        //contains
                        //remove
                        //remove
                        let idx = selectionHeaderArr.index(where: { (model) -> Bool in
                            return isEqualLeagueModel(obj1: model, obj2: obj)
                        })
                        selectionHeaderArr.remove(at: idx!)
                        
                    }
                }
            }
            
            
        }
        multiTable.reloadData()
        if cellSelectionArr.count <= 1 {
            customNav.topItem?.title = "\(cellSelectionArr.count) Team selected"
            
        }else{
            customNav.topItem?.title = "\(cellSelectionArr.count) Teams selected"
            
        }
    }
    
    
}
extension MultiApprovalController:sectionTappedDelegate {
    
    func sectionSelectAction(section: Int) {
        var containsFlag = false
        var preModel = LeagueModel()
        if selectionHeaderArr.count > 0 {
            for obj in selectionHeaderArr {
                
                if isEqualLeagueModel(obj1: obj, obj2:leagueSectionArr[section]){
                    containsFlag = true
                    preModel = obj
                    break
                }
            }
            
            if containsFlag == false {
                //append
                selectionHeaderArr.append(leagueSectionArr[section])
                
                for cells in leagueSectionArr[section].teamsArr{
                    if cellSelectionArr.count > 0 {
                        //check for already
                        //if not in there already
                        var addorNotFlag = false
                        for containedCells in cellSelectionArr {
                            
                            if isEqualTeamModel(obj1: cells, obj2: containedCells){
                                //already contained do nothing
                            }else{
                                addorNotFlag = true
                            }
                        }
                        if addorNotFlag == true {
                            //check if already in cellselectionArr
                            var toAdd = false
                            if cellSelectionArr.contains(where: { (model) -> Bool in
                                return isEqualTeamModel(obj1: model, obj2: cells)
                            }){
                                toAdd = true
                                
                            }
                            
                            if toAdd == false{
                                cellSelectionArr.append(cells)
                            }
                        }
                    }else{
                        //emoty just add
                        //if not in there already
                        cellSelectionArr.append(cells)
                    }
                    
                    
                }
            }else{
                
                
                //remove from header arr
                let idx = selectionHeaderArr.index(where: { (model) -> Bool in
                    return isEqualLeagueModel(obj1: model, obj2: preModel)
                })
                if idx != nil {
                    selectionHeaderArr.remove(at: idx!)
                }
                
                //remove cells
                
                // find header from selection
                //map it to trademodel [section]
                
                
                for models in leagueSectionArr[section].teamsArr {
                    //current selection's cells
                    for cells in cellSelectionArr {
                        
                        if isEqualTeamModel(obj1: models, obj2: cells){
                            //contains
                            //remove
                            let idx = cellSelectionArr.index(where: { (model) -> Bool in
                                return isEqualTeamModel(obj1: model, obj2: cells)
                            })
                            if idx != nil {
                                cellSelectionArr.remove(at: idx!)
                            }
                        }else{
                            
                            
                        }
                    }
                    
                    
                }
                
                
            }
            
        }else{
            
            //append header
            selectionHeaderArr.append(leagueSectionArr[section])
            for cells in leagueSectionArr[section].teamsArr{
                //appende cells
                if cellSelectionArr.count > 0 {
                    //check for already
                    //if not in there already
                    var addorNotFalg = false
                    for containedCells in cellSelectionArr {
                        
                        if isEqualTeamModel(obj1: cells, obj2: containedCells){
                            //already contained do nothing
                            addorNotFalg = true
                        }else{
                            
                        }
                    }
                    
                    if addorNotFalg == false {
                        cellSelectionArr.append(cells)
                    }
                    
                }else{
                    //emoty just add
                    //if not in there already
                    cellSelectionArr.append(cells)
                }
                
                
            }
            
        }
        
        multiTable.reloadData()
        if cellSelectionArr.count <= 1 {
            customNav.topItem?.title = "\(cellSelectionArr.count) Team selected"
            
        }else{
            customNav.topItem?.title = "\(cellSelectionArr.count) Teams selected"
            
        }
        
    }
    
}

func isEqualTeamModel(obj1: TeamModel,obj2: TeamModel) -> Bool{
    if obj1.teamValue == obj2.teamValue && obj1.teamName == obj2.teamName && obj1.founded == obj2.founded {
        return true
    }else{
        return false
    }
    
}

func isEqualLeagueModel(obj1: LeagueModel,obj2: LeagueModel) -> Bool{
    if obj1.leagueName == obj2.leagueName && obj1.founded == obj2.founded && obj1.headquarters == obj2.headquarters && obj1.matches == obj2.matches && obj1.teamsArr.count == obj2.teamsArr.count  {
        return true
    }else{
        return false
    }
    
}


