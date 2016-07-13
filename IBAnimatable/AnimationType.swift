//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation
import UIKit

/**
 Predefined Animation Type
 */
public enum AnimationType {
  case slide(way:Way?, direction:Direction?)
  case squeeze(way:Way?, direction:Direction?) // miss squeeze
  case fade(way:Way?, direction:Direction?) // miss fadeinout, fadeountin
  case squeezeFade(way:Way?, direction:Direction?)
  case zoom(way:Way?)
  case shake
  case pop
  case flip(along:Axis?)
  case morph
  case flash
  case wobble
  case swing
  case rotate(direction:RotationDirection?)
  case moveTo(x:Double?, y:Double?)
  case moveBy(x:Double?, y:Double?)
  case none
 
  public enum Way: String {
    case Out = "out"
    case In = "in"
  }
  public enum Axis: String {
    case x, y
  }
  public enum Direction: String {
    case left, right, up, down
    
    func isVertical() -> Bool {
      return self == .down || self == .up
    }
  }
  public enum RotationDirection: String {
    case cw, ccw
  }
}

extension AnimationType : IBEnum {
  
  public init(string: String?) {
    guard let string = string else {
      self = .none
      return
    }
    let nameAndParames = MaskType.extractNameAndParams(from: string)
    let name = nameAndParames.name
    let params = nameAndParames.params
    
    switch name.lowercased() {
      case "slide":
        self = .slide(way: Way(raw: params[safe:0]), direction: Direction(raw: params[safe:1]))
      case "squeeze":
        self = .squeeze(way: Way(raw: params[safe:0]), direction: Direction(raw: params[safe:1] ))
      case "fade":
        self = .fade(way: Way(raw: params[safe:0]), direction: Direction(raw: params[safe:1] ?? ""))
      case "squeezefade":
        self = .squeezeFade(way: Way(raw: params[safe:0]), direction: Direction(raw: params[safe:1] ?? ""))
      case "zoom":
        self = .zoom(way: Way(raw: params[safe:0] ))
      case "shake":
        self = .shake
      case "pop":
        self = .pop
      case "flip":
        self = .flip(along: Axis(raw: params[safe:0]))
      case "morph":
        self = .morph
      case "flash":
        self = .flash
      case "wobble":
        self = .wobble
      case "swing":
        self = .swing
      case "rotate":
        self = .rotate(direction: RotationDirection(raw: params[safe:0] ?? ""))
      case "moveto":
        self = .moveTo(x: Double(params[safe:0] ?? "") , y: Double(params[safe:1] ?? ""))
    case "moveby":
      self = .moveBy(x: Double(params[safe:0] ?? ""), y: Double(params[safe:1] ?? ""))
    default:
      self = .none
    }
  }
}
