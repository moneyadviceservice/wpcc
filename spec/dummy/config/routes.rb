Rails.application.routes.draw do
  scope '/:locale', locale: /en|cy/ do
    mount Wpcc::Engine => '/tools/workplace-pension-contribution-calculator'
  end

  root to: redirect('/en/tools/workplace-pension-contribution-calculator')
end
