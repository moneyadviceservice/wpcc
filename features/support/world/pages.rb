module World
  module Pages
    %w(landing your_details your_contributions your_results).each do |page|
      define_method("#{page}_page") do |*args|
        page_name = "#{page}_page".capitalize.camelize
        "UI::#{page_name}".constantize.new(*args)
      end
    end
  end
end
World(World::Pages)
