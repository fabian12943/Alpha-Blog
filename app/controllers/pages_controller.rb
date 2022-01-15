require 'faker'

class PagesController < ApplicationController

  def home
    amount_of_cards = 8
    @names = []
    @dates = []
    @titles = []
    @descriptions = []

    amount_of_cards.times do |i|
      @names << Faker::Name.name
      @dates << rand(2.years).seconds.ago.strftime('%a., %d %b %Y, %H:%M:%S')
      @titles << Faker::Lorem.sentence(word_count: 6)
      @descriptions << Faker::Lorem.paragraph(sentence_count: 15)
    end
  end

end
