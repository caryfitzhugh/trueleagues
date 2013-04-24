module DeviseHelper
  def error_messages!(model)
    return '' if model.errors.empty?

    messages = model.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
      count: model.errors.count,
      resource: model.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">x</button>
      <h4>#{sentence}</h4>
      #{messages}
    </div>
    HTML

    html.html_safe
  end
  def devise_error_messages!(model = nil)
    error_messages!(resource)
  end
end
