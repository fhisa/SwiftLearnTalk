/**
RSpecのようなSwiftベースのDSLライブラリの簡単な構成例

このコードの前半部分では、RSpecもどきの簡単なDSLライブラリを
プログラムしています。後半部分は、前半で作ったライブラリを
使ってDSLを記述しています。

(注) DSL = Domain Specific Language
(注) このコードは、このままでは実用性はゼロです
*/


/**********************************************************/
/****** 以下、RSpecもどきのDSLライブラリのプログラム ******/

import Foundation

class TinySpec {

  private static var _instance = TinySpec()

  static var instance: TinySpec {
    return _instance
  }

  var stack = [String]()
  var results = [String]()

  func describe(desc: String, block: () -> Void) {
    stack.append("describe \(desc)")
    block()
    stack.removeLast()
  }

  func context(cont: String, block: () -> Void) {
    stack.append("context \(cont)")
    block()
    stack.removeLast()
  }

  func it(str: String, block: () -> AnyObject) -> String {
    stack.append("it \(str)")
    let value: AnyObject = block()
    let name = join(", ", stack)
    stack.removeLast()
    let result = "\(name) => \(value)"
    results.append(result)
    return result
  }
}

public func describe(desc: String, block: () -> Void) {
  TinySpec.instance.describe(desc, block: block)
}

public func context(cont: String, block: () -> Void) {
  TinySpec.instance.context(cont, block: block)
}

public func it(str: String, block: () -> AnyObject) {
  let result = TinySpec.instance.it(str, block: block)
  println(result)
}


/********************************************/
/****** 以下、RSpecもどきDSLによる記述 ******/

describe("Swift") {
  context("of software engineering") {
    it("is a programming language") { true }
    it("is a kind of swallow") { false }
  }
  context("in biology") {
    it("is a programming language") { false }
    it("is a kind of swallow") { true }
  }
}


/*********************
****** 実行結果 ******
describe Swift, context of software engineering, it is a programming language => 1
describe Swift, context of software engineering, it is a kind of swallow => 0
describe Swift, context in biology, it is a programming language => 0
describe Swift, context in biology, it is a kind of swallow => 1
*/
