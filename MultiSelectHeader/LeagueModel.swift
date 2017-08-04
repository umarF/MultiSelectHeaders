
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

struct LeagueModel {
    
    var leagueName: String =  ""
    var teams: String =  ""
    var matches: String =  ""
    var headquarters: String =  ""
    var founded: String =  ""
    var teamsArr: [TeamModel] = [TeamModel]()
    
    // MARK : TODO Check if nil is 0 or something else
    mutating func setEmptyObject() -> LeagueModel {
        self.leagueName = ""
        self.teams = ""
        self.matches = ""
        self.headquarters = ""
        self.founded = ""
        return self
    }
    mutating func setLeague(returnDict: [String:Any]) -> LeagueModel {
        self.leagueName = returnDict["leagueName"] as? String ?? ""
        self.teams = returnDict["teams"] as? String ?? ""
        self.matches = returnDict["matches"] as? String ?? ""
        self.headquarters = returnDict["headquarters"] as? String ?? ""
        self.founded = returnDict["founded"] as? String ?? ""
        return self
    }
    
    mutating func setChildArray(arr:[TeamModel]) -> LeagueModel {
        self.teamsArr = arr
        return self
    }
    
    
}
