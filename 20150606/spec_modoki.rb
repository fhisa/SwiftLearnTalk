## RSpecのようなRubyベースのDSLライブラリの簡単な構成例
##
## このコードの前半部分では、RSpecもどきの簡単なDSLライブラリを
## プログラムしています。後半部分は、前半で作ったライブラリを
## 使ってDSLを記述しています。
##
## (注) DSL = Domain Specific Language
## (注) このコードは、このままでは実用性はゼロです


##########################################################
###### 以下、RSpecもどきのDSLライブラリのプログラム ######

class TinySpec

  @@instance = nil

  def TinySpec.instance
    @@instance ||= TinySpec.new
  end

  def initialize
    @stack = []
    @results = []
  end

  def describe(desc, &block)
    @stack.push("describe #{desc}")
    block.call
    @stack.pop
  end

  def context(cont, &block)
    @stack.push("context #{cont}")
    block.call
    @stack.pop
  end

  def it(str, &block)
    @stack.push("it #{str}")
    value = block.call
    name = @stack.join(', ')
    @stack.pop
    result = "#{name} => #{value}"
    @results.push(result)
    result
  end
end

def describe(desc, &block)
  TinySpec.instance.describe(desc, &block)
end

def context(cont, &block)
  TinySpec.instance.context(cont, &block)
end

def it(str, &block)
  result = TinySpec.instance.it(str, &block)
  puts result
end


############################################
###### 以下、RSpecもどきDSLによる記述 ######

describe "Swift" do
  context "of software engineering" do
    it "is a programming language" do
      true
    end
    it "is a kind of swallow" do
       false
     end
  end
  context "of biology" do
    it "is a programming language" do
       false
     end
    it "is a kind of swallow" do
      true
    end
  end
end


######################
###### 実行結果 ######

## describe Swift, context of software engineering, it is a programming language => true
## describe Swift, context of software engineering, it is a kind of swallow => false
## describe Swift, context of biology, it is a programming language => false
## describe Swift, context of biology, it is a kind of swallow => true
