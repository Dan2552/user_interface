module UserInterface
  class Timer
    def initialize(interval: 0, repeats: false, object: nil, selector: nil, &blk)
      @interval = interval
      @repeats = repeats
      @object = object
      @selector = selector
      @invalidated = false
      @blk = blk
      @last_interval_elapsed = ::Time.now.to_f

      raise "Timer cannot be passed both an object and a block" if blk && object
      raise "Timer must be passed a selector when being passed an object" if object && !selector
      raise "Timer must have something to do" if !block_given? && !object
    end

    attr_reader :interval

    def repeats?
      @repeats
    end

    def fire
      if @blk
        @blk.call
      else
        @object.public_send(@selector)
      end

      @invalidated = true unless @repeats
    end

    def invalidate
      @invalidated = true
    end

    def invalidated?
      @invalidated == true
    end

    def interval_elapsed?
      @last_interval_elapsed + interval < ::Time.now.to_f
    end
  end
end
