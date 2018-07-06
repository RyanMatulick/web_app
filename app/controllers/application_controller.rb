class ApplicationController < ActionController::Base

  inherit_resources

  before_action :set_initial_time, :set_locale

  def namespaced_route(route_name, *args)
    view_context.namespaced_route(route_name, *args)
  end

  # Don't render the layout for Ajax requests
  def render(*args, &block)
    if request.xhr?
      if args.empty?
        args = [{:layout => false}]
      else
        args.first.merge!({:layout => false})
      end
    end
    super
  end

  private

  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user       = user_token && User.find_by_authentication_token(user_token.to_s)

    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    end
  end

  def user_for_paper_trail
    if current_user.present?
      [current_user.id, current_user.name, current_user.email].join(':')
    else
      'Guest'
    end
  end

  def get_account
    if user_signed_in?
      if params[:controller].include?('ad_champion/shopping')
        set_ad_champion_free_website
      elsif params[:website_namespace].present?
        set_website_for_namespace
      end
    end
  end

  def set_ad_champion_free_website
    @website = Account::Website.find(params[:id]) if params[:id]
  end

  def set_website_for_namespace
    @account_websites ||= current_user.websites.order(:name)
    @website ||= @account_websites.find_by_namespace(params[:website_namespace])
    raise ActionController::RoutingError.new('The requested website could not be found') unless @website
  end

  def paginate?
    %w(csv xml).exclude?(params[:format])
  end

  def set_report_filter
    @report_filter = params[:report_filter]
  end

  def report_filter_conditions
    @report_filter                 ||= {}
    unless @report_filter[:date_range]
      @report_filter[:date_range]    = "#{Date.today.beginning_of_month} - #{Date.today}"
    end
    @report_filter[:ad_vendor_ids] ||= AdVendor.pluck(:id)

    unless @report_filter[:order_by] && (resource_class.column_names).include?(@report_filter[:order_by].split(' ').first)
      @report_filter.delete(:order_by)
    end
    @report_filter
  end

  helper_method :report_filter_conditions

  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def current_ability
    @current_ability ||= User::Ability.new(current_user, @website)
  end

  def current_master_account
    @current_master_account ||= (session[:current_master_account_id].present? ? MasterAccount.find(session[:current_master_account_id]) : nil)
  end

  helper_method :current_master_account

  def current_account
    @current_account ||= (session[:current_account_id].present? ? Account.find(session[:current_account_id]) : nil)
  end

  helper_method :current_account

  def current_accounts
    if current_master_account
      current_master_account.accounts.active
    else
      current_user.user_accounts.active
    end
  end
  helper_method :current_accounts

  # For the websites switcher at the top of the page
  def current_websites
    if current_account
      @current_websites ||= current_user.websites.active.where(account_id: current_account.id).order(:name)
    elsif current_master_account
      @current_websites ||= current_user.websites.active.where(account_id: current_master_account.accounts.active.pluck(:id)).order(:name)
    else
      @current_websites ||= current_user.websites.active.order(:name)
    end
  end

  helper_method :current_websites

  helper_method :can_access_google_shopping?

  def can_access_google_shopping?
    return false unless current_user.role.present?
    [User::Role::ACCOUNT_ADMIN, User::Role::ACCOUNT_MANAGER].include? current_user.role.name
  end

  def reset_current
    session.delete :current_master_account_id
    session.delete :current_account_id
  end

  def can_access_master_accounts_index?
    current_user && current_user.super_user?
  end

  helper_method :can_access_master_accounts_index?

  def set_initial_time
    @initial_time = Time.now
  end

  # logging request, render time and user info
  # page_generation_time is in milliseconds
  # To get the initial_request_time with millisecond granularity, you'll
  # need to format the call accordingly:
  # ActivityLog.last.initial_request_time.strftime('%Y-%m-%d %H:%M:%S.%N')
  def log_time_and_user
    ActivityLog.create(
      requested_url: request.original_url,
      shortened_url: request.original_url.split('?').first,
      user_ip: request.remote_ip,
      initial_request_time: @initial_time,
      page_generation_time: (Time.now - @initial_time) * 1000,
      current_user: current_user ? current_user.email : nil
    )
  end

  # Add this as a before filter to a controller action to prevent page caching.
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def load_links
    @links ||= YAML.load(File.read("config/links.yml"))
  end
end
