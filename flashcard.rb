# Main file for your code.
require 'CSV'

class Card
		attr_reader :definition, :answer
		def initialize(definition, answer)
			@definition = definition
			@answer = answer
		end
	end
	
	class CardHouse
		attr_reader :cards
		def initialize
			@cards = []
		end
		def randomise!
			@cards.shuffle!
		end
	end
	
	class ParsyMcParseFace
		attr_reader :cards
		def initialize(file)
			@file = file
		end
	
		def read(object)
			array = []
			File.foreach(@file) do |row|
				array << row.split("\n").join unless row.split("\n") == []
	    end
	    array.each_with_index do |value, index|
	    	if ((index + 1) % 2) != 0
	    		card = Card.new(value, array[index + 1])
	    		object.cards << card
	    	next if ((index + 1) % 2) == 0
	    	end
	    end
		end
	
	end
	
	cardhouse = CardHouse.new
	parser = ParsyMcParseFace.new("flashcard_samples.txt")
	parser.read(cardhouse)
	cardhouse.randomise!
	puts ""
	puts "I'll flash you, and you'll Ruby me. Cool?"
	
	answer = nil
	while answer != "quit"
		puts ""
		puts "Definition"
		puts cardhouse.cards[0].definition
	
		answer = gets.chomp
		correct = false
		tries = 0
		while correct != true && tries < 2 && answer != "quit"
			if answer == cardhouse.cards[0].answer
				puts "Correct! Next."
				correct = true
			else
				puts "Incorrect! Try Again."
				puts ""
				answer = gets.chomp
				tries += 1
				puts "Too many tries. Answer is '#{cardhouse.cards[0].answer}'. Moving on." if tries == 2
			end
		end
		cardhouse.cards.shift
	end	