FactoryGirl.define do
  factory :url do
    address 'http://test.com'
  end

  factory :no_file_url, class: Url do
    address 'http://nofile.com'
  end

end