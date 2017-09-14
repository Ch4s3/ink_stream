# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  name = Faker::Company.name.downcase.tr(" ","_").tr(",","")
  site_url = "https://#{name}.test"
  params = {
    name: name,
    site: site_url,
    description: Faker::Lorem.paragraph(3)
  }
  pub = Publication.create(params)

  20.times do
    title = Faker::Seinfeld.quote

    Article.create(
      title: title,
      link: "#{site_url}/#{CGI::escape(title)}",
      date:  Random.rand(0..14).days.ago.to_date,
      publication: pub
    )
  end
end
