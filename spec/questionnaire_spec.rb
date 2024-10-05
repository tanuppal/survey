require 'rspec'
require 'pstore'
require_relative '../questionnaire'

RSpec.describe 'Survey' do
  let(:store) { PStore.new("test_store.pstore") }

  before do
    store.transaction do
      store[:runs] = 0
      store[:total_yes] = 0
    end
  end

  after do
    store.transaction do
      store[:runs] = 0
      store[:total_yes] = 0
    end
  end

  describe '#do_prompt' do
    it 'counts the number of Yes answers' do
      allow($stdin).to receive(:gets).and_return("Yes\n", "No\n", "Y\n", "N\n", "Yes\n")
      
      yes_count = do_prompt
      expect(yes_count).to eq(3)
    end

    it 'validates user input' do
      allow($stdin).to receive(:gets).and_return("maybe\n", "Yes\n")
      
      expect { do_prompt }.to output(/Please answer with 'Yes' or 'No'/).to_stdout
    end
  end

 describe '#do_report' do
    it 'calculates the correct rating for a single run' do
      yes_count = 3
      total_questions = QUESTIONS.size
      do_report(yes_count, total_questions) # Pass total_questions

      store.transaction(true) do
        expect(store[:runs]).to eq(1)
        expect(store[:total_yes]).to eq(3)
      end

      average_rating = (100.0 * store[:total_yes] / (total_questions * store[:runs])).round(2)
      expect(average_rating).to eq(60.0)
    end

    it 'calculates overall average rating after multiple runs' do
      total_questions = QUESTIONS.size
      do_report(3, total_questions) # 3 Yes
      do_report(2, total_questions) # 2 Yes

      store.transaction(true) do
        expect(store[:runs]).to eq(2)
        expect(store[:total_yes]).to eq(5)
      end

      average_rating = (100.0 * store[:total_yes] / (total_questions * store[:runs])).round(2)
      expect(average_rating).to eq(50.0)
    end
  end

  describe '#run_survey' do
    it 'continues the survey if the user wants to take it again' do
      allow($stdin).to receive(:gets).and_return("Yes\n", "No\n", "yes\n", "no\n")

      expect { run_survey(store) }.to change {
        store.transaction(true) { store[:runs] }
      }.by(2) # Expects to run the survey twice
    end

    it 'stops the survey if the user does not want to take it again' do
      allow($stdin).to receive(:gets).and_return("Yes\n", "No\n", "no\n")

      expect { run_survey(store) }.to change {
        store.transaction(true) { store[:runs] }
      }.by(1) # Expects to run the survey once
    end
  end
end
