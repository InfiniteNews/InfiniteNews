class NewsScreen < PM::Screen
  title "News"._

  attr_accessor :item, :index  # required by InfiniteScreen

  def load_view
    self.view = layout.view
  end

  def on_load
    if self.item.is_a? String
      layout.get(:title).text = "%s" % self.item
    else
      layout.get(:title).text = "%s" % self.item[:title]
      layout.get(:rank).text = "#%s" % self.item[:rank]

      layout.get(:title).userInteractionEnabled = true
      layout.get(:title).on_tap(2) { self.item[:url].nsurl.open; }
    end
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
