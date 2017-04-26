class NewsScreen < PM::Screen
  title "News"._

  attr_accessor :item, :index  # required by InfiniteScreen

  def load_view
    self.view = layout.view
  end

  def on_load
    layout.get(:title).text = "%s" % self.item
  end

  def on_init
    set_tab_bar_item item: "News", title: "News"._
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

  private

  def layout
    @layout ||= NewsLayout.new
  end

end
