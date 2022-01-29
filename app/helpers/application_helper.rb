module ApplicationHelper

  def show_svg(path)
    File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read
    end
  end

  def gravatar_url_for(user, options = { size: 80 })
    email = user.email
    hash = Digest::MD5.hexdigest(email)
    size = options[:size]
    "https://www.gravatar.com/avatar/#{hash}?s=#{size}&d=robohash"
  end

  def flash_class(type)
    case type
    when "notice" then "alert alert-success"
    when "alert" then "alert alert-danger"
    end
  end

  def logged_in?
    !!current_user
  end

end
