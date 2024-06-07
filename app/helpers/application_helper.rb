# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
    when 'notice'
      'success' # 緑色
    when 'alert'
      'danger'  # 赤色
    else
      flash_type.to_s
    end
  end
end
