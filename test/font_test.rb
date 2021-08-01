# frozen_string_literal: true

require "test/unit"
require_relative "../lib/font_kit"

module FontKit
  class FontTest < Test::Unit::TestCase

    def test_style
      font = FontKit::Font.from_path(File.expand_path("fixtures/Roboto-Regular.ttf", __dir__), 0)

      assert { font.properties.style == :normal }
    end

    def test_weight
      font = FontKit::Font.from_path(File.expand_path("fixtures/Roboto-Regular.ttf", __dir__), 0)

      assert { font.properties.weight == 400.0 }
    end

    def test_stretch
      font = FontKit::Font.from_path(File.expand_path("fixtures/Roboto-Regular.ttf", __dir__), 0)

      assert { font.properties.stretch == 1.0 }
    end

  end
end
