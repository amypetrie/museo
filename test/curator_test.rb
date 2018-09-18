require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/artist'
require './lib/photograph'
require './lib/curator'
require './lib/file_io'

class CuratorTest < Minitest::Test

  def test_it_exists
    curator = Curator.new

    assert_instance_of Curator, curator
  end

  def test_it_starts_with_empty_collections_of_photos_and_artists
    curator = Curator.new

    assert_equal [], curator.photographs
    assert_equal [], curator.artists
  end

  def test_adding_photographs_adds_photos_to_photo_instance_variable
    curator = Curator.new
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }

    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    assert_instance_of Photograph, curator.photographs.first
    assert_equal 2, curator.photographs.length
  end

  def test_adding_artists_adds_artists_to_artists_instance_variable
    curator = Curator.new
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_instance_of Artist, curator.artists.first
    assert_equal 2, curator.artists.length
  end

  def test_find_artist_by_id_returns_correct_artist_object
    curator = Curator.new
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    artist = curator.find_artist_by_id("1")

    assert_instance_of Artist, artist
    assert_equal "1", artist.id
  end

  def test_find_photo_by_id_returns_correct_photo_object
    curator = Curator.new
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }

    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    photo = curator.find_photograph_by_id("2")

    assert_instance_of Photograph, photo
    assert_equal "2", photo.id
  end

  def test_find_photo_by_artist_returns_array_of_artist_photos
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    diane_arbus = curator.find_artist_by_id("3")
    photo_array = curator.find_photographs_by_artist(diane_arbus)

    assert_instance_of Photograph, photo_array[0]
    assert_equal "3", photo_array[0].artist_id
  end


  def test_artists_with_multiple_photos_returns_array_of_artists
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    diane_arbus = curator.find_artist_by_id("3")

    assert_equal diane_arbus, curator.artists_with_multiple_photographs.first
    assert_equal 1, curator.artists_with_multiple_photographs.length
  end

  def test_photographs_taken_by_artists_from_place_returns_correct_photo_array
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    us_photos = curator.photographs_taken_by_artists_from("United States")

    assert_instance_of Photograph, us_photos[0]
    assert_equal 3, us_photos.length
    assert us_photos[0].artist_id == "2"
    assert_equal [], curator.photographs_taken_by_artists_from("Argentina")
  end

  def test_load_photographs_creates_photo_objects_for_curator_photos
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')

    assert_instance_of Photograph, curator.photographs[0]
    assert_equal 4, curator.photographs.length
  end

  def test_load_artists_creates_artist_objects_for_curator_artists
    curator = Curator.new
    curator.load_artists('./data/artists.csv')

    assert_instance_of Artist, curator.artists[0]
    assert_equal 6, curator.artists.length
  end

  def test_photos_taken_between_range_returns_correct_photo_array
    curator = Curator.new
    curator.load_artists('./data/artists.csv')
    curator.load_photographs('./data/photographs.csv')

    assert_equal 2, curator.photographs_taken_between(1950..1965).length
    assert_instance_of Photograph, curator.photographs_taken_between(1950..1965)[0]
  end

  def test_artists_photos_by_age_returns_hash_of_artist_age_at_the_time_and_photos_name
    curator = Curator.new
    curator.load_artists('./data/artists.csv')
    curator.load_photographs('./data/photographs.csv')
    diane_arbus = curator.find_artist_by_id("3")
    expected = {44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park"}

    assert_equal expected, curator.artists_photographs_by_age(diane_arbus)
  end

end
