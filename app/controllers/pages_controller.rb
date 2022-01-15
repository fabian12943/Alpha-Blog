require 'faker'

class PagesController < ApplicationController

  def home
    cardsToCreate = 8
    @names = []
    @dates = []
    @titles = []
    @descriptions = []

    cardsToCreate.times do |i|
      @names << Faker::Name.name
      @dates << rand(2.years).seconds.ago.strftime('%a., %d %b %Y, %H:%M:%S')
      @titles << Faker::Lorem.sentence(word_count: 6)
      @descriptions << Faker::Lorem.paragraph(sentence_count: 15)
    end
  end

end
