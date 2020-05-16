module ApplicationHelper
    def link_to_add_fields(name, f, association)

        # Takes an object (@person) and creates a new instance of its associated model (:addresses)
        new_object = f.object.send(association).klass.new

        # Saves the unique ID of the object into a variable. 
        id = new_object.object_id

        # https://api.rubyonrails.org/ fields_for(record_name, record_object = nil, fields_options = {}, &block) 
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
            render(association.to_s.singularize + "_fields", f: builder)
        end

        # This renders a simple link, but passes information into `data` attributes.
        link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
    end

    # devise Helper
    def resource_name
        :user
    end

    def resource
        @resource ||= User.new
    end

    def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
    end
end
