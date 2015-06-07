# SwiftでRSpecのようなDSLを作るには？

[Swift Learn x Talk Vol.4](https://www.facebook.com/events/1438326419807588/) に参加してきました。自分は「SwiftでRSpecのようなDSLを作る」をテーマにSwiftやRubyのコードを書き散らしてきました。

* spec_modoki.rb - Rubyで書いたRSpecに似た雰囲気の捨てDSL
* spec_modoki.swift - spec_modoki.rbをSwiftで書きなおしたもの
* swift_spec.rb - RSpecの使用例
* swift_spec.swift - Quickの使用例(動作未確認)


## 背景

Swiftで使えるフレームワークをGitHubで探しているときに、そのフレームワークの使い方を知る手段のひとつとして、テストコードを見てみる方法が有効です(ドキュメントがなくテストだけがある場合など)。

XcodeにはXCTestというテスティングフレームワークがデフォルトで付属しているので、テストコードが存在している場合にはXCTestで書かれていることが多いですが、[Quick](https://github.com/Quick/Quick)というテスティングフレームワークでテストが書かれているものもちらほら存在することに気付きました。Quickは、Ruby用の[BDD](http://ja.wikipedia.org/wiki/ビヘイビア駆動開発)フレームワーク[RSpec](http://rspec.info)に影響を受けたSwift/Objecitve-C用BDDフレームワークです。

RSpecやQuickについてはよく知らなかったので、入門も兼ねて、先月(2015年5月)ある勉強会で「[テスティングフレームワークに入門してみた - Swift編](http://www.slideshare.net/hisakunifujimoto/testing-framework-for-swift)」というタイトルで発表してきました。

RSpecとQuickに入門してみて、Quickの残念な点がちょっと気になってしまい改良できないものだろうかと思ったのが、今回「SwiftでRSpecのようなDSLを作るには？」をテーマに選んだきっかけです。


## DSLとしてのRSpecとQuick

以下はRSpecで書いたテストコードの例です:

```ruby
describe 'Swift' do

  context Biology do
    before(:each) { @swift = Biology::Swift.new }

    it 'is a kind of swallow' do
      expect(@swift.description).to eq 'a kind of swallow'
    end
  end

  context SoftwareTechnology do
    before(:each) { @swift = SoftwareTechnology::Swift.new }

    it 'is a programming Language' do
      expect(@swift.description).to eq 'a programming Language'
    end
  end
end
```

これもRubyプログラムの一種ではあるのですが、「Swiftとは、生物学の文脈では、つばめの一種である。ソフトウェア技術の文脈では、プログラミング言語のひとつである。」と読み下せるように意識して書いています。Swiftの仕様・振舞いを記述していると考えてもよいでしょう。

このように、ある目的(RSpecの場合は[BDD](http://ja.wikipedia.org/wiki/ビヘイビア駆動開発))に特化したコードを書くための言語を[DSL](http://ja.wikipedia.org/wiki/ドメイン固有言語)(=Domain Specific Language)と呼びます。RSpecは、RubyをベースにしたDSLだということが言えます。

では次に、同じものをQuickで書いてみましょう:

```swift
import Quick
import Nimble

class SwiftSpec: QuickSpec {
  override func spec() {

    describe("Swift") {

      context("Biology") {
        var swift: Biology.Swift!
        beforeEach { swift = Biology.Swift() }

        it("is a kind of swallow") {
          expect(swift.description).to(equal("a kind of swallow"))
        }
      }

      context("SoftwareTechnology") {
        var swift: SoftwareTechnology.Swift!
        beforeEach { swift = SoftwareTechnology.Swift() }

        it("is a programming Language") {
          expect(swift.description).to(equal("a programming Language"))
        }
      }
    }
  }
}
```

基本的にはRSpecで書いたものとだいたい同じなのですが、Swift言語のキーワード(class, override, func)が混じっている点や、テストコードがSwift言語のclass定義、メソッド定義の中に書かれている点が、RSpecの場合と比べてDSLの色合いを弱めてしまっているのが残念だなと思いました。

RSpecのように、Swift言語のクラス定義やメソッド定義を省略して、describe以下だけを書けるようにした方がDSLとして自然です:

```swift
import Quick
import Nimble

describe("Swift") {

  context("Biology") {
    var swift: Biology.Swift!
    beforeEach { swift = Biology.Swift() }

    it("is a kind of swallow") {
      expect(swift.description).to(equal("a kind of swallow"))
    }
  }

  context("SoftwareTechnology") {
    var swift: SoftwareTechnology.Swift!
    beforeEach { swift = SoftwareTechnology.Swift() }

    it("is a programming Language") {
      expect(swift.description).to(equal("a programming Language"))
    }
  }
}
```

QuickはなんでRSpecのようになっていないのだろう、そういう風にできないものかということを探ってみました。

## 結論

途中経過をはしょりますが、結論としては、その気になれば、Quickを改造してRSpec並のDSLを書けるようにすることは可能ではないかと思われます。

詳しくは、Swiftで捨てDSLを構成してみた [spec_modoki.swift](https://github.com/hisa/SwiftLearnTalk/blob/master/20150606/spec_modoki.swift) と、その元になった [spec_modiki.rb](https://github.com/hisa/SwiftLearnTalk/blob/master/20150606/spec_modoki.rb) を見てください。
