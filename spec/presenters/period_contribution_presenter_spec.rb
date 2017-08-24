RSpec.describe Wpcc::PeriodContributionPresenter do
  subject do
    described_class.new(period_contribution, view_context: view_context)
  end

  let(:period_contribution) { Wpcc::PeriodContribution.new }
  let(:view_context) { double(:view_context) }

  before do
    allow(subject).to receive(:view_context)
      .and_return(ActionController::Base.new.view_context)
  end

  describe '#title' do
    it 'converts the name to a more readable format' do
      period_contribution.name = 'april_2017_march_2018'
      expect(subject.title).to eq('Now')
    end
  end

  describe '#formatted_employee_contribution' do
    let(:period_contribution) { double(employee_contribution: 1.0) }

    it 'formats values with two decimal values' do
      expect(subject.formatted_employee_contribution).to eq('£1.00')
    end
  end

  describe '#formatted_employer_contribution' do
    let(:period_contribution) { double(employer_contribution: 2.5) }

    it 'formats values with two decimal values' do
      expect(subject.formatted_employer_contribution).to eq('£2.50')
    end
  end

  describe '#formatted_tax_relief' do
    let(:period_contribution) { double(tax_relief: 1.99) }

    it 'returns a message with the formatted value' do
      expect(subject.formatted_tax_relief).to eq(
        '(includes tax relief of £1.99)'
      )
    end
  end

  describe '#employer_frequency_heading' do
    let(:salary_frequency) { Wpcc::SalaryFrequency.new(attributes) }
    let(:attributes) do
      {
        locale: locale,
        params_salary_frequency: nil,
        session_salary_frequency: 'fourweeks'
      }
    end

    context 'for english fourweekly salary frequency' do
      let(:locale) { 'en' }
      it 'returns the english translation for 4-weekly' do
        expect(subject.employer_frequency_heading(salary_frequency))
          .to eq('Employer\'s 4-weekly contribution')
      end
    end

    context 'for welsh fourweekly salary frequency' do
      let(:locale) { 'cy' }

      before { I18n.locale = :cy }
      after { I18n.locale = :en }

      it 'returns the welsh translation for 4-weekly' do
        expect(subject.employer_frequency_heading(salary_frequency))
          .to eq('Cyfraniad y cyflogwr bob 4 wythnos')
      end
    end
  end
end
