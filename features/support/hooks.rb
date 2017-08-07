Before do
  set_language(:en)
  @example_gender = 'Female'
  @example_frequency = 'per Year'
end

Before('@welsh') do
  set_language(:cy)
  @example_gender = 'Benywaidd'
  @example_frequency = 'y Flwyddyn'
end