module Fech
  class Table
    class_eval do
      [:detail, :summary_all, :linkage, :summary_current].each do |meth|
        action = lambda do |year, opts={}|
          attrs = self::HEADERS[meth] || self::HEADERS
          attrs[:year] = year
          attrs.merge(opts)
        end

        define_singleton_method(meth, action)
      end
    end

    def method_missing(meth, cycle)
      table = new(cycle, self::HEADERS[:detail])
      table.retrieve_data.select { |candidate| candidate[:party] == meth.upcase }
    end
  end
end
