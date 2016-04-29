

import UIKit
import CloudKit

class EventDetails: UIViewController {

    /* Views */
    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var eventTxt: UITextView!
    @IBOutlet var eventDateLabel: UILabel!
    
    
    /* Variables */
    var eventObj = CKRecord(recordType: EVENTS_CLASS_NAME)
    
    
    
override func viewDidLoad() {
        super.viewDidLoad()

    self.title = "Event Details"
    
    /*
    // Get Event details
    let imageFile = eventObj[EVENTS_IMAGE] as? CKAsset
    if imageFile != nil { eventImage.image = UIImage(contentsOfFile: imageFile!.fileURL.path!) }
    */
    eventNameLabel.text = "ACTIVE DUTY DISCOUNT"
    eventDateLabel.text = "24/7/365"
    eventTxt.text = "To show out appreciation for all active duty personnel, we'd like to extended our gratitude with this 10% discounts"
    
    resetScrollView()
    
}

func resetScrollView() {
    eventTxt.font = UIFont(name: "HelveticaNeue-Thin", size: 14)
    eventTxt.textColor = UIColor.whiteColor()
    eventTxt.sizeToFit()
        
    containerScrollView.contentSize = CGSizeMake(containerScrollView.frame.size.width, eventTxt.frame.origin.y + eventTxt.frame.size.height + 50)
}
    
    
    
    
    
    
    
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
