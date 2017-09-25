module ApplicationHelper
	def show_messages_flash(condition, attributes = {}, &block)
    unless condition
      attributes["class"] = "alert-dismissible alert alert-#{attributes[:class_name]}"
    end    
    content_tag("div", attributes, &block)
  end

	def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end    
    content_tag("div", attributes, &block)
  end

  def disabled_button_checkout_if(condition)
  	disabled = false
    disabled = true if condition    
    
    button_to t('.checkout'), new_order_path, method: :get, disabled: disabled 
  end
end
