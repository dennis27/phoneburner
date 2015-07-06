module Phoneburner
  class Response
    include Enumerable
    
    def initialize(request, &block) 
      @request = request
      @block = block
      @parsed = false
      @http_status = nil
      @status = nil
      @page_size = 0
      @page = 0
      @total_pages = 0
      @total_results = 0
      @inner_results=nil
      @raw = false
    end

    attr_reader :request

    def http_status 
      parse()
      @http_status
    end

    def status
      parse()
      @status
    end

    def page_size
      parse()
      @page_size
    end

    def page
      parse()
      @page 
    end

    def total_pages
      parse()
      @total_pages
    end

    def total_results
      parse()
      @total_results
    end
    
    def has_next_page?
      page < total_pages
    end

    def next_page
      if has_next_page?
        request = @request.dup
        request.page(self.page.to_i + 1)
        request.all
      else
        nil
      end
    end

    def each(&iblock) 
      parse()
      return nil if @inner_results.nil?
      if @inner_results.is_a?(Array)
        e = Enumerator.new do |y|
          @inner_results.each do |ir|
            obj = is_raw? ? ir : request.build(ir)
            y.yield(obj)
          end
        end        
      else    
        e = Enumerator.new do |y|
          y.yield(result(&iblock))
        end
      end
      block_given? ? e.each(&iblock) : e
    end

    def raw()
      @raw=true
      self
    end

    def parsed()
      @raw = false
      self
    end

    def is_raw?
      !!@raw
    end

    def result(&iblock)
      parse()
      return nil if @inner_results.nil?      
      if !@inner_results.is_a?(Array)
        e = is_raw? ? @inner_results : request.build(@inner_results)
        block_given? ? iblock.yield(e) : e
      end
    end

    def method_missing(symbol,*args)
      parse()
      if !!@_results.is_a?(Hash) && @_results.has_key?(symbol.to_s)
        @_results[symbol.to_s]
      else
        super
      end
    end

  private
    def parse()
      return if !!@parsed
      @parsed = true
      r = @block.yield
      json = JSON.parse(r.body)
      @http_status = json["http_status"]
      @status = json["status"]
      @_results = request.model.extract_results(json,request)
      @page_size = @_results["page_size"].to_i
      @total_results = @_results["total_results"].to_i
      @page = @_results["page"].to_i
      @total_pages = @_results["total_pages"].to_i
      @inner_results = request.model.extract_inner_results(@_results, request)
    end

    def inner_results
      parse()
      @inner_results
    end

  end
end