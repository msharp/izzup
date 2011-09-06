module Izzup

    class IzzupArguments < Hash
        
        def initialize(args)
            [args].each{|a|add_item(a)}
            self
        end

        protected        
        
        def add_item(item, n=1)
            n.is_a?(Fixnum) ? num = n : n = 1
            if item.is_a?(Array)
                add_array(item) 
            elsif item.is_a?(Hash)
                add_hash(item)
            else
                self[item] = 0 unless self[item]
                self[item] = self[item] + n
            end
        end

        def add_array(array)
            array.each{|a|add_item(a)}
        end

        def add_hash(hash)
            hash.each do |i,n|
                add_item(i,n)
            end
        end

    end

end
