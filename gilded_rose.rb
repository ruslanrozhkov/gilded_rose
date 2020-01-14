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
            decrease_quality(item)
            # twice degrade if it 'Conjured' item
            decrease_quality(item) if item.name =~ /Conjured/ && item.quality > 0
          end
        end
      else
        if item.quality < max_quality
          increase_quality(item)
          if item.name == 'Backstage passes to a TAFKAL80ETC concert'
            if item.sell_in < 11
              increase_quality(item) if item.quality < max_quality
            end
            if item.sell_in < 6
              increase_quality(item) if item.quality < max_quality
            end
          end
        end
      end

      decrease_sell_in(item) if item.name != 'Sulfuras, Hand of Ragnaros'

      if item.sell_in < 0
        if item.name != 'Aged Brie'
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            if item.quality > 0
              decrease_quality(item) if item.name != 'Sulfuras, Hand of Ragnaros'
            end
          else
            item.quality -= item.quality
          end
        else
          increase_quality(item) if item.quality < max_quality
        end
      end
    end
  end

  def decrease_quality(item)
    item.quality -= 1
  end

  def increase_quality(item)
    item.quality += 1
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
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
