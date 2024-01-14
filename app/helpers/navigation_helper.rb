module NavigationHelper
  def group_class_active
    'active' if controller_name == 'groups' && action_name == 'index'
  end

  def entity_class_active
    'active' if controller_name == 'entities' && action_name == 'index'
  end

  def new_group_class
    'active' if controller_name == 'groups' && action_name == 'new'
  end

  def new_entity_class
    'active' if controller_name == 'entities' && action_name == 'new'
  end

  def user_class_active
    'active' if controller_name == 'users' && action_name == 'index'
  end
end
