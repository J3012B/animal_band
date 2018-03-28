import UIKit

/* This class is a UIView with a dark transparent background */

public class UIViewLayer: UIView {
    
    /*  INITIALIZATION  */
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addElements()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    private func addElements() {
        /* Add Background Layer */
        self.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
    }
    
}
