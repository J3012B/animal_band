import UIKit

public class SongEditorView: UIView {
    
    public var bandScene: BandScene?
    private var menuBar: UIView!
    private var instrumentPicker: Picker!
    public var body: SongEditorBody!
    
    public var songSelectionView: SongSelectionView!
    public var songIsPlayingView: SongIsPlayingView!
    public var songCreationView: SongCreationView!
    
    private var currentInstrument: String = "Piano"
    private var songLength: Int = 0
    
    
    
    
    /*  INITIALIZATION  */
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(hex: "#2C3E50")
        
        self.addUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    /*
     ===================================================================
     ============================ UI Logic =============================
     */
    
    private func instrumentPickerButtonPushed() {
        self.currentInstrument = self.instrumentPicker.currentTitle
        self.body.reload(instrument: currentInstrument)
    }
    
    @objc private func loadButtonPushed() {
        self.songSelectionView.show()
    }
    
    @objc private func newButtonPushed() {
        self.songCreationView.show()
    }
    
    @objc private func saveButtonPushed() {
        self.body.songObject.save(to: titleToSaveTo)
    }
    
    @objc private func clearButtonPushed() {
        for (instrument, _) in self.body.songObject.instruments {
            self.body.songObject.instruments[instrument] = []
        }
        self.body.songObject.instruments["piano"]!.append(Note(pitch: "b", octave: 6, time: 240))
        self.body.reload(instrument: self.currentInstrument)
    }
    
    
    
    /*
     ===================================================================
     ========================= User Interface ==========================
     */
    
    private func addUI() {
        self.addMenuBar()
        self.addBody()
        self.addViews()
    }
    
    /*  MENU BAR  */
    
    private func addMenuBar() {
        
        /* Add actual menu bar */
        let menuBarFrame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height * 0.2)
        menuBar = UIView(frame: menuBarFrame)
        
        menuBar.backgroundColor = UIColor(hex: "#566573")
        
        self.addSubview(menuBar)
        
        /* Add Children */
        
        let padding: CGFloat = 0.2 * menuBar.frame.height
        let buttonWidth: CGFloat = menuBar.frame.height - 2 * padding
        
        /* Add Instrument Picker */
        let instrumentPickerFrame = CGRect(x: padding, y: padding, width: frame.width * 0.3, height: menuBar.frame.height - 2 * padding)
        let instrumentPickerTitles = ["Piano", "Guitar", "Cello", "Drums"]
        instrumentPicker = Picker(frame: instrumentPickerFrame, titles: instrumentPickerTitles, action: instrumentPickerButtonPushed)
        
        self.menuBar.addSubview(instrumentPicker)
        
        /*
        /* Add New Button */
        let newButton = UIButton(frame: CGRect(x: menuBar.frame.width - padding - buttonWidth, y: padding,
                                               width: buttonWidth, height: buttonWidth))
        newButton.addTarget(self, action: #selector(newButtonPushed), for: .touchUpInside)
        newButton.setImage(UIImage(named: "Menu/Song_Buttons/newButton.png"), for: .normal)
 */
        
        /* Add Load Button */
        let loadButton = UIButton(frame: CGRect(x: menuBar.frame.width - padding - buttonWidth, y: padding,
                                                width: buttonWidth, height: buttonWidth))
        loadButton.addTarget(self, action: #selector(loadButtonPushed), for: .touchUpInside)
        loadButton.setImage(UIImage(named: "Menu/Song_Buttons/loadButton.png"), for: .normal)
        
        /* Add Save Button */
        let saveButton = UIButton(frame: CGRect(x: loadButton.frame.minX - 2 * padding - buttonWidth, y: padding,
                                                width: buttonWidth, height: buttonWidth))
        saveButton.addTarget(self, action: #selector(saveButtonPushed), for: .touchUpInside)
        saveButton.setImage(UIImage(named: "Menu/Song_Buttons/saveButton.png"), for: .normal)
        
        /* Add Clear Button */
        let clearButton = UIButton(frame: CGRect(x: saveButton.frame.minX - 2 * padding - buttonWidth, y: padding, width: buttonWidth, height: buttonWidth))
        clearButton.addTarget(self, action: #selector(clearButtonPushed), for: .touchUpInside)
        clearButton.setImage(UIImage(named: "Menu/Song_Buttons/clearButton.png"), for: .normal)
        
        
        self.menuBar.addSubview(loadButton)
        self.menuBar.addSubview(saveButton)
        self.menuBar.addSubview(clearButton)
        //self.menuBar.addSubview(newButton)
    }
    
    /*  BODY  */
    
    private func addBody() {
        let bodyFrame = CGRect(x: 0.0, y: menuBar.frame.maxY, width: frame.width, height: frame.height - menuBar.frame.height)
        
        body = SongEditorBody(frame: bodyFrame, instrument: self.currentInstrument)
        
        self.addSubview(body)
    }
    
    /* VIEWS */
    private func addViews() {
        /* Song is playing View */
        songIsPlayingView = SongIsPlayingView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        songIsPlayingView.setText("This is the Song Name")
        songIsPlayingView.userCanRemove = false
        songIsPlayingView.isHidden = true
        
        /* Song Selection View */
        songSelectionView = SongSelectionView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
        songSelectionView.songEditorView = self
        
        /* Song Create View */
        songCreationView = SongCreationView(frame: songIsPlayingView.frame)
        songCreationView.isHidden = true
        
        self.addSubview(songIsPlayingView)
        self.addSubview(songSelectionView)
        self.addSubview(songCreationView)
    }
    
}

