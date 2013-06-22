# -*- encoding : utf-8 -*-
require 'chuyi_helper/version'
require 'chuyi_helper/railtie' if defined?(Rails)

module ChuyiHelper

	def gender(gender)
		case gender
		when "male"
			"先生"
		when "female"
			"女士"
		else
			"不明"
		end
	end

  #時間簡單格式
  def ymd(datetime)
  	datetime.strftime("%Y/%m/%d")
  end

  def ymdhm(datetime)
  	datetime.strftime("%Y/%m/%d %H:%M")
  end

  def chuyi_status(status, link_path)
    #link_to status(area.status), status_admins_area_path(area), {class: "btn btn-warning", method: :post}
    case status
    when "enabled"
    	raw(link_to("啟動", link_path, {method: :post, class: "btn btn-success"}))
    when "disabled"
    	raw(link_to("取消", link_path, {method: :post, class: "btn btn-warning"}))
    end
  end

  def chuyi_target(target)
  	case target
  	when "_self"
  		"原視窗"
  	when "_blank"
  		"新視窗"
  	end
  end


  #畫面上方的訊息列
  def chuyi_message_box
  	css_class = ""
  	content = ""
  	if flash[:notice]
  		css_class = "alert alert-block"
  		content = flash[:notice]
  	elsif flash[:error]
  		css_class = "alert alert-error"
  		content = flash[:error]
  	elsif flash[:success]
  		css_class = "alert alert-success"
  		content = flash[:success]
  	elsif flash[:info]
  		content = flash[:info]
  		css_class = "alert alert-info"
  	else
  		return nil
  	end
  	content_tag(:div, class: css_class) do
  		if flash[:error]
  			content = %{<h4>OOPS！需要您的注意！</h4>} + content
  		end
  		(link_to(raw("&times;"), "", {class: "close", "data-dismiss" => "alert"})) +
  		raw(content)
  	end
  end

  def sign_in_and_authentication
    #如果已經登入
    if session[:admin]
    	content_tag(:li) do
    		link_to(raw(%{<i class="icon-off"></i>登出}), admin_logout_path, :method => :delete)
    	end
    end
  end

  #主選單
  def chuyi_menu_item(controller, menu_name, path)
  	#判斷路徑與css
  	controller_name == controller ? klass = "active" : ""
  	content_tag(:li, class: klass) do
  		link_to(menu_name, path)
  	end
  end
end
