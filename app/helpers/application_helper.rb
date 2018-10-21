module ApplicationHelper
    
    require 'redcarpet'
    require 'redcarpet/render_strip'

    # ------------------------------------------------------------
    # Returns the full title on a per-page basis.
    # ------------------------------------------------------------
    def full_title(page_title = '')
        base_title = "Blackwood PInes"
        if page_title.empty?
          base_title
        else
          page_title + " | " + base_title
        end
    end

    # ------------------------------------------------------------
    # Checks if the user is logged in
    # ------------------------------------------------------------
    def isLoggedIn?
      !current_user.nil?
    end
    
    # ------------------------------------------------------------
    # Checks if the user has admin role
    # ------------------------------------------------------------
    def isAdmin?
      if current_user.nil?
        false
      else
        current_user.role? :admin
      end
    end

    # ------------------------------------------------------------
    # Turns a text with Markdown tokens to HTML format
    # ------------------------------------------------------------
    def markdown(text)
      options = {
        filter_html:     true,
        hard_wrap:       true,
        link_attributes: { rel: 'nofollow', target: "_blank" },
        space_after_headers: true,
        fenced_code_blocks: true
      }
  
      extensions = {
        autolink:           true,
        superscript:        true,
        disable_indented_code_blocks: true
      }
  
      renderer = Redcarpet::Render::HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)
  
      markdown.render(text).html_safe
    end

    # ------------------------------------------------------------
    # Escapes the Markdown tokens to gets the plain text
    # ------------------------------------------------------------
    def escape_markdown(text)
      md = Redcarpet::Markdown.new(Redcarpet::Render::StripDown, :space_after_headers => false)
      md.render(text)
    end

end
