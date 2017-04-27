class InfiniteNewsScreen < InfiniteScreen
  attr_accessor :more

  def on_load
    fetch_stories do |res|
      super
    end

    UISwipeGestureRecognizer.alloc.initWithTarget(self, action: :'swipe_left:').tap do |gesture|
      gesture.direction = UISwipeGestureRecognizerDirectionLeft
      self.view.addGestureRecognizer gesture
    end

    UISwipeGestureRecognizer.alloc.initWithTarget(self, action: :'swipe_right:').tap do |gesture|
      gesture.direction = UISwipeGestureRecognizerDirectionRight
      self.view.addGestureRecognizer gesture
    end
  end

  def on_init
  end

  def setup
    nil
  end

  def init_pages
    update_page
  end

  def will_appear
    # just before the view appears
  end

  def on_appear
    # just after the view appears
  end

  def will_disappear
    # just before the view disappears
  end

  def on_disappear
    # just after the view disappears
  end

  def swipe_left(gestureRecognizer)
    if self.items.size > 0
      update_page(UIPageViewControllerNavigationDirectionForward)
    else
      fetch_stories do |res|
        update_page(UIPageViewControllerNavigationDirectionForward)
      end
    end
  end

  def swipe_right(gestureRecognizer)
    if self.items.size > 0
      update_page(UIPageViewControllerNavigationDirectionReverse)
    else
      fetch_stories do |res|
        update_page(UIPageViewControllerNavigationDirectionReverse)
      end
    end
  end

  def update_page(direction=UIPageViewControllerNavigationDirectionForward)
    if self.items.size > 0
      new_page = self.screen_type.new item: self.items.shift
      self.setViewControllers [new_page], direction: direction, animated: true, completion: nil
    end
  end

  def fetch_stories(&block)
    HN::News.beststories(self.more) do |res|
      self.items = res[:stories]

      self.more = res[:more]

      block.call res if block
    end
  end

end
