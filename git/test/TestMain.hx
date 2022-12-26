package;


@:build(dex.util.data.DataLoader.buildIdEnum("test/data/items.csv"))
enum abstract ItemId(Int)
{

}

@datastore("test/data/items.csv")
typedef Item =
{
    @column(0) var id: ItemId;
    @column(1) var name: String;
    @column(2) var price: Int;
    @column(3) var dmg: Float;
}

@:build(dex.util.data.DataLoader.buildDataStore())
class Data
{
    public static var items: Array<Item>;

    public static var itemsMap: Map<ItemId, Item>;
}


class TestMain
{
    public static function main()
    {
        Data.items;
        Data.itemsMap;
    }
}
