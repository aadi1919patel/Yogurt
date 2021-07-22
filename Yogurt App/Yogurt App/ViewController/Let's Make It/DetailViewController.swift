//
//  DetailViewController.swift
//  Yogurt App
//
//  Created by Aditya on 05/05/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblSelect: UILabel!
    @IBOutlet weak var lblStarter: UILabel!
    
    @IBOutlet weak var lblYouart: UILabel!
    @IBOutlet weak var lblKefir: UILabel!
    @IBOutlet weak var lblVegan: UILabel!
    @IBOutlet weak var lblReadyStart: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnDontHave: UIButton!
    
    var hours: Int = 0
    var mins: Int = 0
    var secs: Int = 0
    
    @IBOutlet weak var viewTimer: UIView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var hieghtTimer: NSLayoutConstraint!
    @IBOutlet weak var btnTimer: UIButton!
    
    public var strTitle :String = ""
    public var strSelectProcess :String = ""

    var scheduleTime : Timer?
    
    struct MilkProcess {
        
        // MARK: Properties
        
        let title: String
        let description: String
       
    }
    
    private let milkProcess: [MilkProcess] = [
        MilkProcess(
            
            title: "Pure Acidofilus",
            description: "Yogurt Starter"
           
        ),
        MilkProcess(
            
            title: "Acidophilus",
            description: "Yogurt Starter"
           
        ),
        MilkProcess(
            
            title: "Balkan Style",
            description: "Yogurt Starter"
           
        ),
        MilkProcess(
            
            title: "Authentic Bulgarian",
            description: "Yogurt Starter"
           
        ), MilkProcess(
            
            title: "Bifido",
            description: "Yogurt Starter"
           
//        ), MilkProcess(
//
//            title: "Starter Cultures",
//            description: "L.Rhamnosus and L.Gasseri"
//
        ),
        MilkProcess(
            
            title: "L.Rhamnosus and L.Gasseri",
            description: "Yogurt Starter"
           
        ), MilkProcess(
            
            title: "Kefir",
            description: "Kefir Starter"
           
        ), MilkProcess(
            
            title: "Mild Kefir",
            description: "Kefir Starter"
           
        ), MilkProcess(
            
            title: "Juice Extracted Cultures",
            description: "Vegan Starter"
           
        ), MilkProcess(
            
            title: "Yogurt Ready Starter",
            description: "Ready Starter"
           
        ), MilkProcess(
            
            title: "Kefir Ready Starter",
            description: "Ready Starter"
           
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
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateCellsLayout()
    }
    

    // MARK: - NavigationBar Methods
    
    func setUpNavigationBar()
    {
       
    }
    
    //MARK:- Functions
    func setupInitialViews() {
        
      //  self.lblTitle.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        //self.lblTitle.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        self.lblTitle.text = strTitle
       // self.lblSelect.font = MySingleton.sharedManager().themeFontSixteenSizeBold
      //  self.lblSelect.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
        
        
      //  self.lblStarter.font = MySingleton.sharedManager().themeFontSixteenSizeBold
       // self.lblStarter.textColor = MySingleton.sharedManager().themeGlobalBlueColor
        
      //  self.lblYouart.font = MySingleton.sharedManager().themeFontSixteenSizeBold
      //  self.lblYouart.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapFunction))
        lblYouart.isUserInteractionEnabled = true
        lblYouart.addGestureRecognizer(tap)
        
        
      //  self.lblKefir.font = MySingleton.sharedManager().themeFontSixteenSizeBold
      //  self.lblKefir.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(KefirFunction))
        lblKefir.isUserInteractionEnabled = true
        lblKefir.addGestureRecognizer(tap1)
        
        
       // self.lblVegan.font = MySingleton.sharedManager().themeFontSixteenSizeBold
       // self.lblVegan.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(VeganFunction))
        lblVegan.isUserInteractionEnabled = true
        lblVegan.addGestureRecognizer(tap2)
        
      //  self.lblReadyStart.font = MySingleton.sharedManager().themeFontSixteenSizeBold
      //  self.lblReadyStart.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        self.btnClose?.addTarget(self, action: #selector(self.btnClosedClicked(_:)), for: .touchUpInside)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(ReadyStarterFunction))
        lblReadyStart.isUserInteractionEnabled = true
        lblReadyStart.addGestureRecognizer(tap3)
        
        self.btnDontHave?.addTarget(self, action: #selector(self.btnDontHaveClicked(_:)), for: .touchUpInside)
        self.btnDontHave.layer.borderColor = MySingleton.sharedManager().themeGlobalBlueColor?.cgColor
        self.btnDontHave.layer.borderWidth = 1
        
        self.btnDontHave.layer.cornerRadius = self.btnDontHave.frame.height / 2
        self.btnDontHave.layer.masksToBounds = true
        
      //  self.btnDontHave.setTitleColor(MySingleton.sharedManager().themeGlobalBlueColor, for: .normal)
       // self.btnDontHave.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        
        self.btnTimer?.addTarget(self, action: #selector(self.btnTimerClicked(_:)), for: .touchUpInside)
        
        viewConfigrations()
    }
     
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
        self.collectionView?.scrollToItem(at:IndexPath(item: 0, section: 0), at: [.centeredVertically,   .centeredHorizontally], animated: true)
    }
    
    @objc
    func KefirFunction(sender:UITapGestureRecognizer) {
        print("2tap working")
        self.collectionView?.scrollToItem(at:IndexPath(item: 6, section: 0), at: [.centeredVertically,   .centeredHorizontally], animated: true)
    }
    
    @objc
    func VeganFunction(sender:UITapGestureRecognizer) {
        print("3tap working")
        self.collectionView?.scrollToItem(at:IndexPath(item: 8, section: 0), at: [.centeredVertically,   .centeredHorizontally], animated: true)
    }
    
    @objc
    func ReadyStarterFunction(sender:UITapGestureRecognizer) {
        print("4tap working")
        self.collectionView?.scrollToItem(at:IndexPath(item: 9, section: 0), at: [.centeredVertically,   .centeredHorizontally], animated: true)
    }
    private func viewConfigrations() {
        
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
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
    @IBAction func btnDontHaveClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.npselection.com") {
            UIApplication.shared.open(url)
        }
        
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
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YogurtMakerController") as? YogurtMakerController
        vc?.strTitle = strTitle
        vc?.strSelectProcess = strSelectProcess
        vc?.strSelectedStarterTitle = milkProcess[indexPath.row].title
        vc?.strSelectedDescription = milkProcess[indexPath.row].description
        vc?.strSelectedStarterImage = "\(indexPath.item)"
        self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return milkProcess.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       // let valie = arrayOfDictionary.values
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.imgProduct.image = UIImage(named: "\(indexPath.item)")
       // cell.btnSelect.isUserInteractionEnabled = false
        cell.lblTitle.text = milkProcess[indexPath.row].title
        cell.lblDescription.text = milkProcess[indexPath.row].description
        
        cell.btnSelect.addTarget(self, action: #selector(addSelectClicked(_:)), for: .touchUpInside)
      //  cell.contentView.isUserInteractionEnabled = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YogurtMakerController") as? YogurtMakerController
        vc?.strTitle = strTitle
        vc?.strSelectProcess = strSelectProcess
        vc?.strSelectedStarterTitle = milkProcess[indexPath.row].title
        vc?.strSelectedDescription = milkProcess[indexPath.row].description
        vc?.strSelectedStarterImage = "\(indexPath.item)"
        self.navigationController?.pushViewController(vc!, animated: true)
       //
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var cellSize: CGSize = collectionView.bounds.size
        
        
        switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                cellSize.width -= collectionView.contentInset.left * 2
                cellSize.width -= collectionView.contentInset.right * 2
                cellSize.height = cellSize.width + 110
                // It's an iPhone
        case .pad:
            print(UIScreen.main.bounds.size.height)
            if(UIScreen.main.bounds.size.height == 1024) {
                cellSize.width = 500
                cellSize.height = 600
                // iPad pro (or hypothetical/future huge-screened iOS device)
            }else{
                cellSize.width = 550
                cellSize.height = 550
            }
            
           
                // It's an iPad (or macOS Catalyst)

        case .unspecified: break
            
        case .tv: break
            
        case .carPlay: break
            
        case .mac: break
            
        @unknown default: break
                // Uh, oh! What could it be?
            }
       
        return cellSize
       // return  UITableViewAutomaticDimension
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
        if(indexPath?.row ?? 0 < 6  ){
            lblYouart.attributedText = NSAttributedString(string: "YOUGURT", attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
            lblYouart.textColor = MySingleton.sharedManager().themeGlobalBlueColor
           // lblYouart.font = MySingleton.sharedManager().themeFontFourteenSizeBold
           
            lblKefir.attributedText = NSAttributedString(string: "KEFIR", attributes:
                                                        [.underlineStyle: 0])
            lblKefir.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
          //  lblKefir.font = MySingleton.sharedManager().themeFontFourteenSizeBold
           
            lblReadyStart.attributedText = NSAttributedString(string: "READY STARTERS", attributes:
                                                            [.underlineStyle: 0])
            lblReadyStart.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
          //  lblReadyStart.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblVegan.attributedText = NSAttributedString(string: "VEGAN", attributes:
                                                            [.underlineStyle: 0])
            lblVegan.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
          //  lblVegan.font = MySingleton.sharedManager().themeFontFourteenSizeBold
        }
        else if(indexPath?.row == 6 || indexPath?.row == 7){
            lblKefir.attributedText = NSAttributedString(string: "KEFIR", attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
            lblKefir.textColor = MySingleton.sharedManager().themeGlobalBlueColor
           // lblKefir.font = MySingleton.sharedManager().themeFontFourteenSizeBold
           
            lblYouart.attributedText = NSAttributedString(string: "YOUGURT", attributes:
                                                        [.underlineStyle: 0])
            lblYouart.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
           // lblYouart.font = MySingleton.sharedManager().themeFontFourteenSizeBold
           
            lblReadyStart.attributedText = NSAttributedString(string: "READY STARTERS", attributes:
                                                            [.underlineStyle: 0])
            lblReadyStart.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
          //  lblReadyStart.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblVegan.attributedText = NSAttributedString(string: "VEGAN", attributes:
                                                            [.underlineStyle: 0])
            lblVegan.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
           // lblVegan.font = MySingleton.sharedManager().themeFontFourteenSizeBold
        }
        
        else if(indexPath?.row == 8 ){
            lblVegan.attributedText = NSAttributedString(string: "VEGAN", attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
            lblVegan.textColor = MySingleton.sharedManager().themeGlobalBlueColor
           // lblVegan.font = MySingleton.sharedManager().themeFontFourteenSizeBold
           
            lblYouart.attributedText = NSAttributedString(string: "YOUGURT", attributes:
                                                        [.underlineStyle: 0])
            lblYouart.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
           // lblYouart.font = MySingleton.sharedManager().themeFontFourteenSizeBold
           
            lblReadyStart.attributedText = NSAttributedString(string: "READY STARTERS", attributes:
                                                            [.underlineStyle: 0])
            lblReadyStart.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
           // lblReadyStart.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblKefir.attributedText = NSAttributedString(string: "KEFIR", attributes:
                                                            [.underlineStyle: 0])
            lblKefir.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
          //  lblKefir.font = MySingleton.sharedManager().themeFontFourteenSizeBold
        }
        else if(indexPath?.row == 9 || indexPath?.row == 10){
            lblReadyStart.attributedText = NSAttributedString(string: "READY STARTERS", attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
            lblReadyStart.textColor = MySingleton.sharedManager().themeGlobalBlueColor
           // lblReadyStart.font = MySingleton.sharedManager().themeFontFourteenSizeBold
           
            lblYouart.attributedText = NSAttributedString(string: "YOUGURT", attributes:
                                                        [.underlineStyle: 0])
            lblYouart.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
           // lblYouart.font = MySingleton.sharedManager().themeFontFourteenSizeBold
           
            lblKefir.attributedText = NSAttributedString(string: "KEFIR", attributes:
                                                            [.underlineStyle: 0])
            lblKefir.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
           // lblKefir.font = MySingleton.sharedManager().themeFontFourteenSizeBold
            
            lblVegan.attributedText = NSAttributedString(string: "VEGAN", attributes:
                                                            [.underlineStyle: 0])
            lblVegan.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
           // lblVegan.font = MySingleton.sharedManager().themeFontFourteenSizeBold
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
//Timer
extension DetailViewController{
    
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
            print("negative interval")
            Constant.userDefault.setTimerDate(value: "")
            DispatchQueue.main.async {
                self.hieghtTimer.constant = 0
               }
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
