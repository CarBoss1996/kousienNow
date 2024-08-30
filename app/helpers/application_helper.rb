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

  def page_title(title)
    base_title = '甲子園NOW!'
    title.empty? ? base_title : title + " | " +  base_title
  end

  def admin_page_title(title, admin = false)
    base_title = if admin
                    'Article APP（管理画面）'
                 else
                    'Article APP'
                 end
    title.empty? ? base_title : title + " | " +  base_title
  end
end
