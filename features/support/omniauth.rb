Before("@omniauth_test") do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({'uid' => '65', 'provider' => 'facebook', 'info' => {'email' => 'machete@yourgarganta.mx', 'name' => 'Denny Trejo'}})
end

After("@omniauth_test") do
  OmniAuth.config.test_mode = false
end
