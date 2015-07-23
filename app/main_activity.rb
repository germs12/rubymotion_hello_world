class UpButtonListener
  attr_accessor :activity

  def onClick(view)
    @activity.changeCount(1)
  end
end

class DownButtonListener
  attr_accessor :activity

  def onClick(view)
    @activity.changeCount(-1)
  end
end

class EpicScore
  attr_accessor :up_count, :title, :up_button, :down_button, :label, :up_button_text_on, :down_button_text_on, :up_button_text_off, :down_button_text_off, :up_button_handler, :down_button_handler

  def initialize(layout, activity, title)
    @up_button_handler = Android::Os::Handler.new
    @title = title
    @label = Android::Widget::TextView.new(activity)
    @label.text = @title
    @label.textSize = 80.0
    @label.gravity = Android::View::Gravity::CENTER_HORIZONTAL

    @counter = Android::Widget::TextView.new(activity)
    @counter.text = '0'
    @counter.textSize = 80.0
    @counter.gravity = Android::View::Gravity::CENTER_HORIZONTAL

    @up_button = Android::Widget::Button.new(activity)
    @up_button.text = '+'
    up_listener = UpButtonListener.new
    up_listener.activity = self
    @up_button.onClickListener = up_listener
    @up_count = 0

    @down_button = Android::Widget::Button.new(activity)
    @down_button.text = '-'
    down_listener = DownButtonListener.new
    down_listener.activity = self
    @down_button.onClickListener = down_listener
    @down_count = 0

    layout.addView(@label)
    layout.addView(@counter)
    layout.addView(@up_button)
    layout.addView(@down_button)
  end

  def changeCount(amount)
    @up_count += amount
    @counter.text = @up_count.to_s
  end

end

class MainActivity < Android::App::Activity
  attr_reader :handler

  def onCreate(savedInstanceState)
    super
    @handler = Android::Os::Handler.new

    layout = Android::Widget::LinearLayout.new(self)
    layout.orientation = Android::Widget::LinearLayout::VERTICAL

    @score1 = EpicScore.new(layout, self, 'Life')
    @score2 = EpicScore.new(layout, self, 'Gold')

    self.contentView = layout
  end
end























