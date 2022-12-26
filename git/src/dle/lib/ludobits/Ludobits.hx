package dle.lib.ludobits;


import defold.support.ScriptOnInputAction;
import defold.types.Hash;


/**
    ### ludobits
    https://github.
**/
@:luaRequire("ludobits/m/broadcast")

extern require 
class Ludobits
{
    static function on_message(node: String, action_id: Hash, action: ScriptOnInputAction, type: GuiKeyboardType, empty_text: String): Void;

    static function register(node: String, action_id: Hash, action: ScriptOnInputAction, cb: () -> Void): Void;

    static function send(node: String, action_id: Hash, action: ScriptOnInputAction, value: Bool): Bool;

    static function unregister(node: String, action_id: Hash, action: ScriptOnInputAction, id: String, value: String): String;
}
