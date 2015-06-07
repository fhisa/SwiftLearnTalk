/**
Swift用のBDDライブラリ Quick による振舞いの記述例

このコードの前半部分でプログラムした２種類のSwiftクラスの振舞いを
後半部分(describe('Swift') の行以降)でRSpecを使って定義しています。

後半部分は振舞いを記述するためのDSL(Domain Specific Language)
として見ることができます。
*/


/****** 以下、２種類のSwiftクラスのプログラム(RSpecで振舞い定義の対象) ******/

/// 生物学上のSwiftクラス
class Biology {
  class Swift {
    let description: String
    init() {
      description = "a kind of swallow"
    }
  }
}

/// ソフトウェア技術上のSwiftクラス
class SoftwareTechnology {
  class Swift {
    let description: String
    init() {
      description = "a programming language"
    }
  }
}


/****** 以下、RSpecでの振舞い定義 ******/
import Quick
import Nimble

class SwiftSpec: QuickSpec {

  override func spec() {
    describe("Swift") {
      var biological_description: String!
      var software_technological_description: String!
      beforeEach {
        biological_description = "a kind of swallow"
        software_technological_description = "a programming language"
      }

      context("Biology") {
        var swift: Biology.Swift!
        beforeEach { swift = Biology.Swift() }

        it("is \(biological_description)") {
          expect(swift.description).to(equal(biological_description))
        }
        it("is not \(software_technological_description)") {
          expect(@swift.description).toNot(equal(software_technological_description))
        }
      }

      context("SoftwareTechnology") {
        var swift: SoftwareTechnology.Swift!
        beforeEach { swift = SoftwareTechnology.Swift() }

        it("is not \(biological_description)") {
          expect(swift.description).toNot(equal(biological_description))
        }
        it("is \(software_technological_description)") {
          expect(@swift.description).to(equal(software_technological_description))
        }
      }
    }
  }
}
