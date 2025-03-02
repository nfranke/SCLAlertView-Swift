//
//  ViewController.swift
//  SCLAlertViewExample
//
//  Created by Viktor Radchenko on 6/6/14.
//  Copyright (c) 2014 Viktor Radchenko. All rights reserved.
//

import UIKit
import SCLAlertView


let kSuccessTitle = "Congratulations"
let kErrorTitle = "Connection error"
let kNoticeTitle = "Notice"
let kWarningTitle = "Warning"
let kInfoTitle = "Info"
let kSubtitle = "You've just displayed this awesome Pop Up View"

let kDefaultAnimationDuration = 2.0

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showSuccess(_ sender: AnyObject) {
        
        let attributedString = NSMutableAttributedString(string: "fdasfsaf fdsafsda\n")

        let attributes1: [NSAttributedString.Key : Any] = [
           .font: UIFont(name: "HelveticaNeue", size: 18)!
        ]
        attributedString.addAttributes(attributes1, range: NSRange(location: 9, length: 8))
        
        
		let alert = SCLAlertView()
        _ = alert.addButton(NSAttributedString(attributedString: attributedString), action: {})
		_ = alert.addButton("Second Button") {
			print("Second button tapped")
		}
        _ = alert.showSuccess(kSuccessTitle, subTitle: kSubtitle)
    }
    
    @IBAction func showError(_ sender: AnyObject) {
		_ = SCLAlertView().showError("Hold On...", subTitle:"You have not saved your Submission yet. Please save the Submission before accessing the Responses list. Blah de blah de blah, blah. Blah de blah de blah, blah.Blah de blah de blah, blah.Blah de blah de blah, blah.Blah de blah de blah, blah.Blah de blah de blah, blah.", closeButtonTitle:"OK")
//        SCLAlertView().showError(self, title: kErrorTitle, subTitle: kSubtitle)
    }
    
    @IBAction func showNotice(_ sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(dynamicAnimatorActive: true)
        _ = SCLAlertView(appearance: appearance).showNotice(kNoticeTitle, subTitle: kSubtitle)
    }
    
    @IBAction func showWarning(_ sender: AnyObject) {
        _ = SCLAlertView().showWarning(kWarningTitle, subTitle: kSubtitle)
    }
    
    @IBAction func showInfo(_ sender: AnyObject) {
        _ = SCLAlertView().showInfo(kInfoTitle, subTitle: kSubtitle)
    }
    
	@IBAction func showEdit(_ sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(
          kTextFieldHeight: 60,
          showCloseButton: true
        )
        let alert = SCLAlertView(appearance: appearance)
		let txt = alert.addTextField("Enter your name")
        _ = alert.addButton("Show Name") {
			print("Text value: \(txt.text ?? "NA")")
		}
		_ = alert.showEdit(kInfoTitle, subTitle:kSubtitle)
	}
    
    @IBAction func showWait(_ sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        
        let alert = SCLAlertView(appearance: appearance).showWait("Download", subTitle: "Processing...", closeButtonTitle: nil, timeout: nil, colorStyle: nil, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.topToBottom)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            alert.setSubTitle("Progress: 10%")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                alert.setSubTitle("Progress: 30%")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    alert.setSubTitle("Progress: 50%")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        alert.setSubTitle("Progress: 70%")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            alert.setSubTitle("Progress: 90%")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                alert.close()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func showCustomSubview(_ sender: AnyObject) {
        // Create custom Appearance Configuration
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false,
            dynamicAnimatorActive: true
        )
        
        // Initialize SCLAlertView using custom Appearance
        let alert = SCLAlertView(appearance: appearance)
        
        // Creat the subview
        let subview = UIView(frame: CGRect(x: 0,y: 0,width: 216,height: 70))
        let x = (subview.frame.width - 180) / 2
        
        // Add textfield 1
        let textfield1 = UITextField(frame: CGRect(x: x,y: 10,width: 180,height: 25))
        textfield1.layer.borderColor = UIColor.green.cgColor
        textfield1.layer.borderWidth = 1.5
        textfield1.layer.cornerRadius = 5
        textfield1.placeholder = "Username"
        textfield1.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield1)
        
        // Add textfield 2
        let textfield2 = UITextField(frame: CGRect(x: x,y: textfield1.frame.maxY + 10,width: 180,height: 25))
        textfield2.isSecureTextEntry = true
        textfield2.layer.borderColor = UIColor.blue.cgColor
        textfield2.layer.borderWidth = 1.5
        textfield2.layer.cornerRadius = 5
        textfield1.layer.borderColor = UIColor.blue.cgColor
        textfield2.placeholder = "Password"
        textfield2.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield2)
        
        // Add the subview to the alert's UI property
        alert.customSubview = subview
        _ = alert.addButton("Login") {
            print("Logged in")
        }
        
        // Add Button with visible timeout and custom Colors
        let showTimeout = SCLButton.ShowTimeoutConfiguration(prefix: "(", suffix: " s)")
        _ = alert.addButton("Timeout Button", backgroundColor: UIColor.brown, textColor: UIColor.yellow, showTimeout: showTimeout) {
            print("Timeout Button tapped")
        }

        let timeoutValue: TimeInterval = 10.0
        let timeoutAction: SCLAlertView.SCLTimeoutConfiguration.ActionType = {
            print("Timeout occurred")
        }
        
        _ = alert.showInfo("Login", subTitle: "", timeout: SCLAlertView.SCLTimeoutConfiguration(timeoutValue: timeoutValue, timeoutAction: timeoutAction))
    }
    
    @IBAction func showCustomAlert(_ sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false,
            dynamicAnimatorActive: true,
            buttonsLayout: .horizontal
        )
        let alert = SCLAlertView(appearance: appearance)
        _ = alert.addButton("First Button", target:self, selector:#selector(ViewController.firstButton))
        _ = alert.addButton("Second Button") {
            print("Second button tapped")
        }
        
        let icon = UIImage(named:"custom_icon.png")
        let color = UIColor.orange
        
        _ = alert.showCustom("Custom Color", subTitle: "Custom color", color: color, circleIconImage: icon!)
    }
	
  @IBAction func showEmptySubTitleAlert(_ sender: UIButton) {
    let margin = SCLAlertView.SCLAppearance.Margin(buttonSpacing: 30,
                                                   bottom: 30,
                                                   horizontal: 30)
    
    let appearance = SCLAlertView.SCLAppearance(
      kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
      kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
      kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
      shouldAutoDismiss: true,
      margin: margin
    )
    let alert = SCLAlertView(appearance: appearance)
    _ = alert.addButton("First", target:self, selector:#selector(ViewController.firstButton))
    
    let icon = UIImage(named:"custom_icon.png")
    let color = UIColor.orange
    
    _ = alert.showCustom("Empty SubTitle Alert", subTitle: "This is an empty subTitle alertView with horizontal and bottom margin equals 30", color: color, circleIconImage: icon!)

  }
  
  @objc func firstButton() {
		print("First button tapped")
	}
  
}
