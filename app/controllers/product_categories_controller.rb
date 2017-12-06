class ProductCategoriesController < ApplicationController
  def index

    @base_url = "https://www.amazon.co.jp/"

    @results = []
    @category_id_counter = 0
    @p_category_id       = @category_id_counter

    agent = Mechanize.new

    agent.verify_mode      = OpenSSL::SSL::VERIFY_NONE
    agent.user_agent_alias = 'Windows IE 6'

    page = agent.get("https://www.amazon.co.jp/gp/site-directory")

    @title = page.search('.popover-grouping')

    @title.each do |p|
      @p_name = p.at('.popover-category-name').inner_text
      @results << {id: @category_id_counter, name: @p_name, parent_product_category_id: nil, node_id: nil, products: nil}
      @p_category_id = @category_id_counter
      @category_id_counter += 1
      p.search('.nav_a').each do |c|
        @c_name         = c.inner_text
        @c_node_id      = (c[:href].match(/node=(\d*)/) || {})[1]
        @results << {id: @category_id_counter, name: @c_name, parent_product_category_id: @p_category_id, node_id: @c_node_id, products: nil}
        @category_id_counter += 1
      end
    end

    @pp = []
    @urls = []

    @results.each do |result|
      product_category = ProductCategory.where(id: result[:id]).first_or_initialize

      product_category.id                         = result[:id]
      product_category.category_name              = result[:name]
      product_category.parent_product_category_id = result[:parent_product_category_id]

      product_category.save

      if result[:node_id] && nodeids(result[:node_id]) && result[:id] < 50
        result[:products] = []
        get_urls(result[:products],nodeids(result[:node_id]),result[:id])
      end
    end

  end

  def get_urls(products_array, nodeid, category_id)
    agent2 = Mechanize.new

    agent2.verify_mode      = OpenSSL::SSL::VERIFY_NONE
    agent2.user_agent_alias = 'Windows IE 6'

    url = "http://www.amazon.co.jp/s?ie=UTF8&page=2&rh=n:" + nodeid
    @urls << url
    catch(:error){
      begin
        current_page = agent2.get(url)
      rescue Mechanize::ResponseCodeError => e
        throw :error
      end

      current_page.encoding = 'UTF-8'

      @pp << "1: " + current_page.at('title').inner_text
      elements = current_page.search('a.s-access-detail-page')
      elements.each do |element|
        if products_array.length < 10 && /^http/ =~ element[:href]
          get_and_save_product(products_array, element[:href], category_id)
          @urls << element[:href]
        end
      end
    }
  end

  def get_and_save_product(products_array, link, category_id)
    agent3 = Mechanize.new

    agent3.verify_mode      = OpenSSL::SSL::VERIFY_NONE
    agent3.user_agent_alias = 'Windows IE 6'
    catch(:error2){
      begin
        page = agent3.get(link)
      rescue Mechanize::ResponseCodeError => e
        throw :error2
      end

      page.encoding = 'UTF-8'
      @pp << "2: " + page.at('title').inner_text

      # name             = (page.at('#productTitle').inner_text.strip if page.at('#productTitle')) || "Team B"
      # image            = (page.search('.imgTagWrapper img') if page.search('.imgTagWrapper img')) || ["NoImage"]
      # price            = (page.at('#priceblock_ourprice').inner_text.delete(' ,￥').to_i if page.at('#priceblock_ourprice')) || 1000
      # detail_before    = (page.at('#productDescription p').inner_text.delete(" ,\n") if page.at('#productDescription p')) || (page.at('#productDescription .productDescriptionWrapper').inner_text.delete(" ,\n") if page.at('#productDescription .productDescriptionWrapper')) || "sugoi"
      # detail           = detail_before.delete('"')
      #
      # image_urls = []
      # image.each do |img|
      #   image_urls << img.get_attribute('src')
      # end
      # image_urls_array = []
      # image_urls.each {|url| image_urls_array << {image: url}}
      #
      # product = Product.create(
      #                      name:          name,
      #                      price:         price,
      #                      detail:        detail,
      #                      stock:         rand(1..100),
      #                      amount_sales:  rand(1..100),
      #                      product_images_attributes: image_urls_array
      # )

      # products_array << product

      # product.save
    }
  end

  def nodeids(key)
    hash = {
        "2351649051" => "2351650051",
        "3535604051" => "3535604051",
        "3571215051" => "3571216051",
        "3666867051" => "3666867051",
        "3589137051" => "3589137051",
        "2128134051" => "2129039051",
        "2443896051" => "2443896051",
        "2443897051" => "2443897051",
        "2443898051" => "2443898051",
        "2386870051" => "2386870051",
        "2509060051" => "2509060051",
        "3232648051" => "3232648051",
        "3211799051" => "3502148051",
        "2408696051" => "2408703051",
        "2275256051" => "2292699051",
        "2293143051" => "2430812051",
        "2275259051" => "2311970051",
        "4486610051" => "4486610051",
        "2544561051" => "2544561051",
        "3283453051" => "3667091051",
        "3573602051" => "3573605051",
        "465392"     => "465612",
        "52033011"   => "52264011",
        "466280"     => "2278488051",
        "13384021"   => "13384391",
        "255460011"  => "255470011",
        "3479195051" => "3479195051",
        "561958"     => "562010",
        "403507011"  => "403508011",
        "561956"     => "562040",
        "2123629051" => "2123631051",
        "637394"     => "637810",
        "689132"     => "689144",
        "2510863051" => "32309940513",
        "3895771"    => "16299621",
        "3895791"    => "4083091",
        "3895751"    => "2145941051",
        "3895761"    => "4083011",
        "2133982051" => "2133983051",
        "124048011"  => "3895771",
        "16462091"   => "3371371",
        "3465736051" => "3465736051",
        "171350011"  => "11072271",
        "128187011"  => "128188011",
        "3477381"    => "3477491",
        "16462081"   => "3477981",
        "3477981"    => "3477981",
        "3544106051" => "3544107051",
        "3371421"    => "3477431",
        "3210981"    => "3210991",
        "3573765051" => "3573765051",
        "3708582051" => "3708582051",
        "2188762051" => "2151949051",
        "2127209051" => "2127210051",
        "2151826051" => "2151880051",
        "2151901051" => "2151941051",
        "2188763051" => "2152000051",
        "637392"     => "637630",
        "2201422051" => "2201422051",
        "86731051"   => "86732051",
        "13938481"   => "13938491",
        "3093567051" => "13945061",
        "2538755051" => "2157252051",
        "16428011"   => "2491367051",
        "13945081"   => "16416191",
        "2378086051" => "2378233051",
        "3093569051" => "13945141",
        "2038875051" => "14121091",
        "2127212051" => "2127214051",
        "2189701051" => "2189702051",
        "3828871"    => "3839181",
        "2031744051" => "2038941051",
        "2038157051" => "2039353051",
        "2361405051" => "392693011",
        "2039681051" => "2039689051",
        "2016929051" => "2017405051",
        "57239051"   => "76365051",
        "2439923051" => "2439923051",
        "71198051"   => "71213051",
        "71314051"   => "71315051",
        "71442051"   => "71443051",
        "2422738051" => "71498051",
        "76366051"   => "76366051",
        "3485688051" => "3528112051",
        "71589051"   => "71595051",
        "71649051"   => "71650051",
        "71610051"   => "71611051",
        "71601051"   => "71601051",
        "71620051"   => "71620051",
        "71625051"   => "71626051",
        "2422292051" => "2422292051",
        "2422338051" => "2422338051",
        "71588051"   => "71589051",
        "4097695051" => "4097695051",
        "2505532051" => "2505533051",
        "169911011"  => "169912011",
        "2356869051" => "2356869051",
        "344024011"  => "3456967051",
        "3396823051" => "3415480051",
        "170432011"  => "170499011",
        "170303011"  => "170329011",
        "170563011"  => "170566011",
        "160384011"  => "161670011",
        "169667011"  => "169668011",
        "170040011"  => "170262011",
        "170191011"  => "170192011",
        "170267011"  => "170287011",
        "169762011"  => "169763011",
        "52912051"   => "52980051",
        "3396994051" => "3557252051",
        "3501772051" => "3534720051",
        "3217793051" => "3217793051",
        "3544982051" => "3544982051",
        "52374051"   => "52392051",
        "344845011"  => "346185011",
        "13299531"   => "13299561",
        "466306"     => "492378",
        "2277721051" => "2281999051",
        "2230006051" => "2221071051",
        "2230005051" => "2221070051",
        "2230804051" => "2230781051",
        "2221077051" => "2221074051",
        "2188968051" => "3125565051",
        "15337751"   => "15314601",
        "14315411"   => "2201151051",
        "14315521"   => "15320261",
        "14315501"   => "344920011",
        "14315441"   => "15314411",
        "14304371"   => "14315371",
        "2017304051" => "2046063051",
        "2319890051" => "2332624051",
        "3305008051" => "3305008051",
        "3333565051" => "3332444051",
        "3037451051" => "3152540051",
        "3450744051" => "3450745051",
        "3445393051" => "3445396051",
        "3036192051" => "3036192051",
        "2113286051" => "2113286051",
        "3684885051" => "3684885051",
        "2632478051" => "2865134051"
    }

    return hash[key]
  end
end
