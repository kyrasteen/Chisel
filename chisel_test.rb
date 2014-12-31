require 'minitest/autorun'
require 'minitest/pride'
require './chisel'

class ChiselTest < Minitest::Test

  def setup
    @parser = Chisel.new
    @document = "#this is a string"
    @para = "I love ice cream"
  end

  def test_it_creates_a_chisel
    chisel = Chisel.new
  end

  def test_it_recognizes_linebreak
    doc = "Food:
          1.soup"
    list = @parser.line_break(doc)
    assert_equal "Food:\n1.soup", list
  end

  def test_it_has_a_method_paragraph
    para = @parser.paragraph(@para)
    assert_equal "<p>I love ice cream</p>", para
  end

  def test_it_has_a_method_chunkify
    doc = "This is great

    woohoo"
    assert_equal ["This is great", "woohoo"], @parser.chunkify(doc)
  end

  def test_it_has_a_method_parse
    skip
    assert_equal "<h1>this is a string</h1>", @parser.parse(@document)
  end

  def test_it_parses_h2_and_h3
    document = "###this is a string"
    assert_equal "<h3>this is a string</h3>", @parser.header(document)
  end

  def test_it_parses_emphasize
    document = "*love*"
    assert_equal "<em>love</em>", @parser.emphasize(document)
  end

  def test_it_parses_strong
    document = 'I **love** ice cream'
    assert_equal "<p>I <strong>love</strong> ice cream</p>", @parser.strong(document)
  end

  def test_it_parses_unordered_lists
    document = 'food:
    * soup
    * bread
    * cheese'
    assert_equal "<ul>food:
    <li>soup</li>
    <li>bread</li>
    <li>cheese</li>
    </ul>", @parser.unordered_lists(document)
  end

  def test_it_parses_ordered_lists
    skip

  end

  def test_it_parses
    skip
    document = "#Ice cream
    ##Flavors:
    1.chocolate
    2.chunky monkey
    3.caramel
    I *love* **ice cream**!"
    #assert
  end
end
