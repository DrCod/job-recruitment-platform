module UsersHelper

    #Returns the Gravatar for the given user

    def  gravatar_for(user)
        gravatar_id =Digest::MDS::hexdigest(user.email.downcase)
        gravatar_url =""
        image_tag(gravatar_url,alt: user.name, class: "gravatar") 
    end
end
