//
//  DetailViewController.swift
//  Yogurt App
//
//  Created by Aditya on 05/05/21.
//

import UIKit

class YogurtMakerController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblSelect: UILabel!
    @IBOutlet weak var lblStarter: UILabel!
    
    @IBOutlet weak var lblHotFlask: UILabel!
    
    @IBOutlet weak var lblElectrical: UILabel!
    @IBOutlet weak var lblTraditional: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var stackViewProcess1: UIStackView!
    @IBOutlet weak var stackViewProcess2: UIStackView!
    
    @IBOutlet weak var lblHotFlaskProcess1: UILabel!
    
    @IBOutlet weak var lblElectricalProcess1: UILabel!
    
    @IBOutlet weak var viewTimer: UIView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var hieghtTimer: NSLayoutConstraint!
    @IBOutlet weak var btnTimer: UIButton!
    
    var hours: Int = 0
    var mins: Int = 0
    var secs: Int = 0
    
    public var strTitle :String = ""
    public var strSelectProcess :String = ""
    
    public var strSelectedStarterTitle :String = ""
    public var strSelectedStarterImage :String = ""
    public var strSelectedDescription :String = ""
    
    var scheduleTime : Timer?
    
    struct MilkProcess {
        
        // MARK: Properties
        
        let title: String
        let imgName: String
        let description: String
        
    }
    private let milkProcess: [MilkProcess] = [
        MilkProcess(
            
            title: "Electrical yogurt maker",
            imgName: "Electrical",
            description: "Best for speedy cultivation and recultivation"
            
        ),
        MilkProcess(
            
            title: "Flask with hot water",
            imgName: "Flask",
            description: "Ideal for cultivation and recultivation in an authentic way"
            
        ),
        MilkProcess(
            
            title: "Traditional Method",
            imgName: "Traditional",
            description: "Just wrap the jar with thick towels and place at hot spot"
            
        )
    ]
    
    //var arrayOfDictionary: [[String : AnyObject]]  = [["id" :1, "name": "Apple", "category" : "Fruit"],["id" :2, "name": "Microsoft", "category" : "Juice"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        self.tabBarController?.tabBar.isHidden = false
        
        let timerDate = Constant.userDefault.getTimerDate()
                if(timerDate == ""){
                    hieghtTimer.constant = 0
                }else{
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                    let date = dateFormatter.date(from: timerDate)
                    if(!(date == nil)){
                        let pickedDatetime = date!
                        self.didCreateEvent(name: "", targetDate: pickedDatetime)
                        switch UIDevice.current.userInterfaceIdiom {
                        case .phone:
                            hieghtTimer.constant = 40
                        // It's an iPhone
                        case .pad:
                            hieghtTimer.constant = 60
                        case .unspecified: break
                            
                        case .tv: break
                            
                        case .carPlay: break
                            
                        case .mac: break
                            
                        @unknown default: break
                        // Uh, oh! What could it be?
                        }
                    }
                  
                }

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        scheduleTime?.invalidate()
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateCellsLayout()
    }
    @objc private func applicationWillResignActive() {
        print("Resign")
    }
    
    @objc private func applicationDidBecomeActive() {
        print("Active")
        scheduleTime?.invalidate()
        let timerDate = Constant.userDefault.getTimerDate()
        if(timerDate == ""){
            hieghtTimer.constant = 0
        }else{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
            let date = dateFormatter.date(from: timerDate)
            if(!(date == nil)){
                let pickedDatetime = date!
                self.didCreateEvent(name: "", targetDate: pickedDatetime)
                switch UIDevice.current.userInterfaceIdiom {
                case .phone:
                    hieghtTimer.constant = 40
                // It's an iPhone
                case .pad:
                    hieghtTimer.constant = 60
                case .unspecified: break
                    
                case .tv: break
                    
                case .carPlay: break
                    
                case .mac: break
                    
                @unknown default: break
                // Uh, oh! What could it be?
                }
            }
            
        }
    }
    
    // MARK: - NavigationBar Methods
    
    func setUpNavigationBar()
    {
        
    }
    
    //MARK:- Functions
    func setupInitialViews() {
        
      //  self.lblTitle.font = MySingleton.sharedManager().themeFontSixteenSizeBold
      //  self.lblTitle.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        self.lblTitle.text = strTitle
      //  self.lblSelect.font = MySingleton.sharedManager().themeFontSixteenSizeBold
      //  self.lblSelect.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
        
        
      //  self.lblStarter.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        self.lblStarter.textColor = MySingleton.sharedManager().themeGlobalBlueColor
        
       // self.lblElectrical.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        self.lblElectrical.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(YogurtMakerController.tapFunction))
        lblElectrical.isUserInteractionEnabled = true
        lblElectrical.addGestureRecognizer(tap)
        
        
      //  self.lblHotFlask.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        self.lblHotFlask.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(YogurtMakerController.HotFlaskFunction))
        lblHotFlask.isUserInteractionEnabled = true
        lblHotFlask.addGestureRecognizer(tap1)
        
       // self.lblTraditional.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        self.lblTraditional.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(YogurtMakerController.TraditionalFunction))
        lblTraditional.isUserInteractionEnabled = true
        lblTraditional.addGestureRecognizer(tap2)
        
        
       // self.lblElectricalProcess1.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        self.lblElectricalProcess1.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(YogurtMakerController.tapFunction))
        lblElectricalProcess1.isUserInteractionEnabled = true
        lblElectricalProcess1.addGestureRecognizer(tap3)
        
      //  self.lblElectricalProcess1.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        self.lblElectricalProcess1.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(YogurtMakerController.HotFlaskFunction))
        lblHotFlaskProcess1.isUserInteractionEnabled = true
        lblHotFlaskProcess1.addGestureRecognizer(tap4)
        
        if(strSelectProcess == "1"){
            self.stackViewProcess1.isHidden = false
            self.stackViewProcess2.isHidden = true
        }else{
            self.stackViewProcess1.isHidden = true
            self.stackViewProcess2.isHidden = false
        }
        self.btnClose?.addTarget(self, action: #selector(self.btnClosedClicked(_:)), for: .touchUpInside)
        self.btnTimer?.addTarget(self, action: #selector(self.btnTimerClicked(_:)), for: .touchUpInside)
        
        viewConfigrations()
    }
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
        self.collectionView?.scrollToItem(at:IndexPath(item: 0, section: 0), at: [.centeredVertically,   .centeredHorizontally], animated: true)
    }
    
    @objc
    func HotFlaskFunction(sender:UITapGestureRecognizer) {
        print("2tap working")
        self.collectionView?.scrollToItem(at:IndexPath(item: 1, section: 0), at: [.centeredVertically,   .centeredHorizontally], animated: true)
    }
    
    @objc
    func TraditionalFunction(sender:UITapGestureRecognizer) {
        print("2tap working")
        self.collectionView?.scrollToItem(at:IndexPath(item: 2, section: 0), at: [.centeredVertically,   .centeredHorizontally], animated: true)
    }
    
    private func viewConfigrations() {
        
        collectionView.register(UINib(nibName: "YogurtMaker", bundle: nil), forCellWithReuseIdentifier: "YogurtMaker")
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 30, bottom: 0, right: 30)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    func updateCellsLayout()  {
        
        let centerX = collectionView.contentOffset.x + (collectionView.frame.size.width)/2
        for cell in collectionView.visibleCells {
            
            var offsetX = centerX - cell.center.x
            if offsetX < 0 {
                offsetX *= -1
            }
            cell.transform = CGAffineTransform.identity
            let offsetPercentage = offsetX / (view.bounds.width * 2.7)
            let scaleX = 1-offsetPercentage
            cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
        }
    }
    
    //MARK:- other Service
    
    @IBAction func btnClosedClicked(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func btnTimerClicked(_ sender: UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YogurtProcessViewController") as? YogurtProcessViewController
        vc?.strSelectMaker = Constant.userDefault.getSelectMaker()
        
        vc?.isBoolClickedFromTimer = true
        
//        vc?.strTitle = strTitle
//        vc?.strSelectProcess = strSelectProcess
//        vc?.strSelectedStarterTitle = milkProcess[indexPath.row].title
//        vc?.strSelectedDescription = milkProcess[indexPath.row].description
//        vc?.strSelectedStarterImage = "\(indexPath.item)"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @objc func addSelectClicked(_ sender:UIButton){
        //CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
        let buttonPosition:CGPoint = sender.convert(.zero, to: self.collectionView)
        let indexPath:IndexPath = self.collectionView.indexPathForItem(at: buttonPosition)!
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YogurtSelectedProcessViewController") as? YogurtSelectedProcessViewController
        vc?.strTitle = strTitle
        vc?.strSelectProcess = strSelectProcess
        
        vc?.strSelectedStarterTitle = strSelectedStarterTitle
        vc?.strSelectedDescription = strSelectedDescription
        vc?.strSelectedStarterImage = strSelectedStarterImage
        
        vc?.strSelectedSMakerTitle = self.milkProcess[indexPath.row].title
        vc?.strSelectedMakerImage = self.milkProcess[indexPath.row].imgName
        if(indexPath.row == 0){
            vc?.strSelectMaker = "1"
        }
        else if(indexPath.row == 1){
            vc?.strSelectMaker = "2"
        }
        else if(indexPath.row == 2){
            vc?.strSelectMaker = "3"
        }
        
        self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    
}

extension YogurtMakerController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(strSelectProcess == "1"){
            return milkProcess.count
        }else{
            return milkProcess.count - 1
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // let valie = arrayOfDictionary.values
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YogurtMaker", for: indexPath) as! YogurtMaker
        
        cell.imgProduct.image = UIImage(named: milkProcess[indexPath.row].imgName)
        
        cell.lblTitle.text = milkProcess[indexPath.row].title
        cell.lblDescription.text = milkProcess[indexPath.row].description
        //cell.btnSelect.isUserInteractionEnabled = false
        cell.btnSelect.addTarget(self, action: #selector(addSelectClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize: CGSize = collectionView.bounds.size
        
        switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                cellSize.width -= collectionView.contentInset.left * 2
                cellSize.width -= collectionView.contentInset.right * 2
                cellSize.height = cellSize.width + 170
                // It's an iPhone
        case .pad:
            print(UIScreen.main.bounds.size.height)
            if(UIScreen.main.bounds.size.height == 1024) {
               
                // iPad pro (or hypothetical/future huge-screened iOS device)
            }
            
            cellSize.width = 650
            cellSize.height = 650
                // It's an iPad (or macOS Catalyst)

        case .unspecified: break
            
        case .tv: break
            
        case .carPlay: break
            
        case .mac: break
            
        @unknown default: break
                // Uh, oh! What could it be?
            }
       
       // return cellSize
        return cellSize
        // return  UITableViewAutomaticDimension
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YogurtSelectedProcessViewController") as? YogurtSelectedProcessViewController
        vc?.strTitle = strTitle
        vc?.strSelectProcess = strSelectProcess
        
        vc?.strSelectedStarterTitle = strSelectedStarterTitle
        vc?.strSelectedDescription = strSelectedDescription
        vc?.strSelectedStarterImage = strSelectedStarterImage
        
        vc?.strSelectedSMakerTitle = self.milkProcess[indexPath.row].title
        vc?.strSelectedMakerImage = self.milkProcess[indexPath.row].imgName
        if(indexPath.row == 0){
            vc?.strSelectMaker = "1"
        }
        else if(indexPath.row == 1){
            vc?.strSelectMaker = "2"
        }
        else if(indexPath.row == 2){
            vc?.strSelectMaker = "3"
        }
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCellsLayout()
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let indexPath = collectionView.indexPathForItem(at: visiblePoint)
        print(indexPath?.row as Any)
        if(indexPath?.row  == 0  ){
            lblElectrical.attributedText = NSAttributedString(string: "ELECTRICAL", attributes:
                                                                [.underlineStyle: NSUnderlineStyle.single.rawValue])
            lblElectrical.textColor = MySingleton.sharedManager().themeGlobalBlueColor
          //  lblElectrical.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblHotFlask.attributedText = NSAttributedString(string: "HOT FLASK", attributes:
                                                                [.underlineStyle: 0])
            lblHotFlask.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
           // lblHotFlask.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblTraditional.attributedText = NSAttributedString(string: "TRADITIONAL", attributes:
                                                                [.underlineStyle: 0])
            lblTraditional.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
           // lblTraditional.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblElectricalProcess1.attributedText = NSAttributedString(string: "ELECTRICAL", attributes:
                                                                        [.underlineStyle: NSUnderlineStyle.single.rawValue])
            lblElectricalProcess1.textColor = MySingleton.sharedManager().themeGlobalBlueColor
           // lblElectricalProcess1.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblHotFlaskProcess1.attributedText = NSAttributedString(string: "HOT FLASK", attributes:
                                                                        [.underlineStyle: 0])
            lblHotFlaskProcess1.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
           // lblHotFlaskProcess1.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
        }
        else if(indexPath?.row == 1){
            lblHotFlask.attributedText = NSAttributedString(string: "HOT FLASK", attributes:
                                                                [.underlineStyle: NSUnderlineStyle.single.rawValue])
            lblHotFlask.textColor = MySingleton.sharedManager().themeGlobalBlueColor
           // lblHotFlask.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblElectrical.attributedText = NSAttributedString(string: "ELECTRICAL", attributes:
                                                                [.underlineStyle: 0])
            lblElectrical.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
          //  lblElectrical.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblTraditional.attributedText = NSAttributedString(string: "TRADITIONAL", attributes:
                                                                [.underlineStyle: 0])
            lblTraditional.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
          // lblTraditional.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblHotFlaskProcess1.attributedText = NSAttributedString(string: "HOT FLASK", attributes:
                                                                        [.underlineStyle: NSUnderlineStyle.single.rawValue])
            lblHotFlaskProcess1.textColor = MySingleton.sharedManager().themeGlobalBlueColor
            //lblHotFlaskProcess1.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblElectricalProcess1.attributedText = NSAttributedString(string: "ELECTRICAL", attributes:
                                                                        [.underlineStyle: 0])
            lblElectricalProcess1.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
           // lblElectricalProcess1.font = MySingleton.sharedManager().themeFontFourteenSizeBold
        }
        
        else if(indexPath?.row == 2 ){
            lblTraditional.attributedText = NSAttributedString(string: "TRADITIONAL", attributes:
                                                                [.underlineStyle: NSUnderlineStyle.single.rawValue])
            lblTraditional.textColor = MySingleton.sharedManager().themeGlobalBlueColor
          //  lblTraditional.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblElectrical.attributedText = NSAttributedString(string: "ELECTRICAL", attributes:
                                                                [.underlineStyle: 0])
            lblElectrical.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
           // lblElectrical.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblHotFlask.attributedText = NSAttributedString(string: "HOT FLASK", attributes:
                                                                [.underlineStyle: 0])
            lblHotFlask.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
           // lblHotFlask.font = MySingleton.sharedManager().themeFontFourteenSizeBold
        }
    }
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //
    //    }
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //        for cell in collectionView.visibleCells {
    //            let indexPath = collectionView.indexPath(for: cell)
    //            print(indexPath!.row)
    //        }
    //
    //
    //    }
    
}
class UnderlinedLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}
//Timer
extension YogurtMakerController{
    
    private func didCreateEvent(name: String, targetDate: Date) {
        self.title = name
        let difference = floor(targetDate.timeIntervalSince(Date()))
        if difference > 0.0 {
            let computedHours: Int = Int(difference) / 3600
            let remainder: Int = Int(difference) - (computedHours * 3600)
            let minutes: Int = remainder / 60
            let seconds: Int = Int(difference) - (computedHours * 3600) - (minutes * 60)

            print("\(computedHours) \(minutes) \(seconds)")
            hours = computedHours
            mins = minutes
            secs = seconds

            updateLabel()

            startTimer()
        }
        else {
            Constant.userDefault.setTimerDate(value: "")
            DispatchQueue.main.async {
                self.hieghtTimer.constant = 0
               }
            print("negative interval")
        }
    }

    private func startTimer() {
        scheduleTime = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.secs > 0 {
                self.secs = self.secs - 1
            }
            else if self.mins > 0 && self.secs == 0 {
                self.mins = self.mins - 1
                self.secs = 59
            }
            else if self.hours > 0 && self.mins == 0 && self.secs == 0 {
                self.hours = self.hours - 1
                self.mins = 59
                self.secs = 59
            }

            self.updateLabel()
        })
    }

    private func updateLabel() {
        lblTimer.text = "\(hours):\(mins):\(secs)"
    }
}
