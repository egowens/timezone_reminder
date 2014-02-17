module UsersHelper

  #returns the Gravatar image for the current user
  def gravatar_for(user, options= { size: 100 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase) 
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "img-rounded")
  end
end