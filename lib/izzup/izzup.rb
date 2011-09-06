module Izzup
    

    # require these or fail with izzup error
    def self.demand(*args)
        IzzupArguments.new(args).each do |p,n|
            raise IzzupError, "#{self.name} dying because #{n} instance(s) of #{p} not discovered" unless izzup(p,n) 
        end
    end

    # see if they are up true/false
    def self.assert(*args)
        found = true
        IzzupArguments.new(args).each do |p,n|
            found = found && izzup(p,n)
        end
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


