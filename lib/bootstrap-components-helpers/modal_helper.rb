module BootstrapComponentsHelpers
  module ModalHelper
    
    def modal title, options = {}
      builder = ModalBuilder.new self
      yield builder
      content_tag :div, class: 'modal fade hide', id: options[:id] do
        header = content_tag :div, class: 'modal-header' do
          content_tag(:a, '×', class: 'close', data: {dismiss: 'modal'}) + content_tag(:h3, title)
        end
        body = content_tag(:div, class: 'modal-body') {builder.body_content}
        unless options[:skip_footer]
          footer = content_tag(:div, class: 'modal-footer') do
            builder.footer_content || content_tag(:a, 'Cancel', class: 'btn pull-right', data: {dismiss: 'modal'})
          end
        end
        header + body + footer
      end
    end
    
    class ModalBuilder
      
      attr_reader :parent, :body_content, :footer_content
      delegate :capture, to: :parent
      
      def initialize parent
        @parent = parent
      end
      
      def body &block
        @body_content = capture(&block)
      end
      
      def footer &block
        @footer_content = capture(&block)
      end
      
    end
    
  end
end

ActionView::Base.send :include, BootstrapComponentsHelpers::ModalHelper