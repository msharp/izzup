module Izzup
    

    # require these or fail with izzup error
    def self.demand(*args)
        args.each do |p|
            raise IzzupError, "#{self.name} dying because #{p} is not up" unless izzup(p) 
        end
    end

    # see if they are up true/false
    def self.assert(*args)
        found = true
        args.each {|p| found = found && izzup(p)}
        found
    end

    def self.izzup(process, count=1)
        up = 0
        begin
            up = %x{ps ax | grep #{process} | grep -v grep | wc -l}.strip().to_i
        rescue
            raise StandardError, "#{self.name} will probably only work on a *NIX machine"
        end
        up == count
    end

end


