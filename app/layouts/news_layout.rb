class NewsLayout < MK::Layout

  def layout
    root :main do
      add UILabel, :title
      add UILabel, :rank
    end
  end

  def main_style
    background_color :white.uicolor(0.95)
  end

  def title_style
    text 'Hi, there!'
    font UIFont.fontWithName("Helvetica Neue", size: UIFont.labelFontSize * 2)
    number_of_lines 0
    size_to_fit

    constraints do
      center.equals(:superview)
      width.equals(:superview)
    end
  end

  def rank_style
    text ''
    font UIFont.fontWithName("Helvetica Neue", size: UIFont.labelFontSize * 1.414)
    number_of_lines 1
    size_to_fit

    constraints do
      left.equals(:superview)
      bottom.equals(:title, :top)
    end
  end

end
