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
    else "alert alert-info"
    end
  end

  class CodeRayify < Redcarpet::Render::HTML
   def block_code(code, language)
      language = :text if language == nil || !CodeRay::Scanners.list.include?(language.to_sym)
      CodeRay.scan(code, language).div
   end
  end
 
  def markdown(text)
    coderayified = CodeRayify.new(:filter_html => true, :hard_wrap => true)
    options = {
    fenced_code_blocks: true,
      no_intra_emphasis: true,
      autolink: true,
      lax_html_blocks: true
    }
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end

end
