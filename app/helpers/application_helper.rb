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
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}&d=robohash"
    #image_tag(gravatar_url, alt: user.fullname, class: "gravatar")
  end

end
