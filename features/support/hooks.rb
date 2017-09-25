Before do
  set_language(:en)
end

Before('@welsh') do
  set_language(:cy)
end

Before('@javascript') do
  @javascript = true
end