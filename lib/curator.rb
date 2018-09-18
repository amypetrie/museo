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

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
    photo.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    #array of artists with more than 1
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
    #array of photos taken by a photographer from that country
  end

end
