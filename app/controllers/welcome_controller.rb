class WelcomeController < ApplicationController
  def index
    readme = File.open('README.md').read
    renderer = Redcarpet::Render::HTML.new(prettify: true)
    markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    @html = markdown.render(readme).html_safe
  end
end
