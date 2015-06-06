## Ruby用のBDDライブラリ RSpec による振舞いの記述例
##
## このコードの前半部分でプログラムした２種類のSwiftクラスの振舞いを
## 後半部分(describe 'Swift' の行以降)でRSpecを使って定義しています。
##
## 後半部分は振舞いを記述するためのDSL(Domain Specific Language)
## として見ることができます。


############################################################################
###### 以下、２種類のSwiftクラスのプログラム(RSpecで振舞い定義の対象) ######

## 生物学上のSwiftクラス
module Biology
  class Swift
    attr_reader :description
    def initialize
      @description = 'a kind of swallow'
    end
  end
end

## ソフトウェア技術上のSwiftクラス
module SoftwareTechnology
  class Swift
    attr_reader :description
    def initialize
      @description = 'a programming language'
    end
  end
end


#######################################
###### 以下、RSpecでの振舞い定義 ######

describe 'Swift' do

  before(:each) do
    @biological_description = 'a kind of swallow'
    @software_technological_description = 'a programming language'
  end

  context Biology do
    before(:each) { @swift = Biology::Swift.new }

    it "is #{@biological_description}" do
      expect(@swift.description).to eq @biological_description
    end
    it "is not #{@software_technological_description}" do
      expect(@swift.description).not_to eq @software_technological_description
    end
  end

  context SoftwareTechnology do
    before(:each) { @swift = SoftwareTechnology::Swift.new }

    it "is not #{@biological_description}" do
      expect(@swift.description).not_to eq @biological_description
    end
    it "is #{@software_technological_description}" do
      expect(@swift.description).to eq @software_technological_description
    end
  end
end
