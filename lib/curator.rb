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
  end

end
