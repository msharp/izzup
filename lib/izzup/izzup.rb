module Izzup

    # require these or fail with izzup error
    def self.insist(*args)
        IzzupArguments.new(args).each do |p,n|
            raise IzzupError, "#{self.name} died because #{n} instance(s) of #{p} not available" unless izzup(p,n) 
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

    # test for given number of processes
    def self.izzup(process, count=1)
        up = %x{ps ax | grep #{process} | grep -v grep | wc -l}.strip()
        not_nix! if up.length == 0 # windows will return "" from ps command
        up.to_i == count
    end

    def self.not_nix!
        raise StandardError, "#{self.name} will probably only work on a *NIX machine"
    end

end


