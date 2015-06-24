//  ViewController.swift
//  plistVer2HW
//
//  Created by Richard H Woolley on 6/22/15.
//  Copyright (c) 2015 Bright Quasar Software, R.Woolley.

import UIKit
/*
class ViewController: UIViewController, UITableViewDataSource {
  @IBOutlet weak var tableView: UITableView!
  var people = [Person]()
  var myInfo = [String : Person]()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.loadPeopleFromPlist()  // first func below
    self.tableView.dataSource = self  // per protocol
  }

// Here we get our people data, by calling pathForResource on our bundle, casting it as an array of dictionaries
// parsing the array of dictionaries, and appending each person.
  private func loadPeopleFromPlist() {
    if let peoplePath = NSBundle.mainBundle().pathForResource("People", ofType: "plist"),
      peopleObjects = NSArray(contentsOfFile: peoplePath) as? [[String: String]]  // chaining of optional bindings.
    {
      for object in peopleObjects {  // loop through the data from the plist (an array of dictionaries)
        if let firstName = object["FirstName"], lastName = object["LastName"]/*, image = object["Image"]*/ {  // more comma-separated optional binding
            let person = Person(first: firstName, last: lastName/*, image*/)  // create an instance of Person
            self.people.append(person)    // add that person to people (an instance var of type array of Persons
        }
      }
    }
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView.reloadData()  // same short-version, finds datasource above via tableView protocol
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.people.count
  }

/* ***** finally replaced this with code below, though this version I am more confident in
// same deque as before, trying safer version below ... not getting it to work, not yet understanding how the else fixes issue
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PersonCell
    let personToDisplay = self.people[indexPath.row]

    if let image = personToDisplay.image {  // optional binding of ... people[indexPath.row]
      cell.personImageView.image = image  // cell is from iffy forced downcast (an optional??)
    }
    cell.firstNameLabel.text = personToDisplay.firstName  // these go into the tableView cells
    cell.lastNameLabel.text = personToDisplay.lastName
    return cell
  }
*/

/*
 // Will ask Brad to look over this construct ??? I tried (darkly) many forms of this thing.
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? PersonCell { // drop self.
      let personToDisplay = people[indexPath.row] // drop self.
      if let image = personToDisplay.image {
        cell.personImageView.image = image
      }
      //cell.textLabel?.text = personToDisplay.firstName! + " " + personToDisplay.lastName
      cell.firstNameLabel.text = personToDisplay.firstName
      cell.lastNameLabel.text = personToDisplay.lastName
      return cell
    } else {
      let let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? PersonCell
      let personToDisplay = people[indexPath.row]

      let image = personToDisplay.image
      cell.personImageView.image = image

      let personsFistname = personToDisplay.firstName
        cell.textLabel?.text = personToDisplay.firstName! + " " + personToDisplay.lastName
        cell.firstNameLabel.text = personToDisplay.firstName
        cell.lastNameLabel.text = personToDisplay.lastName
      return cell
  }
*/

/*  Got this from Brad on slack

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? UITableViewCell {
      let personToDisplay = people[indexPath.row]
      if let personsFistname = personToDisplay.firstName {
        cell.textLabel?.text = personToDisplay.firstName! + " " + personToDisplay.lastName
      }
      return cell
    } else {
      let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
      let personToDisplay = people[indexPath.row]
      if let personsFistname = personToDisplay.firstName {
        cell.textLabel?.text = personToDisplay.firstName! + " " + personToDisplay.lastName
      }
      return cell
    }
  }
*/ // Try again with only PersonCell line changed, well...then, deleted some "unaceptable" lines too. Now Xcode likes it. 

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PersonCell
      let personToDisplay = self.people[indexPath.row]
        if let image = personToDisplay.image {  // optional binding of ... people[indexPath.row]
          cell.personImageView.image = image  // cell is from iffy forced downcast (an optional??)
        }
      cell.firstNameLabel.text = personToDisplay.firstName  // these go into the tableView cells
      cell.lastNameLabel.text = personToDisplay.lastName
      return cell
/*
    } else {
      let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PersonCell
      //let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell") // still crashes!
      let personToDisplay = people[indexPath.row]
      return cell
    }
*/
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowDetailViewController" {
      if let detailViewController = segue.destinationViewController as? DetailViewController, let myIndexPath = self.tableView.indexPathForSelectedRow(), let indexPath = self.tableView.indexPathForSelectedRow() {
            let selectedRow = indexPath.row
            let selectedPerson = self.people[selectedRow]
              println(selectedPerson.firstName)
            detailViewController.selectedPerson = selectedPerson
      }  // end of comma-separated chained optional binding
    }
  }

}
*/

class ViewController: UIViewController, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!

  var people = [Person]()
  var myInfo = [String : Person]()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.loadPeopleFromPlist()

    self.tableView.dataSource = self

  }

  private func loadPeopleFromPlist() {

    if let peoplePath = NSBundle.mainBundle().pathForResource("People", ofType: "plist"),
      peopleObjects = NSArray(contentsOfFile: peoplePath) as? [[String : String]]
    {
      for object in peopleObjects {

        if let firstName = object["FirstName"],
          lastName = object["LastName"] {
            let person = Person(first: firstName, last: lastName)
            self.people.append(person)
        }
      }
    }
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView.reloadData()
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.people.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PersonCell
    let personToDisplay = self.people[indexPath.row]

    //with optional binding
    if let image = personToDisplay.image {
      cell.personImageView.image = image
    }

    cell.firstNameLabel.text = personToDisplay.firstName
    cell.lastNameLabel.text = personToDisplay.lastName


    return cell
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowDetailViewController" {

      if let detailViewController = segue.destinationViewController as? DetailViewController {

        let myIndexPath = self.tableView.indexPathForSelectedRow()

        if let indexPath = self.tableView.indexPathForSelectedRow() {

          let selectedRow = indexPath.row
          let selectedPerson = self.people[selectedRow]
          println(selectedPerson.firstName)
          detailViewController.selectedPerson = selectedPerson
          // detailViewController.setupTextFields()
        }
        
      }
    }
  }
  
}

