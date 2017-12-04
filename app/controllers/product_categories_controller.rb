class ProductCategoriesController < ApplicationController
  def index

    @results = []
    @category_id_counter = 0
    @p_category_id       = @category_id_counter

    agent = Mechanize.new
    agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
    agent.user_agent_alias = 'Windows Mozilla'
    page = agent.get("https://www.amazon.co.jp/gp/site-directory")
    @title = page.search('.popover-grouping')

    @title.each do |p|
      @p_name       = p.at('.popover-category-name').inner_text
      @results << {id: @category_id_counter, name: @p_name, parent_product_category_id: nil, node_id: nil, category_url: nil, products: nil}
      @p_category_id = @category_id_counter
      @category_id_counter += 1
      p.search('.nav_a').each do |c|
        @c_name = c.inner_text
        @c_node_id = (c[:href].match(/node=(\d*)/) || {})[1]
        @c_category_url = c[:href]
        @results << {id: @category_id_counter, name: @c_name, parent_product_category_id: @p_category_id, node_id: @c_node_id, category_url: @c_category_url, products: nil}
        @category_id_counter += 1
      end
    end

    @results.each do |result|
      if result[:node_id]
        result[:products] = []
        page = agent.get(result[:category_url])
        @products = page.links_with(href: /\/dp\/product/)
        @products.first(10).each do |product|
          result[:products] << product
        end if @products
      end
    end

    # @results.each do |result|
    #   product_category = ProductCategory.where(id: result[:id]).first_or_initialize
    #
    #   product_category.id                         = result[:id]
    #   product_category.category_name              = result[:name]
    #   product_category.parent_product_category_id = result[:parent_product_category_id]
    #
    #   product_category.save
    # end
  end
end
