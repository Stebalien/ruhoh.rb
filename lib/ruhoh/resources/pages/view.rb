class Ruhoh::Resources::Pages
  class View < Ruhoh::Views::RMustache
    include Ruhoh::Views::PageHelpers
  
    def all
      pages = @ruhoh.db.pages.each_value.map { |val| val }
    
      mark_active_page(pages)
    end
  end
end