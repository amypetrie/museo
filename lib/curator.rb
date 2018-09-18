require 'pry'
class Curator

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

end
