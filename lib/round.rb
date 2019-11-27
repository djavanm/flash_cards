class Round 
  attr_accessor :deck, :turns, :current_card

  def initialize deck
    @deck = deck
    @turns = []
    @current_card = deck.cards[0]
  end

  def take_turn guess
    new_turn = Turn.new(guess, @current_card)
    @turns.push new_turn
    i = @deck.cards.find_index { |card| card.question == @current_card.question }
    @current_card = @deck.cards[i + 1]
    return new_turn
  end

  def number_correct
    number_correct = 0
    @turns.each do |turn| 
      if turn.correct?
        number_correct +=1
      end
    end
    return number_correct
  end

  def percent_correct 
    ( number_correct.to_f / @turns.count ) * 100
  end

  def percent_correct_by_category category
    category_count = @turns.select { |turn| turn.card.category ==  category }.count
    correct_count = @turns.select { |turn| turn.card.category == category && turn.correct? }.count
    ( correct_count / category_count ) * 100
  end

end