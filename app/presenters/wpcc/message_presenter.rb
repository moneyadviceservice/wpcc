module Wpcc
  class MessagePresenter < Presenter
    def manually_opt_in_message?
      text == :manually_opt_in && manually_opt_in?
    end

    def manually_opt_in_message
      t('wpcc.contributions.manually_opt_in')
    end

    def tax_relief_warning?
      salary_below_tax_relief_threshold?
    end

    def tax_relief_warning
      t('wpcc.results.tax_relief_warning_html')
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
        t('wpcc.contributions.your_contribution_tip_lt5876')
      else
        t('wpcc.contributions.your_contribution_tip')
      end
    end

    def employer_contribution_tip
      return if salary_below_pension_limit?
      t('wpcc.contributions.employer_contribution_tip')
    end
  end
end
