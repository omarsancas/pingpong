module GamesHelper
  def opponents
    User.where(%{id <> ?}, current_user.id).to_a.map! { |u| [ u.email, u.id ] }
  end

  def css_error_class_for(*attributes)
    if attributes.any? { |attribute| @game.errors.include?(attribute) }
      " has-error"
    end
  end

  def error_helper_for(attribute, css_class = 'col-sm-3')
    if @game.errors.include?(attribute)
      return <<-HTML.squish.html_safe
        <div class="#{css_class}">
          <span id="#{attribute}Helper" class="help-block">
            #{@game.errors.full_messages_for(attribute).first}
          </span>
        </div>
      HTML
    end
  end
end
