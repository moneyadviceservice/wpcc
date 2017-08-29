module Wpcc
  class PeriodContributionPresenter < Presenter
    def title
      t("wpcc.results.period_title.#{name}")
    end

    def employee_contribution_data
      object.employee_contribution
    end

    def employer_contribution_data
      object.employer_contribution
    end

    def tax_relief_data
      object.tax_relief
    end

    def formatted_employee_contribution
      formatted_contribution(object.employee_contribution)
    end

    def formatted_employer_contribution
      formatted_contribution(object.employer_contribution)
    end

    def formatted_tax_relief
      "(includes tax relief of #{formatted_contribution(object.tax_relief)})"
    end

    def formatted_total_contributions
      formatted_contribution(object.total_contributions)
    end

    def employer_frequency_heading(salary_frequency)
      # rubocop:disable Lint/StringConversionInInterpolation
      default_i18n_key = 'wpcc.results.period.contribution_heading.employers'

      I18n.t(
        "#{default_i18n_key}_#{salary_frequency.to_s}_html",
        default: :"#{default_i18n_key}_html",
        salary_frequency: salary_frequency.to_adj
      )
      # rubocop:enable Lint/StringConversionInInterpolation
    end

    private

    def formatted_contribution(contribution_value)
      number_to_currency(contribution_value, unit: '£', precision: 2)
    end
  end
end
