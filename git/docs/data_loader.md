
The `DataLoader` macros can load static CSV data files at compile-time.

## Defining objects

Data objects are defined in two steps, an enum which represents the ID, and a structure which represents the object.

```haxe
@:build(dex.util.data.DataLoader.buildIdEnum("assets/data/items.csv"))
enum abstract ItemId(Int)
{

}


@datastore("assets/data/items.csv")
typedef Item =
{
    @column(0) var id: ItemId;
    @column(1) var name: String;
    @column(2) var sprite: Hash;
    @column(3) var value: Int;
}
```

Then all items are defined in `items.csv`.

```csv
0,Basic Sword,basic_sword,10
1,Strong Sword,strong_sword,30
```


## Defining a datastore class

```haxe
@:build(dex.util.data.DataLoader.buildDataStore())
class Data
{
    // data-store objects can be either maps...
    static final items: Map<ItemId, Item>;

    // ... or arrays
    static final characters: Array<Character>;

}
```
