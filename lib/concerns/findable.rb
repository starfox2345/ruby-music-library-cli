
module Concerns  # ./concerns
    module Findable # ./concerns/findable

        def find_by_name(name)
            self.all.detect {|person| person.name == name}

        end

        def find_or_create_by_name(name)
            self.find_by_name(name) != nil ? self.find_by_name(name) : self.create(name)
        end
    end
end