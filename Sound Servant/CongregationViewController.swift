
import UIKit

class CongregationViewController: UITableViewController, CongregationDetailViewControllerDelegate {
    
    var items: [CongregationItem]
    
    required init(coder aDecoder: NSCoder) {
        items = [CongregationItem]()
        super.init(coder: aDecoder)
      println("Documents folder is \(documentsDirectory())")
      println("Data file path is \(dataFilePath())")
        loadCongregationItems()
      
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as! [String]
        return paths[0]
    }
    
    
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingPathComponent("Checklists.plist")
    }
    
    
    func configureTextForCell(cell: UITableViewCell, withCongregationItem item: CongregationItem) {
        cell.textLabel!.text = item.text
        cell.detailTextLabel!.text = item.password
      
    }
    
    
    func loadCongregationItems() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                items = unarchiver.decodeObjectForKey("CongregationItems") as! [CongregationItem]
                unarchiver.finishDecoding()
            }
        }
    }
    
    
    func saveCongregationItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(items, forKey: "CongregationItems")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
  
  
  
  
  
  
  
  
  
  
  
  // MARK: ⭐️ CongregationDetailViewController Delegate Methods ⭐️
  func congregationDetailViewControllerDidCancel(controller: CongregationDetailViewController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func congregationDetailViewController(controller: CongregationDetailViewController, didFinishAddingItem item: CongregationItem) {
    let newRowIndex = items.count
    
    items.append(item)
    
    let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
    let indexPaths = [indexPath]
    tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    
    dismissViewControllerAnimated(true, completion: nil)
    
    saveCongregationItems()
  }
  
  func congregationDetailViewController(controller: CongregationDetailViewController, didFinishEditingItem item: CongregationItem) {
    if let index = find(items, item) {
    let indexPath = NSIndexPath(forRow: index, inSection: 0)
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
    configureTextForCell(cell, withCongregationItem: item)
    }
    }
    dismissViewControllerAnimated(true, completion: nil)
      
      saveCongregationItems()
  }
  
  override func tableView(tableView: UITableView,
    commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
      
      items.removeAtIndex(indexPath.row)
      
      let indexPaths = [indexPath]
      tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
      
      saveCongregationItems()
  }
  
 
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  
  if segue.identifier == "AddItem" {
    
    let navigationController = segue.destinationViewController as! UINavigationController
    let controller = navigationController.topViewController as! CongregationDetailViewController
    
    controller.delegate = self
  
  } else if segue.identifier == "EditItem" {
    
    let navigationController = segue.destinationViewController as! UINavigationController
    let controller = navigationController.topViewController as! CongregationDetailViewController
  
    controller.delegate = self
    
    if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
    
      controller.itemToEdit = items[indexPath.row]
    }
  }
  
  }

  
  // MARK: ⭐️ tableView Delegate Methods ⭐️
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      let item = items[indexPath.row]
      }
    
  tableView.deselectRowAtIndexPath(indexPath, animated: true)

  }
  
  
  // MARK: ⭐️ Data Source Methods ⭐️
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return items.count
  }
  
  override func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
      let cell = tableView.dequeueReusableCellWithIdentifier("CongregationItem") as! UITableViewCell
      let item = items[indexPath.row]

    configureTextForCell(cell, withCongregationItem: item)
    
      return cell
  }
  
}

