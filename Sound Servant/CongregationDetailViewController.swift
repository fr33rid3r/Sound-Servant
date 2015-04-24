
import UIKit

protocol CongregationDetailViewControllerDelegate: class {
    func congregationDetailViewControllerDidCancel(controller: CongregationDetailViewController)
    func congregationDetailViewController(controller: CongregationDetailViewController, didFinishAddingItem item: CongregationItem)
    func congregationDetailViewController(controller: CongregationDetailViewController, didFinishEditingItem item: CongregationItem)
}

class CongregationDetailViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: ⭐️ Instance variables ⭐️
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var bookstudyField: UITextField!
    @IBOutlet weak var publictalkField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: CongregationDetailViewControllerDelegate?
    var itemToEdit: CongregationItem?
    
    // MARK: ⭐️  ⭐️
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        
        if let item = itemToEdit {
            title = "Edit Congregation"
            textField.text = item.text
            passwordField.text = item.password
            bookstudyField.text = item.bookstudy
            publictalkField.text = item.publictalk
            doneBarButton.enabled = true
        }
    }
    
    
    @IBAction func cancel() {
        
        delegate?.congregationDetailViewControllerDidCancel(self)
    }
    
    
    @IBAction func done() {
        
        if let item = itemToEdit {
            item.text = textField.text
            item.password = passwordField.text
            item.bookstudy = bookstudyField.text
            item.publictalk = publictalkField.text
          
            delegate?.congregationDetailViewController(self, didFinishEditingItem: item)
        } else {
            let item = CongregationItem()
            item.text = textField.text
            item.password = passwordField.text
            item.bookstudy = bookstudyField.text
            item.publictalk = publictalkField.text
        
            delegate?.congregationDetailViewController(self, didFinishAddingItem: item)
        }
    }
    
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        let oldText: NSString = textField.text
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneBarButton.enabled = (newText.length > 0)
        
        return true
    }
    
    
    
    
    
    
    
    
    
}