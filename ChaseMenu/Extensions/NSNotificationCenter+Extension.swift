import Foundation

extension NSNotificationCenter {
    
    class func fire(name: String) {
        let nc = defaultCenter()
        nc.postNotificationName(name, object: nil)
    }
    
    class func postNotificationName(name: String, userInfo: [NSObject : AnyObject]?) {
        let nc = defaultCenter()
        nc.postNotificationName(name, object: nil, userInfo: userInfo)
    }
    
}