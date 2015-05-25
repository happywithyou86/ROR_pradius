module SearchesHelper
  def split_text(text)
    text.split(" ").join(" | ")
  end
end
