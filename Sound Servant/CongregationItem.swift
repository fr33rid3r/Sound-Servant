
import Foundation

class CongregationItem: NSObject, NSCoding {
    var text = ""
    var password = ""
    var publictalk = ""
    var bookstudy = ""
    
    
    // Save
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeObject(password, forKey: "Password")
        aCoder.encodeObject(publictalk, forKey: "PublicTalk")
        aCoder.encodeObject(bookstudy, forKey: "BookStudy")
    }
    
    // Load
    
    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as! String
        password = aDecoder.decodeObjectForKey("Password") as! String
        publictalk = aDecoder.decodeObjectForKey("PublicTalk") as! String
        bookstudy = aDecoder.decodeObjectForKey("BookStudy") as! String
        super.init()
    }
    
    
    override init() {
        super.init()
    }
  
}