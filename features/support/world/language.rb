module World
  module Language
    def language
      @language
    end

    def set_language(code)
      @language = code
    end
  end
end

World(World::Language)
