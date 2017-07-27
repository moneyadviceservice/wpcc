module World
  module Language
    def language_to_locale(language = 'English')
      { 'English' => :en, 'Welsh' => :cy }[language]
    end
  end
end
World(World::Language)