module ApplicationHelper
    def navbar_brand_text
      case controller_name
      when 'groups'
        if params[:id]
          "Transactions for Category: #{@group.name}"
        else
          'Expense Categories'
        end
      when 'group'
        @group.name
      when 'entities'
        if params[:id]
          "Transaction: #{@entity.name}"
        else
          'All Transactions'
        end
      when 'entity'
        @entity.name
      else
        controller_name.humanize.titleize
      end
    end

    def format_currency(amount)
        "₦#{amount}"
    end
  end
  