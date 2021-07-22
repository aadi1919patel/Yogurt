//
//  OverviewViewController.swift
//  Yogurt App
//
//  Created by Aditya on 02/05/21.
//

import UIKit


class OverviewViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var SliderContainerView: RangeSeekSlider!
    @IBOutlet weak var lblOverView: UILabel!
    
    @IBOutlet weak var lblOverviewCount: UILabel!
    @IBOutlet weak var imgOverview: UIImageView!
    @IBOutlet weak var lblMilkType: UILabel!
    
    @IBOutlet weak var btnOverviewBack: UIButton!
    @IBOutlet weak var lblOverviewDescription: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnContctUs: UIButton!
    @IBOutlet weak var btnOderStarter
        : UIButton!
    
    @IBOutlet weak var stackBackView: UIStackView!
    @IBOutlet weak var stackMakeIt: UIStackView!
    @IBOutlet weak var btnOverviewLetsMakeIt: UIButton!
 
    var intBoolSetSliderValue : Int = 0
    
    var hours: Int = 0
    var mins: Int = 0
    var secs: Int = 0

    @IBOutlet weak var viewTimer: UIView!
       @IBOutlet weak var lblTimer: UILabel!
       @IBOutlet weak var hieghtTimer: NSLayoutConstraint!
    @IBOutlet weak var btnTimer: UIButton!
    
    var scheduleTime : Timer?
    struct MilkProcess {
        
        // MARK: Properties
        
        let title: String
        let imgName: String
        let Detail: String
       
    }
    private let milkProcess: [MilkProcess] = [
        MilkProcess(
            title: "Select",
            imgName: "Overview_1",
            Detail: "Milk"
        ),
        MilkProcess(
            title: "Prepare the",
            imgName: "Overview_2",
            Detail: "Milk"
        ),
        MilkProcess(
            title: "Choose",
            imgName: "Overview_3",
            Detail: "Starter"
        ),
        MilkProcess(
            title: "",
            imgName: "Overview_4",
            Detail: "Mix"
        ),
        MilkProcess(
            title: "Select",
            imgName: "Overview_5",
            Detail: "Yogurt Maker"
        ),
        MilkProcess(
            title: "Incubate in 1 or 2 steps &",
            imgName: "Overview_6",
            Detail: "Get Notification"
        ),
        MilkProcess(
            title: "Cool it Down &",
            imgName: "Overview_7",
            Detail: "Enjoy"
        )
    ]
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupInitialViews()
        self.setUpNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
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
    // MARK: - NavigationBar Methods
    
    func setUpNavigationBar()
    {
        
    }
    
    //MARK:- Functions
    func setupInitialViews() {
        
        // custom number formatter range slider
        SliderContainerView.delegate = self
        SliderContainerView.minValue = 0.0
        SliderContainerView.maxValue = 7.00
        SliderContainerView.selectedMinValue = 0.0
        SliderContainerView.selectedMaxValue = 1.0
//        SliderContainerView.layer.borderWidth = 1.0
//        SliderContainerView.layer.borderColor = UIColor.black.cgColor
       // SliderContainerView.handleImage = #imageLiteral(resourceName: "custom-handle")
        SliderContainerView.selectedHandleDiameterMultiplier = 1.0
        SliderContainerView.colorBetweenHandles = MySingleton.sharedManager().themeGlobalBlueColor
       // SliderContainerView.sele
        SliderContainerView.lineHeight = 20.0
      
        intBoolSetSliderValue = 1
       // self.lblOverView.font = MySingleton.sharedManager().themeFontSixteenSizeBold
       // self.lblOverView.textColor = MySingleton.sharedManager().themeGlobalGreyColor
        
        //self.lblOverviewCount.font = MySingleton.sharedManager().themeFontSixteenSizeBold
       // self.lblOverviewCount.textColor = MySingleton.sharedManager().themeGlobalGreyColor
        
        //self.lblMilkType.font = MySingleton.sharedManager().themeFontSixteenSizeBold
       // self.lblMilkType.textColor = UIColor.blue
        
       // self.lblOverviewDescription.font = MySingleton.sharedManager().themeFontSixteenSizeBold
       // self.lblOverviewDescription.textColor = MySingleton.sharedManager().themeGlobalGreyColor
        
                self.btnOverviewBack.setTitle("Back", for: .normal)
                self.btnOverviewBack.setTitleColor(MySingleton.sharedManager().themeGlobalWhiteColor, for: .normal)
               // self.btnOverviewBack.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
                self.btnOverviewBack.titleLabel?.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
               // self.btnOverviewBack.setBackgroundColor(UIColor.blue, for: .normal)
                self.btnOverviewBack?.addTarget(self, action: #selector(self.btnOverviewBackClicked(_:)), for: .touchUpInside)
                self.btnOverviewBack.layer.cornerRadius = self.btnOverviewBack.frame.height / 2
                self.btnOverviewBack.layer.masksToBounds = true
        
        self.btnNext.setTitle("Next", for: .normal)
        self.btnNext.setTitleColor(MySingleton.sharedManager().themeGlobalBlueColor, for: .normal)
      //  self.btnNext.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        self.btnNext.titleLabel?.textColor = MySingleton.sharedManager().themeGlobalBlueColor
        self.btnNext.setBackgroundColor(UIColor.white, for: .normal)
        self.btnNext?.addTarget(self, action: #selector(self.btnOverviewNextClicked(_:)), for: .touchUpInside)
        self.btnNext.layer.cornerRadius = self.btnNext.frame.height / 2
        self.btnNext.layer.masksToBounds = true
        self.btnNext.layer.borderColor = MySingleton.sharedManager().themeGlobalBlueColor?.cgColor
        self.btnNext.layer.borderWidth = 1.0
    
        let CombineString =  "\(milkProcess[0].title) \(milkProcess[0].Detail)"
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: CombineString)
        attributedString.setColor(color: MySingleton.sharedManager().themeGlobalBlueColor!, forText: milkProcess[0].Detail)
        //self.lblOverviewDescription.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        lblOverviewDescription.attributedText = attributedString
        self.btnBack?.addTarget(self, action: #selector(self.btnClosedClicked(_:)), for: .touchUpInside)
        
        self.btnOverviewLetsMakeIt.setTitle("Next", for: .normal)
        self.btnOverviewLetsMakeIt.setTitleColor(MySingleton.sharedManager().themeGlobalBlueColor, for: .normal)
       // self.btnOverviewLetsMakeIt.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        self.btnOverviewLetsMakeIt.titleLabel?.textColor = MySingleton.sharedManager().themeGlobalBlueColor
        self.btnOverviewLetsMakeIt.setBackgroundColor(UIColor.white, for: .normal)
        self.btnOverviewLetsMakeIt?.addTarget(self, action: #selector(self.btnOverviewNextClicked(_:)), for: .touchUpInside)
        self.btnOverviewLetsMakeIt.layer.cornerRadius = self.btnNext.frame.height / 2
        self.btnOverviewLetsMakeIt.layer.masksToBounds = true
        self.btnOverviewLetsMakeIt.layer.borderColor = MySingleton.sharedManager().themeGlobalBlueColor?.cgColor
        self.btnOverviewLetsMakeIt.layer.borderWidth = 1.0
    
        self.stackMakeIt.isHidden = false
        self.stackBackView.isHidden = true
        
        self.btnOderStarter.setTitle("Order Starters", for: .normal)
        self.btnOderStarter.setTitleColor(MySingleton.sharedManager().themeGlobalBlueColor, for: .normal)
       // self.btnOderStarter.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        self.btnOderStarter.titleLabel?.textColor = UIColor.white
        self.btnOderStarter.setBackgroundColor(UIColor.white, for: .normal)
        self.btnOderStarter?.addTarget(self, action: #selector(self.btnOrderStarterClicked(_:)), for: .touchUpInside)
        self.btnOderStarter.layer.cornerRadius = self.btnOderStarter.frame.height / 2
        self.btnOderStarter.layer.masksToBounds = true
        self.btnOderStarter.layer.borderColor = MySingleton.sharedManager().themeGlobalBlueColor?.cgColor
        self.btnOderStarter.layer.borderWidth = 1.0
        
        self.btnContctUs.setTitle("Contact Us", for: .normal)
        self.btnContctUs.setTitleColor(UIColor.white, for: .normal)
       // self.btnContctUs.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
       
       //' self.btnContctUs.setBackgroundColor(UIColor.blue, for: .normal)
        self.btnContctUs?.addTarget(self, action: #selector(self.btnContactUsClicked(_:)), for: .touchUpInside)
        self.btnContctUs.layer.cornerRadius = self.btnOderStarter.frame.height / 2
        self.btnContctUs.layer.masksToBounds = true
    
        self.btnTimer?.addTarget(self, action: #selector(self.btnTimerClicked(_:)), for: .touchUpInside)
        
    }
    //MARK:- other Service
    
    @IBAction func btnClosedClicked(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnOverviewBackClicked(_ sender: UIButton)
    {
        if(intBoolSetSliderValue < 8){
            
            intBoolSetSliderValue = intBoolSetSliderValue - 1
            if(intBoolSetSliderValue == 1){
                self.stackMakeIt.isHidden = false
                self.stackBackView.isHidden = true
            }
            else{
                self.stackMakeIt.isHidden = true
                self.stackBackView.isHidden = false
            }
            if(intBoolSetSliderValue > 0){
                
               
                imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                let CombineString =  "\(milkProcess[intBoolSetSliderValue - 1].title) \(milkProcess[intBoolSetSliderValue - 1].Detail)"
              //  let CombineString =  milkProcess[intBoolSetSliderValue - 1].title + milkProcess[intBoolSetSliderValue - 1].Detail
                let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: CombineString)
                attributedString.setColor(color: MySingleton.sharedManager().themeGlobalBlueColor!, forText: milkProcess[intBoolSetSliderValue - 1].Detail)
               // self.lblOverviewDescription.font = MySingleton.sharedManager().themeFontSixteenSizeBold
                lblOverviewDescription.attributedText = attributedString
                //lblOverviewDescription.text =  milkProcess[intBoolSetSliderValue - 1].title
                    self.lblOverviewCount.text = "\(intBoolSetSliderValue)/7"
                    SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                    SliderContainerView.setNeedsLayout()
                
                
            }else{
                
//                self.stackMakeIt.isHidden = false
//                self.stackBackView.isHidden = true
                intBoolSetSliderValue = 1
                imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                let CombineString =  "\(milkProcess[intBoolSetSliderValue - 1].title) \(milkProcess[intBoolSetSliderValue - 1].Detail)"
                let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: CombineString)
                attributedString.setColor(color: MySingleton.sharedManager().themeGlobalBlueColor!, forText: milkProcess[intBoolSetSliderValue - 1].Detail)
               // self.lblOverviewDescription.font = MySingleton.sharedManager().themeFontSixteenSizeBold
                lblOverviewDescription.attributedText = attributedString
                self.lblOverviewCount.text = "\(intBoolSetSliderValue)/7"
                SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                SliderContainerView.setNeedsLayout()
            }
        }
       
        
    }
    @IBAction func btnOverviewNextClicked(_ sender: UIButton)
    {
        if(intBoolSetSliderValue < 7){
            
//            self.stackMakeIt.isHidden = true
//            self.stackBackView.isHidden = false
            
            intBoolSetSliderValue = intBoolSetSliderValue + 1
            
            if(intBoolSetSliderValue == 1){
                self.stackMakeIt.isHidden = false
                self.stackBackView.isHidden = true
                //self.btnOverviewLetsMakeIt.setTitle("Next", for: .normal)
            }else if(intBoolSetSliderValue == 7){
                self.stackMakeIt.isHidden = false
                self.stackBackView.isHidden = true
                self.btnOverviewLetsMakeIt.setTitle("Let's Make it", for: .normal)
                self.btnOverviewLetsMakeIt.setBackgroundColor(MySingleton.sharedManager().themeGlobalBlueColor, for: .normal)
                self.btnOverviewLetsMakeIt.setTitleColor(UIColor.white, for: .normal)
                
               
            }
            else{
                self.stackMakeIt.isHidden = true
                self.stackBackView.isHidden = false
               // self.btnOverviewLetsMakeIt.setTitle("Next", for: .normal)
            }
            
            if(intBoolSetSliderValue > 0){
                imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
               // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                let CombineString =  "\(milkProcess[intBoolSetSliderValue - 1].title) \(milkProcess[intBoolSetSliderValue - 1].Detail)"
                let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: CombineString)
                attributedString.setColor(color: MySingleton.sharedManager().themeGlobalBlueColor!, forText: milkProcess[intBoolSetSliderValue - 1].Detail)
               // self.lblOverviewDescription.font = MySingleton.sharedManager().themeFontSixteenSizeBold
                lblOverviewDescription.attributedText = attributedString
                self.lblOverviewCount.text = "\(intBoolSetSliderValue)/7"
                SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                SliderContainerView.setNeedsLayout()
            }else{
//                self.stackMakeIt.isHidden = false
//                self.stackBackView.isHidden = true
                intBoolSetSliderValue = 1
                imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
               // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                let CombineString =  "\(milkProcess[intBoolSetSliderValue - 1].title) \(milkProcess[intBoolSetSliderValue - 1].Detail)"
                let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: CombineString)
                attributedString.setColor(color: MySingleton.sharedManager().themeGlobalBlueColor!, forText: milkProcess[intBoolSetSliderValue - 1].Detail)
                //self.lblOverviewDescription.font = MySingleton.sharedManager().themeFontSixteenSizeBold
                lblOverviewDescription.attributedText = attributedString
                self.lblOverviewCount.text = "\(intBoolSetSliderValue)/7"
                SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                SliderContainerView.setNeedsLayout()
            }
        }else{
            if(intBoolSetSliderValue == 7){
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MakeItViewController") as? MakeItViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            }
          
        }
       
      
      
     //   SliderContainerView.selectedMaxValue = 5.0
       // self.rangeSeekSlider(SliderContainerView, didChange: 0, maxValue: 5.6000)
        // SliderContainerView.selectedMaxValue = 5
       
    }
  
    @IBAction func btnOrderStarterClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.npselection.com/") {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func btnContactUsClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.yogurtathome.com/contact") {
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

}
// MARK: - RangeSeekSliderDelegate

extension OverviewViewController: RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        print("Custom slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
    }

    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }

    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}
//Timer
extension OverviewViewController{
    
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

