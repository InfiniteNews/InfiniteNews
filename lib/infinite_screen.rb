class InfiniteScreen < UIPageViewController
  include ProMotion::ScreenModule

  attr_accessor :items, :screen_type
  attr_accessor :pages, :current_page

  # InfiniteScreen.new items: [], view: UIViewControllers

  def on_load
    self.items ||= []
    self.screen_type ||= PM::Screen

    self.pages = self.items.map.with_index { |item, index| self.screen_type.new item: item, index: index }
    self.current_page = self.pages.first

    setup
    init_pages
  end

  def setup
    self.dataSource = self
    self.delegate = self
  end

  def init_pages
    self.setViewControllers self.pages.take(1), direction: UIPageViewControllerNavigationDirectionForward, animated: true, completion: nil
  end

  # dataSource
  def pageViewController(pageViewController, viewControllerBeforeViewController:viewController)
    if viewController
      return self.pages.last if viewController.index <= 0
      return self.pages[viewController.index - 1]
    end
    nil
  end

  def pageViewController(pageViewController, viewControllerAfterViewController:viewController)
    if viewController
      return self.pages.first if viewController.index >= self.pages.count - 1
      return self.pages[viewController.index + 1]
    end
    nil
  end

  def presentationCountForPageViewController(pageViewController)
    self.pages.count
  end

  def presentationIndexForPageViewController(pageViewController)
    self.current_page.index
  end

  # delegate
  def pageViewController(pageViewController, willTransitionToViewControllers:pendingViewControllers)
  end

  def pageViewController(pageViewController, didFinishAnimating:finished, previousViewControllers:previousViewControllers, transitionCompleted:completed)
  end

  def self.new(args = {})
    s = self.alloc.initWithTransitionStyle UIPageViewControllerTransitionStylePageCurl,
                    navigationOrientation: UIPageViewControllerNavigationOrientationHorizontal,
                                  options: {
                                    UIPageViewControllerOptionSpineLocationKey: UIPageViewControllerSpineLocationMin
                                  }

    s.screen_init(args) # Important for ProMotion stuff!
    s
  end


   # Highly recommended that you include these methods below

   def loadView
     self.respond_to?(:load_view) ? self.load_view : super
   end

   def viewDidLoad
     super
     self.view_did_load if self.respond_to?(:view_did_load)
   end

   def viewWillAppear(animated)
     super
     self.view_will_appear(animated) if self.respond_to?("view_will_appear:")
   end

   def viewDidAppear(animated)
     super
     self.view_did_appear(animated) if self.respond_to?("view_did_appear:")
   end

   def viewWillDisappear(animated)
     self.view_will_disappear(animated) if self.respond_to?("view_will_disappear:")
     super
   end

   def viewDidDisappear(animated)
     self.view_did_disappear(animated) if self.respond_to?("view_did_disappear:")
     super
   end

   def shouldAutorotateToInterfaceOrientation(orientation)
     self.should_rotate(orientation)
   end

   def shouldAutorotate
     self.should_autorotate
   end

   def willRotateToInterfaceOrientation(orientation, duration:duration)
     self.will_rotate(orientation, duration)
   end

   def didRotateFromInterfaceOrientation(orientation)
     self.on_rotate
   end
 end
