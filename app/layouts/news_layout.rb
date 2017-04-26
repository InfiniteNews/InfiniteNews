class NewsLayout < MK::Layout

  def layout
    root :main do
      add UILabel, :title
    end
  end

  def main_style
    background_color :white.uicolor(0.95)
  end

  def title_style
    text 'Hi, there!'
    font UIFont.fontWithName("Helvetica Neue", size: UIFont.labelFontSize * 2)
    size_to_fit

    constraints do
      center.equals(:superview)
    end
  end

end
