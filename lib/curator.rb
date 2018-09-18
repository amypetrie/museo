require 'pry'
require './lib/file_io'

class Curator < FileIO

  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo_attributes)
    photo_object = Photograph.new(photo_attributes)
    @photographs << photo_object
  end

  def add_artist(artist_attributes)
    artist_object = Artist.new(artist_attributes)
    @artists << artist_object
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photo|
      photo.id == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
    photo.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    photos_by_id= @photographs.group_by do |photo|
      photo.artist_id
    end
    artist_ids = photos_by_id.map do |id, photos|
      if photos.length > 1
        id
      end
    end.compact!
    artist_ids.map do |id|
      find_artist_by_id(id)
    end
  end

  def photographs_taken_by_artists_from(string)
    photos = []
    artists_from_country = @artists.map do |artist|
      if artist.country == string
        artist
      end
    end.compact!
    photos << artists_from_country.map do |artist|
      find_photographs_by_artist(artist)
    end.flatten!
    photos.flatten.compact
  end

  def load_photographs(file)
    photo_attributes = FileIO.load_photographs(file)
    photo_attributes.each do |attributes|
      add_photograph(attributes)
    end
  end

  def load_artists(file)
    artist_attributes = FileIO.load_artists(file)
    artist_attributes.each do |attributes|
      add_artist(attributes)
    end
  end

  def photographs_taken_between(year_range)
    @photographs.map do |photo|
      if year_range.include? photo.year.to_i
        photo
      end
    end.compact
  end

  def artists_photographs_by_age(artist)
    photos = find_photographs_by_artist(artist)
    photo_hash = photos.group_by do |photo|
      (photo.year.to_i - artist.born.to_i)
    end
    photo_hash.each_pair do |age, photos|
      photo_hash[age] = photos.map {|photo| photo.name }
    end
  end

end
