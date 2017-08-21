module World
  module Language
    def language_code
      @language
    end

    def set_language(code)
      @language = code
    end
  end
end

World(World::Language)
