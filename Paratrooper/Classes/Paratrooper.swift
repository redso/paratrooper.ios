import Foundation
import UIKit

private enum Constant {
  
  static let modeKey = "hk.com.redso.Paratrooper.modeKey"
  
}

public extension Notification.Name {
  
  public static let ParatrooperDidChangeMode = Notification.Name(rawValue: "hk.com.redso.Paratrooper.ParatrooperDidChangeMode")
  
}

class OptionMenuController: NSObject {
  
  unowned let viewController: UIViewController
  private let options: [String]
  private let selectionBlock: (String)->Void
  
  init(viewController: UIViewController, options: [String], selectionBlock: @escaping (String)->Void) {
    self.viewController = viewController
    self.options = options
    self.selectionBlock = selectionBlock
  }
  
  @objc func viewDidTap() {
    
    let actionSheet = UIAlertController(title: "Configurations", message: "Please select one configurations, restart the app afterward to take the effect", preferredStyle: UIAlertControllerStyle.actionSheet)
    
    for option in options {
      let action = UIAlertAction(title: option, style: UIAlertActionStyle.default) { [unowned self] (action) in
        self.selectionBlock(option)
      }
      actionSheet.addAction(action)
    }
    
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) in })
    
    // support iPads (popover view)
    actionSheet.popoverPresentationController?.sourceView = viewController.view
    actionSheet.popoverPresentationController?.sourceRect = viewController.view.bounds
    
    viewController.present(actionSheet, animated: true, completion: nil)
  }
  
}


public class Paratrooper<C> {
  
  fileprivate var configurations = [String:()->C]()
  private let userDefaults = UserDefaults.standard
  private var _configuration: C?
  
  fileprivate var menuController: OptionMenuController?
  
  public init() {
  }
  
  public init(configurations: [String:()->C]) {
    self.configurations = configurations
    if let mode = self.mode, let configuration = configurations[mode] {
      _configuration = configuration()
    }
  }
  
  public var configuration: C {
    guard let c = _configuration else {
      assert(true, "The configuration isn't configured properly, please register at least one configuration")
      return _configuration!
    }
    return c
  }
  
  public var mode: String? {
    get {
      return userDefaults.string(forKey: Constant.modeKey)
    }
    set {
      guard let newValue = newValue, let newConfiguration = configurations[newValue] else {
        assert(true, "No configuration related to mode is found")
        return
      }
      _configuration = newConfiguration()
      userDefaults.set(newValue, forKey: Constant.modeKey)
      userDefaults.synchronize()
      if mode != newValue {
        NotificationCenter.default.post(name: Notification.Name.ParatrooperDidChangeMode, object: newValue)
      }
    }
  }
  
  public func register(mode: String, _ factory: @escaping @autoclosure () -> C) {
    configurations[mode] = factory
    if _configuration == nil {
      if self.mode == nil {
        // set first register mode to be default if _configuration is empty
        self.mode = mode
      } else if self.mode == mode {
        // if the configuration is same as previous stored one, use it
        _configuration = factory()
      }
    }
  }
  
}

// UI related
public extension Paratrooper {
  
  public func land(on viewController: UIViewController) {
    menuController = OptionMenuController(viewController: viewController, options: Array(configurations.keys).sorted()) {
      self.mode = $0
    }
    let tap = UITapGestureRecognizer(target: menuController, action: #selector(OptionMenuController.viewDidTap))
    tap.numberOfTouchesRequired = 4
    viewController.view.addGestureRecognizer(tap)
  }
  
}
