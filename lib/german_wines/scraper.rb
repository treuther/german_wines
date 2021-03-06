class GermanWines::Scraper

    def self.scrape_wines
        index_page = Nokogiri::HTML(open("https://www.trulyfinewine.com/germanwine"))

        array_of_wines = index_page.css("#itemsBlock div.product-item")

        array_of_wines.each do |wine_card|
            attributes = {
                name: wine_card.css(".name").text,
                url: wine_card.css("a")[0]["href"],
                sub_title: wine_card.css(".product-subtitle").text,
                price: wine_card.css("span.price").text,
                sale: wine_card.css(".sale").text,
                list_price: wine_card.css(".retailprice").text,
                savings: wine_card.css(".savings").text
            }
            wine = GermanWines::Wine.new(attributes)
        end
    end

    def self.scrape_details(wine_object)
        details_page = Nokogiri::HTML(open("https://www.trulyfinewine.com/#{wine_object.url}"))
        # desription = details_page.css("#tab-1 p").text
        # learn_more = details_page.css("#tab-4 p").text
        # tour = details_page.css("#tab-5 p").text
        
        #OBJECT ORIENTED CLI
        #instantiate new details
        wo = GermanWines::Detail.new #wo stands for wine object
        #associate those details with this wine
        #set any detail attributes
        wo.description = details_page.css("#tab-1 p").text
        wo.learn_more = details_page.css("#tab-4 p").text
        wo.tour = details_page.css("#tab-5 p").text
        #add these details to german_wines
        wine_object.add_details(wo)
        #a wine has_many details
    end
end