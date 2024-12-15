module ApplicationHelper
  def header_link_item(name, path)
    class_name = 'nav-link'
    class_name << ' active' if current_page?(path) # 表示されているページと引数のパスが同じであれば、class_nameにactiveを追加する（文字列連結 破壊的）。

    # liタグの中にaタグが埋め込まれ、ヘルパーの呼び出し元に返される。
    content_tag :li, class: 'nav_item' do
      link_to name, path, class: class_name
    end
  end
end
