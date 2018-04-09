module Wpcc
  class MessagePresenter < Presenter
    def self.opt_in_thresholds
      config = {}

      ::Wpcc::SalaryMessage::OPT_IN_THRESHOLDS.each do |threshold, frequencies|
        frequencies.each do |frequency, frequency_threshold_value|
          config[frequency] ||= {}
          config[frequency][threshold] = frequency_threshold_value
        end
      end

      config.to_json
    end

    def manually_opt_in_message?
      text == :manually_opt_in && manually_opt_in?
    end

    def manually_opt_in_message
      t('wpcc.contributions.manually_opt_in')
    end

    def salary_below_pension_limit_message?
      salary_below_pension_limit?
    end

    def salary_below_pension_limit_message
      t('wpcc.details.callout__below_lower_threshold')
    end

    def tax_relief_warning?
      salary_below_tax_relief_threshold?
    end

    def tax_relief_warning
      t('wpcc.results.tax_relief_warning_html')
    end

    def salary_near_pension_limit_message?
      salary_near_pension_limit?
    end

    def salary_near_pension_limit_message
      t('wpcc.details.near_pension_limit_message_html')
    end

    def salary_near_manual_opt_in_limit_message?
      salary_near_manual_opt_in_limit?
    end

    def salary_near_manual_opt_in_limit_message
      t('wpcc.details.near_manual_opt_in_limit_message_html')
    end

    def your_details_summary(hash)
      salary = view_context.number_with_delimiter(hash[:salary], delimiter: ',')
      preference = hash[:contribution_preference].downcase
      [
        t('wpcc.details.section__heading.age', age: hash[:age]),
        t("wpcc.details.section__heading.gender_#{hash[:gender].downcase}"),
        t("wpcc.details.section__heading.salary_#{hash[:salary_frequency]}",
          salary: salary),
        t("wpcc.details.section__heading.contribution_#{preference}")
      ].join(', ')
    end

    def minimum_contribution?
      session[:contribution_preference] == 'minimum'
    end

    def show_above_max_contribution?
      above_max_contribution?
    end

    def above_max_contribution
      amount = formatted_currency(
        Wpcc::SalaryMessage::TAX_RELIEF_MAX_CONTRIBUTION,
        precision: 0
      )

      t('wpcc.contributions.contribution_gt40000_warning', amount: amount)
    end

    def employee_contribution_tip
      if salary_below_pension_limit?
        t('wpcc.contributions.your_contribution_tip_below_lower_threshold')
      else
        t(
          'wpcc.contributions.your_contribution_tip',
          percentage: employee_percentage
        )
      end
    end

    def employer_contribution_tip
      return if salary_below_pension_limit?

      t(
        'wpcc.contributions.employer_contribution_tip',
        percentage: employer_percentage
      )
    end

    def employee_percentage
      contribution_calculator.employee_percent
    end

    def employer_percentage
      contribution_calculator.employer_percent
    end

    def contribution_calculator
      Wpcc::YourContributionGenerator.new(
        contribution_preference: session[:contribution_preference],
        salary_per_year: salary_per_year
      ).contribution_calculator
    end

    def salary_per_year
      SalaryPerYear.new(
        salary: session[:salary],
        salary_frequency: session[:salary_frequency]
      ).convert
    end
  end
end
