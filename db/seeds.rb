# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  email: 'test@is.test',
  password: '1234Password'
)
10.times do
  name = "#{Faker::Address.unique.city} #{Faker::Hipster.unique.word.capitalize}"
  url_safe_name = name.downcase.tr(" ","_").tr(",","")
  site_url = "https://www.#{url_safe_name}.test"
  params = {
    name: name,
    site: site_url,
    description: Faker::Lorem.paragraph(3)
  }
  pub = Publication.create(params)

  random_number = Random.rand(200..500)
  random_number.times do
    title = Faker::Hipster.sentence
    date = Random.rand(0..14).days.ago.to_date
    Article.create(
      title: title,
      link: "#{site_url}/#{CGI::escape(title)}",
      date:  date,
      excerpt: Faker::Lorem.paragraph(36),
      publication: pub
    )
  end
end
