class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    max_quality = 50

    @items.each do |item|
      if item.name != 'Aged Brie' and item.name != 'Backstage passes to a TAFKAL80ETC concert'
        if item.quality > 0
          if item.name != 'Sulfuras, Hand of Ragnaros'
            item.quality -= 1
            # twice degrade if it 'Conjured' item
            item.quality -= 1 if item.name =~ /Conjured/ && item.quality > 0
          end
        end
      else
        if item.quality < max_quality
          item.quality += 1
          if item.name == 'Backstage passes to a TAFKAL80ETC concert'
            if item.sell_in < 11
              item.quality += 1 if item.quality < max_quality
            end
            if item.sell_in < 6
              item.quality += 1 if item.quality < max_quality
            end
          end
        end
      end

      item.sell_in -= 1 if item.name != 'Sulfuras, Hand of Ragnaros'

      if item.sell_in < 0
        if item.name != 'Aged Brie'
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            if item.quality > 0
              item.quality -= 1 if item.name != 'Sulfuras, Hand of Ragnaros'
            end
          else
            item.quality -= item.quality
          end
        else
          item.quality += 1 if item.quality < max_quality
        end
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
