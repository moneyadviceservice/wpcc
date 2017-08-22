RSpec.describe Wpcc::PeriodFilterPresenter do
  subject(:presenter) do
    described_class.new(object, view_context: context)
  end

  let(:object) do
    Wpcc::PeriodFilter.new(
      user_input_employee_percent: user_input_employee_percent,
      user_input_employer_percent: user_input_employer_percent
    )
  end

  let(:context) { ActionController::Base.new.view_context }

  describe '#contribution_percents_explanation' do
    subject(:contribution_percents_explanation) do
      presenter.contribution_percents_explanation
    end

    context 'when user inputs are less than legal minimums' do
      let(:user_input_employee_percent) { 1 }
      let(:user_input_employer_percent) { 1 }

      it 'returns nil' do
        expect(contribution_percents_explanation).to be_nil
      end
    end

    context 'when user inputs are greater than ALL legal minimums' do
      let(:user_input_employee_percent) { 6 }
      let(:user_input_employer_percent) { 4 }

      it 'returns message' do
        expect(contribution_percents_explanation).to eq(
          I18n.t('wpcc.results.large_contribution_percent_for_two_periods')
        )
      end
    end

    context 'when user inputs are between 2nd and 3rd period legal minimums' do
      let(:user_input_employee_percent) { 4 }
      let(:user_input_employer_percent) { 2.5 }

      it 'returns message' do
        expect(contribution_percents_explanation).to eq(
          I18n.t('wpcc.results.large_contribution_percent_for_middle_period')
        )
      end
    end

    context 'when user employee percent is greater than legal minimums' do
      let(:user_input_employee_percent) { 6 }
      let(:user_input_employer_percent) { 1 }

      it 'returns message' do
        expect(contribution_percents_explanation).to eq(
          I18n.t(
            'wpcc.results.employee_large_contribution_percent_for_two_periods'
          )
        )
      end
    end

    context 'when user employer percent is greater than legal minimums' do
      let(:user_input_employee_percent) { 1 }
      let(:user_input_employer_percent) { 4 }

      it 'returns message' do
        expect(contribution_percents_explanation).to eq(
          I18n.t(
            'wpcc.results.employer_large_contribution_percent_for_two_periods'
          )
        )
      end
    end
  end
end
