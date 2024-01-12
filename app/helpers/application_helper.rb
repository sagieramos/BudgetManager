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
    when 'users'
      users_text
    else
      controller_name.humanize.titleize
    end
  end

  def format_currency(amount)
    "₦#{amount}"
  end

  def material_icon_link(path)
    link_to(content_tag(:button, content_tag(:span, 'arrow_back_ios', class: "material-symbols-outlined").html_safe, type: "button", class: "navbar-toggler"), path)
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

  def users_text
    return unless params[:id]

    if action_name == 'edit'
      'Update profile'
    else
      "Hi #{current_user.name.split.first}"
    end
  end
end
