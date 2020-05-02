module Slugifiable
    module InstanceMethods
        def slug
            name_array = self.username.split(" ")
            slug = name_array.join("-")
            slug
        end
    end
    module ClassMethods
        def find_by_slug(slug)
            slug_array = slug.split("-")
            deslugified = slug_array.join(" ")
            User.find_by(username: deslugified)
        end
    end
end