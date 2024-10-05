require "pstore"

STORE_NAME = "tendable.pstore"
store = PStore.new(STORE_NAME)

QUESTIONS = {
  "q1" => "Can you code in Ruby?",
  "q2" => "Can you code in JavaScript?",
  "q3" => "Can you code in Swift?",
  "q4" => "Can you code in Java?",
  "q5" => "Can you code in C#?"
}.freeze

def do_prompt
  yes_count = 0

  QUESTIONS.each do |_, question|
    ans = nil
    
    loop do
      print "#{question} (Yes/No): "
      ans = gets&.chomp&.downcase

      if ans.nil?
        puts "No input received. Please answer with 'Yes' or 'No'."
        next
      end

      if !["yes", "no", "y", "n"].include?(ans)
        puts "Please answer with 'Yes' or 'No'."
      else
        break
      end
    end

    yes_count += 1 if ans.start_with?('y')
  end

  yes_count
end

def do_report(store, yes_count)
  total_questions = QUESTIONS.size
  rating = (100.0 * yes_count / total_questions).round(2)
  
  puts "Your rating for this run: #{rating}%"

  store.transaction do
    store[:runs] ||= 0
    store[:total_yes] ||= 0

    store[:runs] += 1
    store[:total_yes] += yes_count

    # Calculate average rating inside the transaction block
    average_rating = (100.0 * store[:total_yes] / (total_questions * store[:runs])).round(2)
    puts "Overall average rating: #{average_rating}%"
  end
end

# Main execution
loop do
  yes_count = do_prompt
  do_report(store, yes_count)

  print "Do you want to take the survey again? (yes/no): "
  continue = gets&.chomp&.downcase
  break unless continue.start_with?('y')
end
