
module Izzup
    
    require 'izzup_error'

    # require these or fail
    def self.require(*args)
        args.each do |p|
            raise IzzupError "#{self.name} dying because #{p} is not up" unless izzup(p) == 1
        end
    end

    # see if they are up
    def self.request(*args)
        found = 0
        args.each do |p|
            found = found + izzup(p)
        end
        found == args.length
    end

    def self.izzup(process)
        up = 0
        begin
            up = %x{ps ax | grep #{process} | grep -v grep | wc -l}.strip().to_i
        rescue
            raise StandardError "#{self.name} will probably only work on a *NIX machine"
        end
        up
    end

end
