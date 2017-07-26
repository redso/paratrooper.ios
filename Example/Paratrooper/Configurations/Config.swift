import Foundation

protocol Config {
  
  var endPoint: String { get }
  
}

struct DebugConfig: Config {
  
  let endPoint = "https://www.redso.com.hk/debug"
  
}

struct ProductionConfig: Config {
  
  let endPoint = "https://www.redso.com.hk/production"
  
}
