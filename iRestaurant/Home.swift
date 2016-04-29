
import UIKit
import CloudKit


class Home: UIViewController {

    /* Views */
    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descrTxt: UITextView!
    
    
    /* Variables */
    var restArray = NSMutableArray()
    var fbLink = ""
    var twLink = ""
    var taLink = ""
    var inLink = ""
    
    

override func viewDidLoad() {
        super.viewDidLoad()
        restArray = [" "]
    // Setup layout at startup
    logoImage.layer.cornerRadius = logoImage.bounds.size.width/2
    self.automaticallyAdjustsScrollViewInsets = false

    showDetails()
    //queryRestData()
}
    
//QUERY RESTAURANT DATA FROM THE DATABASE
func queryRestData() {
    //showHUD()
    
    let predicate = NSPredicate(value: true)
    let query = CKQuery(recordType: RESTAURANT_CLASS_NAME, predicate: predicate)
    
    publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
        if error == nil { dispatch_async(dispatch_get_main_queue()) {
            self.restArray = NSMutableArray(array: results!)
            self.showDetails()
            self.hideHUD()
        // Error
        }} else { dispatch_async(dispatch_get_main_queue()) {
            self.simpleAlert("\(error!.localizedDescription)")
            self.hideHUD()
        } } }

}
func showDetails() {
    let restClass = restArray[0]
    
    // Get name
    nameLabel.text = "China King"
    
    // Get description
    descrTxt.text = "                                 Authentic Chinese Cuisine"
    resetScrollView()
    
    // Get social links
    if restClass[RESTAURANT_FACEBOOK] != nil    { fbLink = "\(restClass[RESTAURANT_FACEBOOK]!)"     }
    if restClass[RESTAURANT_TWITTER] != nil     { twLink = "\(restClass[RESTAURANT_TWITTER]!)"      }
    if restClass[RESTAURANT_TRIPADVISOR] != nil { taLink = "\(restClass[RESTAURANT_TRIPADVISOR]!)"  }
    if restClass[RESTAURANT_INSTAGRAM] != nil   { inLink = "\(restClass[RESTAURANT_INSTAGRAM]!)"    }

    // Get logo
    let imageFile = restClass[RESTAURANT_LOGO] as? CKAsset
    if imageFile != nil { logoImage.image = UIImage(contentsOfFile: imageFile!.fileURL.path!)  }
        
    
    // Get cover image
    let coverFile = restClass[RESTAURANT_COVER_IMAGE] as? CKAsset
    if coverFile != nil { coverImage.image = UIImage(contentsOfFile: coverFile!.fileURL.path!) }
    
}
    
    
// RESET SCROLL VIEW
func resetScrollView() {
    descrTxt.font = UIFont(name: "HelveticaNeue-Thin", size: 14)
    descrTxt.textColor = UIColor.whiteColor()
    descrTxt.sizeToFit()
    
    containerScrollView.contentSize = CGSizeMake(containerScrollView.frame.size.width, descrTxt.frame.origin.y + descrTxt.frame.size.height + 50)
}
    
    

//SOCIAL BUTTON TAPPED
@IBAction func socialButtTapped(sender: AnyObject) {
    var socialLink = NSURL()
    switch sender.tag {
    case 0: socialLink = NSURL(string: fbLink)!; break
    case 1: socialLink = NSURL(string: twLink)!; break
    case 2: socialLink = NSURL(string: taLink)!; break
    case 3: socialLink = NSURL(string: inLink)!; break
    default:break  }
    
    UIApplication.sharedApplication().openURL(socialLink)
}
    
    
//GALLERY BUTTON
@IBAction func galleryButt(sender: AnyObject) {
    let galVC = storyboard?.instantiateViewControllerWithIdentifier("Gallery") as! Gallery
    presentViewController(galVC, animated: true, completion: nil)
}
    
    
    
    
    
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
}

