class InfiniteNewsScreen < InfiniteScreen
    def on_load
      super

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
      update_page(UIPageViewControllerNavigationDirectionForward)
    end

    def swipe_right(gestureRecognizer)
      update_page(UIPageViewControllerNavigationDirectionReverse)
    end

    def update_page(direction=UIPageViewControllerNavigationDirectionForward)
      new_page = self.screen_type.new item: 'random %d' % rand(1000)
      self.setViewControllers [new_page], direction: direction, animated: true, completion: nil
    end

  end
