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

  def paginate?
    %w(csv xml).exclude?(params[:format])
  end

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
