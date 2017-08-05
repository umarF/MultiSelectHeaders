# MultiSelectHeaders
A simple and robust implementation of having a multi select header along with selectable cells for various implementation in iOS.




![Walkthrough](https://github.com/umarF/MultiSelectHeaders/blob/master/walkthrough.gif)


# Just change the Models as per your need.


In the example, section header are populated by the League model, and cells are populated by the Team Model.
The important point to note when modifying is that, League Model (used for Header View) should contain the array of cells within as a property (TeamsArr is an array of Team Model that is contained as a property in League Model object).
