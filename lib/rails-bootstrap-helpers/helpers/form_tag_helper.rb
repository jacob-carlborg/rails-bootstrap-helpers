module RailsBootstrapHelpers::Helpers::FormTagHelper
  # Renders a Bootstrap button tag. This method behaves just as
  # <tt>button_tag</tt> but will render a Bootstrap styled button tag instead.
  #
  # @params value [String] the text of the button
  # @params type_or_options [String, Symbol, Hash] the type of the button.
  #         Adds a "type" attribute to the tag. If a hash, it's considered to
  #         be options and type will be :button.
  #
  # @params options [Hash] a hash of options
  #
  # @option options [String, Symbol] :style the style of the button
  # @option options ["large", "small", "mini"] :size the size of the button
  # @option options [Boolean] :disabled (false) if the button should be disabled or not
  # @option options [String] :icon the name of an icon to render on the button
  # @option options ["left", "right"] :icon_position ("left") the post of the icon, if present
  # @option options [Boolean] :icon_invert (left) if the color of the icon should be inverted
  def bs_button_tag (value, type_or_options = :button, options = {}, &block)
    if type_or_options.is_a?(Hash)
      options = type_or_options
      type_or_options = :button
    end

    options = options.merge type: type_or_options
    RailsBootstrapHelpers::Renderers::ButtonRenderer.new(self, :button, value, options, &block).render
  end

  # Renders a Boolean submit tag. This method behaves just as
  # <tt>submit_tag</tt> but will render a Bootstrap styled submit tag instead.
  #
  # @param value [String] the text of the submit tag
  # @param options [Hash] a hash of options
  #
  # @option options [String, Symbol] :style the style of the button
  # @option options ["large", "small", "mini"] :size the size of the button
  #
  # All the other options are passed straight through to the underlying
  # <tt>submit_tag</tt> method.
  def bs_submit_tag (value, options = {})
    bs_button_tag value, :submit, options
  end
end
