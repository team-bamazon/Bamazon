class ScrapingCategories
  def self.save

    @results = []
    @category_id_counter = 0
    @p_category_id       = @category_id_counter

    agent = Mechanize.new
    agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
    page = agent.get("https://www.amazon.co.jp/gp/site-directory")
    @title = page.search('.popover-grouping')

    @title.each do |p|
      @p_name       = p.at('.popover-category-name').inner_text
      @results << {id: @category_id_counter, name: @p_name, parent_product_category_id: nil}
      @p_category_id = @category_id_counter
      @category_id_counter += 1
      p.search('.nav_a').each do |c|
        @c_name = c.inner_text
        @results << {id: @category_id_counter, name: @c_name, parent_product_category_id: @p_category_id}
        @category_id_counter += 1
      end
    end

    @results.each do |result|
      product_category = ProductCategory.where(id: result[:id]).first_or_initialize

      product_category.id                         = result[:id]
      product_category.category_name              = result[:name]
      product_category.parent_product_category_id = result[:parent_product_category_id]

      product_category.save
    end
  end
end
