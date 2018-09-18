require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/artist'
require './lib/photograph'

class PhotographTest < Minitest::Test

  def test_it_exists
    attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "4",
      year: "1954"
    }
    photo = Photograph.new(attributes)

    assert_instance_of Photograph, photo
  end

  def test_it_has_attributes
    attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "4",
      year: "1954"
    }
    photo = Photograph.new(attributes)

    assert_equal "1", photo.id
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", photo.name
    assert_equal "4", photo.artist_id
    assert_equal "1954", photo.year
  end
end
