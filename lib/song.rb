require_relative './concerns/findable.rb'
class Song
    extend Concerns::Findable
    attr_accessor :name, :genre #:artist
    attr_reader :artist

    @@all = []
    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if artist

    end
        
    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def self.create(name)
        new_song = self.new(name)
        new_song.save
        return new_song
    end
 
    def self.new_from_filename(file)
        file_array = file.split(/\ - |\./) # everything within / / gets split due to .split with regex / /
        name = file_array[1]
        song = self.find_or_create_by_name(name)
        song.artist = Artist.find_or_create_by_name(file_array[0])
        song.genre = Genre.find_or_create_by_name(file_array[2])
        song
    end

    def self.create_from_filename(name)
        self.new_from_filename(name)
    end

    def save
        @@all << self
    end

    def self.destroy_all
        @@all.clear
    end

    def self.all
        @@all
    end
    # def find_by_name(name)
    #     self.all.detect {|person|} person.name == name}

    # end

    # def find_or_create_by_name(name)
    #     self.find_by_name(name) != nil ? self.find_by_name(name) : self.create(name)
    # end
end

