# -*- encoding : utf-8 -*-
module ApplicationHelper # @private
  def namespaced_route(route_name, *args)
    options = args.extract_options!
    context = options.delete(:context)
    target = context.present? ? context : self
    if @website.present?
      target.send(route_name, *[@website.namespace].concat(args << options))
    else
      if args.present? || options.present?
        target.send(route_name, args << options)
      else
        target.send(route_name)
      end
    end
  end

  def days_of_the_week
    Date::DAYNAMES.inject({}) do |r, s|
      r.merge(s => r.size)
    end
    # Ruby 2.1
    # Date::DAYNAMES.each_with_index.to_h
  end

  def format_date(date)
    return unless date
    date.strftime("%b %d %Y")
  end

  def format_datetime(datetime)
    return unless datetime
    datetime.strftime("%b %d %Y %I:%M %P")
  end

  def nav_tabs(items)
    list = items.map do |title, url|
      if title == 'Generated Content'
        subpage = current_path[:controller].split('/').last
        content_tag :li, link_to(content_tag(:span, title), url), :class => (%w(campaigns ads ad_groups keywords).include?(subpage) ? 'selected' : '')
      else
        content_tag :li, link_to(content_tag(:span, title), url), :class => (path_for(url) == current_path ? 'selected' : '')
      end
    end

    list.join.html_safe
  end

  def current_path
    @current_path ||= path_for(request.env['PATH_INFO'])
  end

  def current_root_path(options={})
    case params[:controller]
    when /^miracles/          then miracles_path(options)
    else scenarios_path(options)
    end
  end

  def build_dialog(css_id, options={})
    contents = content_tag(:div,'' ,{class: 'content'}) + content_tag(:div, self.loading_image,{class: 'loading center', style: 'display: block'})
    content_tag(:div, contents, id: css_id, class: options[:class])
  end

  def path_for(str)
    Rails.application.routes.recognize_path(str)
  end

  def rf
    {report_filter: @report_filter}
  end

  def keyboard_shortcut(*keys)
    shortcuts = keys.map do |k|
      if browser.mac?
        case k.downcase
          when 'alt'           then k = '&#8997;'
          when 'esc'           then k = '&#9099;'
          when 'cmd' || 'ctrl' then k = '&#8984;'
          when 'shift'         then k = '&#8679;'
        end
      end

      content_tag :span, k.html_safe
    end

    content_tag :kbd, shortcuts.join(' + ').html_safe, class: 'keyboard-shortcut'
  end

  def status_text(text, html_class='', html_attrs={})
    html_attrs[:class] = "status-text #{html_class}"
    content_tag :span, text, html_attrs
  end

  def inventories_dropdown_options
    parent_inventories = @website.inventories.active
    inventory_options = []

    verticals = parent_inventories.map(&:vertical).uniq

    verticals.each do |vertical|
      temp_options = []
      parent_inventories.select{ |i| i.is_root? && i.vertical_id == vertical.id }.each do |inventory|
        temp_options << [inventory.name, inventory.id, { :'data-vertical_id' => inventory.vertical.id }]
        parent_inventories.select{ |i| i.parent_id == inventory.id}.each do |inv|
          temp_options << [inv.name, inv.id, { class: 'sub-inventory', :'data-vertical_id' => inventory.vertical.id }]
        end
      end
      inventory_options << [vertical.full_name, temp_options]
    end
    inventory_options
  end

  def loading_image(html_class='')
    image_tag('loading.gif', :alt => 'Loading...', :class => html_class).html_safe
  end

  def env_html_class
    case Rails.env
    when 'production', 'development'
      "env-#{Rails.env}"
    else
      'env-production'
    end
  end

  def help_icon(text, ajax=false)
    if text.include? '"translation_missing"'
      text
    else
      content_tag :span, nil, class: "help-icon #{' ajax-tooltip' if ajax}", data: { tooltip: text }
    end
  end

  def preview_icon(text)
    content_tag :span, nil, class: 'preview-icon', data: { tooltip: text }
  end

  def ad_vendor_icon(title, html_class='')
    content_tag :span, (title == 'Google' ? 'G' : ''), class: "icon ad-vendor-icon #{title.downcase} #{html_class}", data: { tooltip: title }
  end

  def show_more_button(amount = 'Show')
    return nil if amount == 0
    text = "#{ amount } more"
    link_to (content_tag :span, text), '#', { class: 'show-more-button' }
  end

  def save_button(options = {})
    options[:text]     ||= 'Save Changes'
    options[:loadtext] ||= 'Saving Changes...'

    options[:class] = "#{options[:class]} save".strip
    options['data-button-primary-icon'] ||= 'ui-icon-check'

    submit_button(options)
  end

  def create_button(options)
    options[:text]     ||= 'Create'
    options[:loadtext] ||= 'Creating...'
    options['data-button-primary-icon'] ||= 'ui-icon-add'

    submit_button(options)
  end

  # TODO: add class to make this button red.
  # replace tick with an 'x' or something similar
  def delete_button(options = {})
    options[:text]     ||= 'Delete Item'
    options[:loadtext] ||= 'Deleting item...'

    options[:class] = "#{options[:class]} delete".strip
    options['data-button-primary-icon'] ||= 'ui-icon-check'

    submit_button(options)
  end

  def submit_button(options)
    defaults = { :type => 'submit', :'data-loadtext' => options.delete(:loadtext) }
    options[:class] = "#{options[:class]} dc-button".strip
    content_tag(:button, options.delete(:text), options.merge(defaults))
  end

  def submit_link(options)
    defaults = { :'data-loadtext' => options.delete(:loadtext) }
    link_to options.delete(:text), options.delete(:href), options.merge(defaults)
  end

  def analytics_tracking_code
    code = <<-eoc
    <script type="text/javascript">
    var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-50021746-6']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
    </script>
    eoc

    Rails.env == 'production' ? code.html_safe : ""
  end

  def new_nested_association_fields(form, association, partial, template, options={})
    form.fields_for(association, form.object.class.reflections[association.to_s].klass.new, child_index: '__id__') do |builder|
      render partial, { f: builder, template: template }
    end
  end

  def monthly_budget_for(daily_budget)
    number_to_currency(daily_budget.to_f * AVG_DAYS_IN_MONTH)
  end

  # Adds an error class to the initial class, if an error is found in the errors hash for method
  def add_css_error_class(method, initial_class, errors)
    initial_class.tap do |klass|
      klass << ' error' if errors.present? && errors[method].present?
    end
  end

  def htext(method, text = nil, options = {})
    object = options[:object] || @object
    t_path = "labels.#{object.class.name.downcase.gsub('::', '.')}.#{method}"
    text ||= I18n.t("#{t_path}.text", :default => method.to_s.capitalize) + ':'
    (text + help_icon(I18n.t("#{t_path}.help"), options.fetch(:ajax, false))).html_safe
  end

  def grouped_vertical_select_options(selected_vertical_id = nil)
    vertical_list = Vertical.root.map do |vertical|
      html_options = { 'data-parent_vertical_name' => vertical.name }
      [vertical.name,
        vertical.children.map do |child_vertical|
          additional_html_options = { :'data-xsd' => { name: child_vertical.full_name, url: child_vertical.xsd_url }.to_json }
          [child_vertical.name, child_vertical.id, html_options.merge(additional_html_options)]
        end
      ]
    end
    grouped_options_for_select(vertical_list, selected_vertical_id)
  end

  # Create a styled link which renders as a button, rather than a submit
  # button.
  def dc_button(text, url, classes='', id=nil, options={})
    is_remote = options[:remote] || false
    html_class = [classes, 'special dc-button ui-button-big'].join(' ').strip
    data = { button_primary_icon: 'ui-icon-add' }
    link_to text, url, class: html_class, data: data, id: id, remote: is_remote
  end

  def totals_helper(history)
    {
      budgeted: history.media_budget.to_f,
      actual: history.media_spend.to_f,
      variance: (history.media_spend.to_f - history.media_budget.to_f),
      variance_css: media_spend_variance_css(history.media_spend.to_f, history.media_budget.to_f),
      eom_budgeted: history.eom_media_budget.to_f,
      eom_actual: history.eom_media_spend.to_f
    }
  end

  def can_access_master_accounts_switcher?
    current_user && (current_user.super_user? || current_user.master_accounts.count > 0)
  end

  def can_access_accounts_switcher?
    current_user && (current_user.super_user? || current_user.accounts.active.count > 0 || current_user.master_accounts.count > 0) &&
      (current_user.role.try(:name) != User::Role::ETAILER)
  end

  # Return the master accounts scope for the current user
  def master_accounts_for_current_user

    if current_user.super_user?
      MasterAccount.all
    else
      current_user.master_accounts
    end
  end

  # Create a 'Add' button to add sub object form for an accepts_nested_attributes_for
  # attributes
  def link_to_add_fields(name, f, association, options={})
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, { child_index: id }.merge(options)) do |builder|
      render(association.to_s.singularize + '_fields', f: builder)
    end

    link_to(name, '#', class: 'add_fields btn-primary', data: { id: id, fields: fields.gsub('\n', '')})
  end

  def allow_google_shopping?(website)
    website.inventories.retail_standard.present?
  end

  def current_url(new_params)
    url_for :params => params.merge(new_params).except(:controller, :action, :website_namespace)
  end

end

class ActionView::Helpers::FormBuilder # @private
  include ActionView::Helpers::TagHelper
  include ApplicationHelper

  def hlabel(method, text = nil, options = {}, &block)
    label(method, htext(method, text, options), options, &block)
  end

  def save(options = {})
    save_button(options)
  end

  def submit_button(options)
    defaults = { :type => 'submit', :'data-loadtext' => options.delete(:loadtext) }
    options[:class] = "#{options[:class]} dc-button".strip
    button(options.delete(:text), options.merge(defaults))
  end

end

