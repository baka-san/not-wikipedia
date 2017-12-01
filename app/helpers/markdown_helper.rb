module MarkdownHelper

  class Markdown

    class << self
      def renderer
        @@renderer ||= Redcarpet::Markdown.new(
          Redcarpet::Render::HTML,
          :autolink => true,
          :no_intra_emphasis => true,
          :tables => true,
          :fenced_code_blocks => true,
          :disable_indented_code_blocks => true,
          :filter_html => false,
          :with_toc_data => true
        )
      end
    end

  end

  def markdown(&block)
    content = capture(&block)
    Markdown.renderer.render(content).html_safe
  end

end