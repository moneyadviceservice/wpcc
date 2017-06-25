module World
  module Pages
    %w(your_details your_contributions).each do |page|
      define_method("#{page}_page") do |*args|
        "UI::#{page.camelize}".constantize.new(*args)
      end
    end
  end
end
World(World::Pages)
