require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end

    it 'quality of an item is never negative' do
      items = [Item.new('foo', 2, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to be 0
    end

    it "'Aged Brie' actually increases in quality the older it gets" do
      items = [Item.new('Aged Brie', 2, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to be 1
    end

    it 'quality of an item is never more than 50' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 50, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to be 50
    end

    it "'Conjured' items degrade in quality twice as fast as normal items" do
      items = [Item.new('Conjured Mana Cake', 3, 6)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to be 4
    end

    it "'Backstage passes' quality increases by 2 when there are 10 days or less" do
      items = [Item.new(name='Backstage passes to a TAFKAL80ETC concert', 10, 20)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to be 22
    end

    it "'Backstage passes' quality increases by 3 when there are 5 days or less" do
      items = [Item.new(name='Backstage passes to a TAFKAL80ETC concert', 5, 20)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to be 23
    end

    it "'Backstage passes' quality drops to 0 after the concert" do
      items = [Item.new(name='Backstage passes to a TAFKAL80ETC concert', 0, 20)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to be 0
    end

    it "'Sulfuras' never has to be sold or decreases in quality" do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 1, 80)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to be 80
      expect(items[0].sell_in).to be 1
    end

    it "once the sell by date has passed quality degrades twice as fast" do
      items = [Item.new('foo', 0, 2)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to be 0
    end
  end
end
