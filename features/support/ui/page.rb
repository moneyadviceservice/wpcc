module UI
  class Page < SitePrism::Page
    def self.engine_path
      '/en/tools/'
    end

    element :intro, '.intro'
  end
end
