module ApplicationHelper
  def navbar_brand_text
    case controller_name
    when 'groups'
      groups_text
    when 'group'
      @group.name
    when 'entities'
      entities_text
    when 'entity'
      @entity.name
    else
      controller_name.humanize.titleize
    end
  end

  def format_currency(amount)
    "₦#{amount}"
  end

  private

  def groups_text
    if params[:id]
      if action_name == 'edit'
        "Editing Category: #{@group.name}"
      else
        "Transactions for Category: #{@group.name}"
      end
    elsif action_name == 'new'
      '« New Category »'
    else
      'Expense Categories'
    end
  end

  def entities_text
    if params[:id]
      if action_name == 'edit'
        "Editing Transaction: #{@entity.name}"
      else
        "Transaction: #{@entity.name}"
      end
    elsif action_name == 'new'
      '« New Transaction »'
    else
      'All Transactions'
    end
  end
end
