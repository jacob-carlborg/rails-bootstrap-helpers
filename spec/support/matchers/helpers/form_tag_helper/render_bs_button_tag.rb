RSpec::Matchers.define :render_bs_button_tag do |text, type|
  def options
    @options ||= { }
  end

  def append_style (style)
    " btn-#{style}"
  end

  def cls
    @cls ||= begin
      cls = "btn"
      style = style? ? options[:style] : :default
      cls << " btn-#{style}"
      cls << " btn-#{options[:size]}" if size?
      cls
    end
  end

  def text_with_icon
    if icon?
      cls = "glyphicon glyphicon-#{options[:icon]}"
      cls << " icon-white" if inverted?
      icon = "<span class=\"#{cls}\"></span>"
      default = icon + " " + text

      if icon_position?
        if options[:icon_position].to_s == "right"
          return text + " " + icon
        end
      end

      default
    else
      text
    end
  end

  def html_attributes
    attrs = { class: cls }

    if tooltip?
      if tooltip_position?
        attrs[:"data-placement"] = options[:tooltip_position]
      end

      attrs[:"data-toggle"] = "tooltip"
    end

    attrs[:name] = "button"

    if tooltip?
      attrs[:title] = options[:tooltip]
    end

    attrs.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")
  end

  def expected
    @render_button_expected ||= "<button #{html_attributes} type=\"#{type}\">#{text_with_icon}</button>"
  end

  def got
    @got ||= helper.bs_button_tag(text, type, options)
  end

  def failure_message (is_not)
    ex = is_not ? "expected not" : "expected"
    "#{ex}: #{expected}\n     got: #{got}"
  end

  def text
    @text
  end

  def type
    @type || :button
  end

  def style?
    @style_set
  end

  def size?
    @size_set
  end

  def icon?
    @icon_set
  end

  def inverted?
    @inverted_set
  end

  def icon_position?
    @icon_position_set
  end

  def tooltip?
    options.key?(:tooltip)
  end

  def tooltip_position?
    options.key?(:tooltip_position)
  end

  chain :to do |url|
    @url = url
  end

  chain :with_style do |style|
    options[:style] = style
    @style_set = true
  end

  chain :with_size do |size|
    options[:size] = size
    @size_set = true
  end

  chain :with_icon do |icon|
    options[:icon] = icon
    @icon_set = true
  end

  chain :with_icon_inverted do |inverted|
    options[:icon_invert] = inverted
    @inverted_set = true
  end

  chain :with_icon_position do |icon_position|
    options[:icon_position] = icon_position
    @icon_position_Set = true
  end

  chain :with_tooltip do |tooltip|
    options[:tooltip] = tooltip
  end

  chain :with_tooltip_position do |tooltip_position|
    options[:tooltip_position] = tooltip_position
  end

  match do
    @text = text
    @type = type
    expected == got
  end

  failure_message_for_should do
    failure_message(false)
  end

  failure_message_for_should_not do
    failure_message(true)
  end

  description do
    desc = "render a button with type '#{type}'"
    descs = []
    descs << "with the style: #{options[:style]}" if style?
    descs << "with the size: #{options[:size]}" if size?

    ext = inverted? ? "inverted " : ""

    descs << "with the #{ext}icon: #{options[:icon]}" if icon?
    descs << "with the icon_position: #{options[:icon_position]}" if icon_position?
    descs << "with the '#{options[:tooltip]}' tooltip" if tooltip?
    descs << "with the '#{options[:tooltip_position]}' tooltip position" if tooltip_position?

    desc << " " if descs.any?
    desc << descs.to_sentence(two_words_connector: " and ", last_word_connector: " and ")
  end
end
